#' Line items endpoint (raw and tidy)
#'
#' Get raw and tidy results from the [line items endpoint](https://legacydocs.hubspot.com/docs/methods/line-items/get-all-line-items).
#'
#' @template token_path
#' @template apikey
#' @template properties
#' @template property_history
#' @template max_iter
#' @template max_properties
#' @template offsetvalue
#'
#' @return List with line items data (`hs_lineitems_raw()`)
#' @export
#' @rdname lineitems
#' @examples
#' lineitems <- hs_lineitems_raw(
#'   property_history = "false", max_iter = 1,
#'   max_properties = 10
#' )
#' lineitems_properties <- hs_lineitems_tidy(
#'   lineitems,
#'   view = "properties"
#' )
hs_lineitems_raw <- function(token_path = hubspot_token_get(),
                         apikey = hubspot_key_get(),
                         properties = hs_object_properties_tidy("line_items",
                           hs_object_properties_raw("line_items",
                           token_path = token_path,
                           apikey = apikey
                         )),
                         property_history = "true",
                         max_iter = 10,
                         max_properties = 100,
                         offsetvalue = 0) {

  properties <- head(properties, max_properties)

  query <- c(
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

  lineitems <- get_results_paged(
    path = "/crm-objects/v1/objects/line_items/paged",
    max_iter = max_iter, query = query,
    token_path = token_path,
    apikey = apikey, element = "objects",
    hasmore_name = "hasMore",
    offset_initial = offsetvalue
  )

  purrr::set_names(
    lineitems,
    purrr::map_dbl(lineitems, "objectId")
  )
}

# tidiers -----------------------------------------------------------------

#' @template lineitems
#' @template view
#' @details
#' Required scope(s) of the OAuth token: e-commerce
#'
#' Different `view` values and associated output.
#' * "properties": A tibble containing all properties of line items
#' @rdname lineitems
#'
#' @return A tibble with associated entities (`hs_lineitems_tidy()`)
#' @export
#'

hs_lineitems_tidy <- function(lineitems = hs_lineitems_raw(),
                              view = c("properties")) {

  view <- match.arg(view, c("properties"))

  switch(view,
         "properties" = .lineitem_properties(lineitems))

}


.lineitem_properties <- function(lineitems) {
  lineitems %>%
    purrr::map("properties") %>%
    purrr::modify_depth(2, ~ .$value) %>%
    purrr::map_df(tibble::as_tibble, .id = "vid") %>%
    numeric_converter() %>%
    epoch_converter()
}
