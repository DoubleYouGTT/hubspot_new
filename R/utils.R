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

#' @param path API endpoint path (character)
#' @param apikey API key (character)
#' @param token_path Path to cached token (character)
#' @param query Query parameters (named list)
#' @param element Element to retrieve from API raw results (character)
#' @return A list with the content, \code{NULL} on error 404, \code{NA} on error 500.
#' @noRd
.get_results <- function(path, apikey, token_path,
                         query = NULL, element = NULL) {
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
  if (!is.null(element)) {
    res=res[[element]]
  }
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
#' @param body Query parameters (named list)
#' @param sendfunction Pointer to the httr function to use (POST, PUT, or PATCH)
#' @return A list
#' @noRd
.send_results <- function(path, apikey, token_path,
                          body = NULL, sendfunction=httr::POST) {
  auth <- hubspot_auth(
    token_path = token_path,
    apikey = apikey
  )
  
  # remove NULL elements from the body
  body <- purrr::discard(body, is.null)
  
  # auth
  if (auth$auth == "key") {
    query=list()
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
