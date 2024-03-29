#' Deals endpoint (raw and tidy)
#'
#' @description Get raw and tidy results from the [deals endpoint](https://developers.hubspot.com/docs/methods/deals/get-all-deals).
#'
#' @template token_path
#' @template apikey
#' @template properties
#' @template property_history
#' @template associations
#' @template max_iter
#' @template max_properties
#' @template offsetvalue
#'
#' @return List with deals data (`hs_deals_raw()`)
#' @export
#' @rdname deals
#' @examples \donttest{
#' deals <- hs_deals_raw(
#'   property_history = "false",
#'   max_iter = 1,
#'   max_properties = 10
#' )
#'
#' deals_properties <- hs_deals_tidy(
#'   deals,
#'   view = "properties"
#'   )
#' }
hs_deals_raw <- function(token_path = hubspot_token_get(),
                      apikey = hubspot_key_get(),
                      properties = hs_deal_properties_tidy(
                        hs_deal_properties_raw(
                        token_path,
                        apikey
                      )),
                      property_history = "true",
                      associations = "true",
                      max_iter = 10,
                      max_properties = 100,
                      offsetvalue = 0) {
  query <- c(
    list(
      limit = 250,
      includeAssociations = associations
    ),
    purrr::set_names(
      lapply(properties, function(x) {
        x
      }),
      if (property_history == "true") {
        rep("propertiesWithHistory", length(properties))
      } else {
        rep("properties", length(properties))
      }
    )
  )

  deals <- get_results_paged(
    path = "/deals/v1/deal/paged",
    max_iter = max_iter, query = query,
    token_path = token_path,
    apikey = apikey, element = "deals",
    hasmore_name = "hasMore",
    offset_initial = offsetvalue
  )

  deals <- purrr::set_names(
    deals,
    purrr::map_dbl(deals, "dealId")
  )

  return(deals)
}


# tidiers ---------------------------------------------------------
#' @template deals
#' @template view
#' @details
#' Required scope(s) of the OAuth token: contacts.
#'
#' Different `view` values and associated output.
#' * "associations": A tibble with associated entities
#' * "properties history": A tibble of all field changes over time
#' * "properties": A tibble containing all properties of deals
#' * "stages history": A tibble containing all stages a deal has gone through
#'
#' @return A tibble (`hs_deals_tidy()`)
#' @export
#'
#' @rdname deals
hs_deals_tidy <- function(deals = hs_deals_raw(),
                          view = c("associations", "properties history",
            "properties", "stages history")) {

  view <- match.arg(view, c("associations", "properties history",
                            "properties", "stages history"))

  switch(view,
         "associations" = .deals_associations(deals),
         "properties history" = .deals_properties_history(deals),
         "properties" = .deals_properties(deals),
         "stages history" = .deals_stages_history(deals))

}


.deals_properties_history <- function(deals) {
  deals %>%
    purrr::map("properties") %>%
    purrr::map(purrr::flatten) %>%
    purrr::map("versions") %>%
    purrr::flatten() %>%
    purrr::modify_depth(2, ~ ifelse(length(.) == 0, NA_integer_, .)) %>%
    purrr::map_df(tibble::as_tibble, .id = "dealId") %>%
    epoch_converter()
}

.deals_properties <- function(deals) {
  deals %>%
    purrr::map("properties") %>%
    purrr::modify_depth(2, ~ .$value) %>%
    purrr::map_df(tibble::as_tibble, .id = "dealId") %>%
    numeric_converter() %>%
    epoch_converter()
}


.deals_stages_history <- function(deals) {
  deals %>%
    purrr::map(c("properties", "dealstage", "versions")) %>%
    purrr::flatten() %>%
    purrr::map(head, 4) %>%
    purrr::map_df(tibble::as_tibble, .id = "dealId") %>%
    epoch_converter()
}

.deals_associations <- function(deals) {
  deals %>%
    purrr::map("associations") %>%
    tibble::tibble(Ids = .) %>%
    dplyr::mutate(dealId = names(.data[["Ids"]])) %>%
    tidyr::unnest(cols = c(.data$Ids)) %>%
    dplyr::mutate(dealId = as.integer(.data$dealId)) %>%
    dplyr::mutate(type = rep(
      c("contacts", "companies", "deals", "tickets"), dplyr::n() / 4
    )) %>%
    tidyr::unnest(cols = c(.data$Ids)) %>%
    tidyr::unnest(cols = c(.data$Ids)) %>%
    epoch_converter()
}
