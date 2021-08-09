#' Object properties endpoint (raw and tidy)
#'
#' Retrieve raw and tidy results from [the object properties endpoint](https://legacydocs.hubspot.com/docs/methods/crm-properties/get-properties).
#'
#' @template objectname
#' @template token_path
#' @template apikey
#' @rdname object-properties
#' @return List of object properties (`hs_object_properties_raw()`)
#' @export
#' @examples
#' properties <- hs_object_properties_raw("tickets")
#' property_names <- hs_object_properties_tidy("tickets", properties, view = "names")
hs_object_properties_raw <- function(objectname,
                                      token_path = hubspot_token_get(),
                                      apikey = hubspot_key_get()) {

  get_results(
    path = paste0("/properties/v2/",objectname,"/properties"),
    apikey = apikey,
    token_path = token_path
  )
}

# tidiers ---------------------------------------------------------
#' @template objectname
#' @template object_properties
#' @template view
#' @details
#' Required scope(s) of the OAuth token: contacts.
#'
#' Different `view` values and associated output.
#' * "names": A character vector of the names of available object properties.
#'
#' @return Something tidy (`hs_object_properties_tidy()`)
#' @export
#'
#' @rdname object-properties
hs_object_properties_tidy <- function(objectname,
                                       object_properties = NULL,
                                       view = "names") {

  view <- match.arg(view, c("names"))

  if(is.null(object_properties))
    object_properties=hs_object_properties_raw(objectname)
  
  switch(view,
         "names" = .object_properties_names(object_properties))

}

.object_properties_names <- function(object_properties) {
  object_properties %>%
    purrr::map_chr("name")
}

