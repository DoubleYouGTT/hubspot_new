# This file contains the mapping of custom functions to the generic hs_object_properties_ function
# Joost Kuckartz, joost.kuckartz@iotconsulting.nl
# version 1.0
# December 2021

#######################
# COMPANIES
#######################

#' @rdname object-properties
hs_company_properties_raw <- function(token_path = hubspot_token_get(),
                                      apikey = hubspot_key_get()) {
  hs_object_properties_raw("companies",token_path = token_path, apikey = apikey)
}

#' @rdname object-properties
hs_company_properties_tidy <- function(company_properties = hs_company_properties_raw(),
                                       view = "names") {
  hs_object_properties_tidy("companies",object_properties = company_properties, view = view)
}

#######################
# CONTACTS
#######################

#' @rdname object-properties
hs_contact_properties_raw <- function(token_path = hubspot_token_get(),
                                      apikey = hubspot_key_get()) {
  hs_object_properties_raw("contacts",token_path = token_path, apikey = apikey)
}

#' @rdname object-properties
hs_contact_properties_tidy <- function(contact_properties = hs_contact_properties_raw(),
                                       view = "names") {
  hs_object_properties_tidy("contacts",object_properties = contact_properties, view = view)
}

#######################
# DEALS
#######################

#' @rdname object-properties
hs_deal_properties_raw <- function(token_path = hubspot_token_get(),
                                      apikey = hubspot_key_get()) {
  hs_object_properties_raw("deals",token_path = token_path, apikey = apikey)
}

#' @rdname object-properties
hs_deal_properties_tidy <- function(deal_properties = hs_deal_properties_raw(),
                                       view = "names") {
  hs_object_properties_tidy("deals",object_properties = deal_properties, view = view)
}

#######################
# PRODUCTS
#######################

#' @rdname object-properties
hs_product_properties_raw <- function(token_path = hubspot_token_get(),
                                   apikey = hubspot_key_get()) {
  hs_object_properties_raw("products",token_path = token_path, apikey = apikey)
}

#' @rdname object-properties
hs_product_properties_tidy <- function(product_properties = hs_product_properties_raw(),
                                    view = "names") {
  hs_object_properties_tidy("products",object_properties = product_properties, view = view)
}

#######################
# TICKETS
#######################

#' @rdname object-properties
hs_ticket_properties_raw <- function(token_path = hubspot_token_get(),
                                      apikey = hubspot_key_get()) {
  hs_object_properties_raw("tickets",token_path = token_path, apikey = apikey)
}

#' @rdname object-properties
hs_ticket_properties_tidy <- function(ticket_properties = hs_ticket_properties_raw(),
                                       view = "names") {
  hs_object_properties_tidy("tickets",object_properties = ticket_properties, view = view)
}

