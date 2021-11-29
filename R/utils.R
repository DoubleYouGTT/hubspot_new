#' API base URL
#' @return API base URL (character)
#' @noRd
base_url <- function() {
  "https://api.hubapi.com"
}

#' @param path An API endpoint path
#' @return The URL to that API endpoint (character)
#' @noRd
get_path_url <- function(path) {
  httr::modify_url(base_url(),
    path = path
  )
}

#' Split a vector or list into chunks of a provided length.
#' @param x The vector or list to split
#' @param n The maximum length the vector or list is allowed to be.
#' @return Vector or list split into chunks, as unnamed lists.
#' @noRd
chunk <- function(x,n) split(x, ceiling(seq_along(x)/n))

#' @param name The (plain) name of the object (character)
#' @param apikey API key (character)
#' @param token_path Path to cached token (character)
#' @return The object name as how it is (most likely) stored in HubSpot.
#' @noRd
get_object_name <- function(name,
                            token_path = hubspot_token_get(),
                            apikey = hubspot_key_get()) {
  #return when it already has numerics in it (could be objectTypeId or fully qualified name already)
  if (grepl("\\d", name))
    return(name)
  #check if name is part of common ones
  if (name %in% c("contact","company","deal","ticket","product"))
    return(name)
  #if not, make it the fully qualified name (custom object)
  return(paste0("p",hubspot_portalid(token_path=token_path,apikey=apikey),"_",name))
}

#' @param path API endpoint path (character)
#' @param apikey API key (character)
#' @param token_path Path to cached token (character)
#' @param query Query parameters (named list)
#' @return A list with the content, \code{NULL} on error 404, \code{NA} on error 500.
#' @noRd
.get_results <- function(path, apikey, token_path, query = NULL) {
  auth <- hubspot_auth(
    token_path = token_path,
    apikey = apikey
  )

  # remove NULL elements from the query
  query <- purrr::discard(query, is.null)

  # auth
  if (auth$auth == "key") {
    query$hapikey <- auth$value
    res <- httr::GET(get_path_url(path),
      query = query,
      httr::user_agent("hubspot R package by DoubleYoUGTT")
    )
  } else {
    token <- readRDS(auth$value)

    token <- check_token(token, file = auth$value)

    res <- httr::GET(get_path_url(path),
      query = query,
      httr::config(httr::user_agent("hubspot R package by DoubleYoUGTT"),
        token = token
      )
    )
  }
  httr::warn_for_status(res)
  if (res$status_code==404) {
    return(NULL)
  } else if (res$status_code==500) {
    return(NA)
  }
  res=httr::content(res)
  return(res)
}

get_results <- ratelimitr::limit_rate(
  .get_results,
  ratelimitr::rate(100, 10)
)

#' @param path API endpoint path (character)
#' @param apikey API key (character)
#' @param query Query parameters (named list)
#' @param max_iter Maximal number of iterations (integer)
#' @param element Element to retrieve from API raw results (character)
#' @param hasmore_name Name of the has-more parameter for the API
#'                     endpoint (character)
#' @param offset_name_in Name of the offset parameter to send to the API
#' @param offset_name_out Name of the offset parameter returned
#' @param offset_initial Initial offset value for the offset parameter
#' @return A list
#' @noRd
get_results_paged <- function(path, token_path, apikey, query = NULL,
                              max_iter = max_iter, element,
                              hasmore_name = "hasMore",
                              offset_name_in = "offset",
                              offset_name_out = "offset",
                              offset_initial = 0) {
  results <- list()
  n <- 0
  do <- TRUE
  offset <- offset_initial
  
  while (do & n < max_iter) {
    query[[offset_name_in]] <- offset
    
    res_content <- get_results(
      path = path,
      token_path = token_path,
      apikey = apikey,
      query = query
    )
    if (!is.null(res_content)) {                  #can't access data when no content returned
      if (!is.na(res_content[1])) {
        n <- n + 1
        
        results[n] <- list(res_content[[element]])
        do <- res_content[[hasmore_name]]
        offset <- res_content[[offset_name_out]]
        
        if (is.null(do))
          do=FALSE
      } else {
        message("Retrying after server error...")
      }
    } else {
      do=FALSE                                    #break loop on error 404
    }
  }
  
  results <- purrr::flatten(results)
  
  return(results)
}

#' @param path API endpoint path (character)
#' @param apikey API key (character)
#' @param token_path Path to cached token (character)
#' @param body Body parameters (named list)
#' @param query Query parameters (named list)
#' @param sendfunction Pointer to the httr function to use (POST, PUT, or PATCH)
#' @return A list
#' @noRd
.send_results <- function(path, apikey, token_path,
                          body = NULL, query = NULL, sendfunction=httr::POST) {
  auth <- hubspot_auth(
    token_path = token_path,
    apikey = apikey
  )
  
  # remove NULL elements from the body and query
  body <- purrr::discard(body, is.null)
  query <- purrr::discard(query, is.null)
  
  # auth
  if (auth$auth == "key") {
    query$hapikey <- auth$value   
    res <- sendfunction(get_path_url(path),
                        query = query,
                        body = body,
                        encode = "json",
                        httr::user_agent("hubspot R package by DoubleYouGTT")
    )
  } else {
    token <- readRDS(auth$value)
    
    token <- check_token(token, file = auth$value)
    
    res <- sendfunction(get_path_url(path),
                        body = body,
                        encode = "json",
                        httr::config(httr::user_agent("hubspot R package by DoubleYouGTT"),
                                     token = token
                        )
    )
  }
  httr::warn_for_status(res)
  res %>% httr::content()
}

send_results <- ratelimitr::limit_rate(
  .send_results,
  ratelimitr::rate(100, 10)
)

#' @param rawresults Resulting list from a call to \code{get_results} or \code{send_results}
#' @param mapname Element that constitutes the mapping to list names (character)
#' @param element Element to extract from raw results (character)
#' @return A list with the content, \code{NULL} on error 404, \code{NA} on error 500.
#' @noRd
map_results <- function(rawresult, mapname="id", element=NULL) {
  if (!is.null(rawresult)) {
    if (!is.na(rawresult[1])) {
      if (!is.null(element)) {
        rawresult=rawresult[[element]]
      }
      rawresult=purrr::set_names(
        rawresult,
        as.double(purrr::map(rawresult, mapname))
      )
    }
  }
  return(rawresult)
}

check_token <- function(token, file) {
  info <- httr::GET(get_path_url(
    glue::glue("/oauth/v1/access-tokens/{
               token$credentials$access_token}")
  )) %>%
    httr::content()

  if ("message" %in% names(info)) {
    if (grepl("expired", info$message)) {
      token$refresh()
      saveRDS(token, file)
    }
  }

  if ("expires_in" %in% names(info)) {
    if (info$expires_in < 60) {
      token$refresh()
      saveRDS(token, file)
    }
  }


  token
}


