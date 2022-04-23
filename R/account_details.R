#' Get account details
#'
#' Get the account details for the API key or OAuth token.
#' @template token_path
#' @template apikey
#'
#' @export
#' @examples
#' account <- hs_account_details()
hs_account_details <- memoise::memoise(function(token_path = hubspot_token_get(),
                                                apikey = hubspot_key_get()) {

  get_results(
    path = "/integrations/v1/me",
    query = NULL,
    token_path = token_path,
    apikey = apikey
  )
})
