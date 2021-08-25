#' Products endpoint (raw and tidy)
#'
#' Get raw and tidy results from the [products endpoint](https://legacydocs.hubspot.com/docs/methods/products/get-all-products).
#'
#' @template token_path
#' @template apikey
#' @template properties
#' @template property_history
#' @template max_iter
#' @template max_properties
#' @template offsetvalue
#'
#' @return List with products data (`hs_products_raw()`)
#' @export
#' @rdname products
#' @examples
#' products <- hs_products_raw(
#'   property_history = "false", max_iter = 1,
#'   max_properties = 10
#' )
#' products_properties <- hs_products_tidy(
#'   products,
#'   view = "properties"
#' )
hs_products_raw <- function(token_path = hubspot_token_get(),
                         apikey = hubspot_key_get(),
                         properties = hs_object_properties_tidy("products",
                           hs_object_properties_raw("products",
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

  products <- get_results_paged(
    path = "/crm-objects/v1/objects/products/paged",
    max_iter = max_iter, query = query,
    token_path = token_path,
    apikey = apikey, element = "objects",
    hasmore_name = "hasMore",
    offset_initial = offsetvalue
  )

  purrr::set_names(
    products,
    purrr::map_dbl(products, "objectId")
  )
}

# tidiers -----------------------------------------------------------------

#' @template products
#' @template view
#' @details
#' Required scope(s) of the OAuth token: e-commerce
#'
#' Different `view` values and associated output.
#' * "properties": A tibble containing all properties of products
#' @rdname products
#'
#' @return A tibble with associated entities (`hs_products_tidy()`)
#' @export
#'

hs_products_tidy <- function(products = hs_products_raw(),
                              view = c("properties")) {

  view <- match.arg(view, c("properties"))

  switch(view,
         "properties" = .products_properties(products))

}


.products_properties <- function(products) {
  products %>%
    purrr::map("properties") %>%
    purrr::modify_depth(2, ~ .$value) %>%
    purrr::map_df(tibble::as_tibble, .id = "vid") %>%
    numeric_converter() %>%
    epoch_converter()
}
