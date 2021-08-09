#' Tickets endpoint (raw and tidy)
#'
#' Get raw and tidy results from the [tickets endpoint](https://legacydocs.hubspot.com/docs/methods/tickets/get-all-tickets).
#'
#' @template token_path
#' @template apikey
#' @template properties
#' @template property_history
#' @template max_iter
#' @template max_properties
#' @template offsetvalue
#'
#' @return List with tickets data (`hs_tickets_raw()`)
#' @export
#' @rdname tickets
#' @examples
#' tickets <- hs_tickets_raw(
#'   property_history = "false", max_iter = 1,
#'   max_properties = 10
#' )
#' tickets_properties <- hs_tickets_tidy(
#'   tickets,
#'   view = "properties"
#' )
hs_tickets_raw <- function(token_path = hubspot_token_get(),
                         apikey = hubspot_key_get(),
                         properties = hs_object_properties_tidy(
                           hs_object_properties_raw("tickets",
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

  tickets <- get_results_paged(
    path = "/crm-objects/v1/objects/tickets/paged",
    max_iter = max_iter, query = query,
    token_path = token_path,
    apikey = apikey, element = "objects",
    hasmore_name = "hasMore",
    offset_initial = offsetvalue
  )

  purrr::set_names(
    tickets,
    purrr::map_dbl(tickets, "objectId")
  )
}

# tidiers -----------------------------------------------------------------

#' @template tickets
#' @template view
#' @details
#' Required scope(s) of the OAuth token: tickets.
#'
#' Different `view` values and associated output.
#' * "properties": A tibble containing all properties of tickets
#' @rdname tickets
#'
#' @return A tibble with associated entities (`hs_tickets_tidy()`)
#' @export
#'

hs_tickets_tidy <- function(tickets = hs_tickets_raw(),
                              view = c("properties")) {

  view <- match.arg(view, c("properties"))

  switch(view,
         "properties" = .tickets_properties(tickets))

}


.tickets_properties <- function(tickets) {
  tickets %>%
    purrr::map("properties") %>%
    purrr::modify_depth(2, ~ .$value) %>%
    purrr::map_df(tibble::as_tibble, .id = "vid") %>%
    numeric_converter() %>%
    epoch_converter()
}
