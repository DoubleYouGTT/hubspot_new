#' Companies endpoint (raw and tidy)
#'
#' @description Get raw and tidy results from [the companies endpoint](https://developers.hubspot.com/docs/methods/companies/get-all-companies).
#'
#' @template token_path
#' @template apikey
#' @template properties
#' @template property_history
#' @template max_iter
#' @template max_properties
#' @template offsetvalue
#' 
#' @return List with company data (`hs_companies_raw()`)
#' @rdname companies
#' @export
#' @examples
#' \donttest{
#' companies <- hs_companies_raw(
#'   property_history = "false", max_iter = 1,
#'   max_properties = 10
#' )
#' companies_properties <- hs_companies_tidy(
#'   companies,
#'   view = "properties"
#' )
#' }
hs_companies_raw <- function(token_path = hubspot_token_get(),
                          apikey = hubspot_key_get(),
                          properties = hs_company_properties_tidy(
                            hs_company_properties_raw(
                            token_path,
                            apikey
                          )),
                          property_history = "true",
                          max_iter = 10,
                          max_properties = 100,
                          offsetvalue = 0) {
  properties <- head(properties, max_properties)

  query <- c(
    list(
      limit = 250
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

  companies <- get_results_paged(
    path = "/companies/v2/companies/paged",
    max_iter = max_iter, query = query,
    token_path = token_path,
    apikey = apikey, element = "companies",
    hasmore_name = "has-more",
    offset_initial = offsetvalue
  )

  companies <- purrr::set_names(
    companies,
    purrr::map_dbl(companies, "companyId")
  )

  return(companies)
}

# tidiers -----------------------------------------------------------------

#' @template companies
#' @template view
#' @details
#' Required scope(s) of the OAuth token: contacts.
#'
#' Different `view` values and associated output.
#' * "properties": A tibble containing all properties of companies
#'
#' @export
#'
#' @rdname companies
#'
#' @return A tibble with associated entities (`hs_companies_tidy()`)
#' @export
#'

hs_companies_tidy <- function(companies = hs_companies_raw(),
                              view = c("properties")) {

  view <- match.arg(view, c("properties"))

  switch(view,
         "properties" = .company_properties(companies))

}


.company_properties <- function(companies) {
  companies %>%
    purrr::map("properties") %>%
    purrr::modify_depth(2, ~ .$value) %>%
    purrr::map_df(tibble::as_tibble, .id = "companyId") %>%
    numeric_converter() %>%
    epoch_converter()
}
