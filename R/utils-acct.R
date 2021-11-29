#' Account timezone
#' @return Timezone (character)
#' @noRd
hubspot_tz <- function(token_path = hubspot_token_get(),
                       apikey = hubspot_key_get()) {
  hs_account_details(token_path = token_path,
                     apikey = apikey
  )[["timeZone"]]
}

#' Account portal id
#' @return Portal id (character)
#' @noRd
hubspot_portalid <- function(token_path = hubspot_token_get(),
                       apikey = hubspot_key_get()) {
  hs_account_details(token_path = token_path,
                     apikey = apikey
  )[["portalId"]]
}