# This file contains the mapping of object specific functions to the generic hs_object_ function
# Joost Kuckartz, joost.kuckartz@iotconsulting.nl
# version 1.0
# December 2021

#######################
# COMPANIES
#######################

#' @rdname getlistv3
hs_get_company_list  <- function(token_path = hubspot_token_get(),
                                 apikey = hubspot_key_get(),
                                 properties = NULL,
                                 max_iter = 10,
                                 max_properties = 100,
                                 offsetvalue = 0) {
  hs_get_object_list("companies", token_path = token_path, apikey = apikey, 
                     properties = properties, max_iter = max_iter, max_properties = max_properties, offsetvalue = offsetvalue)
}

#' @rdname createobjectv3
hs_create_company <- function(properties,
                              token_path = hubspot_token_get(),
                              apikey = hubspot_key_get()) {
  hs_create_object("companies", properties = properties, token_path = token_path, apikey = apikey)
}

#' @rdname getv3
hs_get_company <- function(identifiers,
                           token_path = hubspot_token_get(),
                           apikey = hubspot_key_get(),
                           properties = NULL,
                           max_properties = 100) {
  hs_get_object("companies", identifiers = identifiers, token_path = token_path, apikey = apikey, 
                properties = properties, max_properties = max_properties)
}

#' @rdname updatev3
hs_update_company <- function(identifiers,
                              properties,
                              token_path = hubspot_token_get(),
                              apikey = hubspot_key_get()) {
  hs_update_object("companies", identifiers = identifiers, properties = properties, token_path = token_path, apikey = apikey)
}

#' @rdname deletev3
hs_delete_company <- function(identifiers,
                              token_path = hubspot_token_get(),
                              apikey = hubspot_key_get()) {
  hs_delete_object("companies", identifiers = identifiers, token_path = token_path, apikey = apikey)
}

#' @rdname getassociationsv3
hs_get_company_association  <- function(identifiers_from,
                                        objecttype_to,
                                        token_path = hubspot_token_get(),
                                        apikey = hubspot_key_get(),
                                        max_iter = 10,
                                        offsetvalue = 0) {
  hs_get_object_association("companies", identifiers_from = identifiers_from, objecttype_to = objecttype_to, token_path = token_path, apikey = apikey,
                            max_iter = max_iter, offsetvalue = offsetvalue)
}

#' @rdname createassociationv3
hs_create_company_association <- function(identifiers_from,
                                          objecttype_from,
                                          identifiers_to,
                                          association_type,
                                          token_path = hubspot_token_get(),
                                          apikey = hubspot_key_get()) {
  hs_create_object_association("companies", identifiers_from = identifiers_from, objecttype_from = objecttype_from, association_type = association_type,
                               token_path = token_path, apikey = apikey)
}

#' @rdname deleteassociationv3
hs_delete_company_association <- function(identifiers_from,
                                          objecttype_from,
                                          identifiers_to,
                                          association_type,
                                          token_path = hubspot_token_get(),
                                          apikey = hubspot_key_get()) {
  hs_delete_object_association("companies", identifiers_from = identifiers_from, objecttype_from = objecttype_from, association_type = association_type,
                               token_path = token_path, apikey = apikey)
}

#######################
# CONTACTS
#######################

#' @rdname getlistv3
hs_get_contact_list  <- function(token_path = hubspot_token_get(),
                                 apikey = hubspot_key_get(),
                                 properties = NULL,
                                 max_iter = 10,
                                 max_properties = 100,
                                 offsetvalue = 0) {
  hs_get_object_list("contacts", token_path = token_path, apikey = apikey, 
                     properties = properties, max_iter = max_iter, max_properties = max_properties, offsetvalue = offsetvalue)
}

#' @rdname createobjectv3
hs_create_contact <- function(properties,
                              token_path = hubspot_token_get(),
                              apikey = hubspot_key_get()) {
  hs_create_object("contacts", properties = properties, token_path = token_path, apikey = apikey)
}

#' @rdname getv3
hs_get_contact <- function(identifiers,
                           token_path = hubspot_token_get(),
                           apikey = hubspot_key_get(),
                           properties = NULL,
                           max_properties = 100) {
  hs_get_object("contacts", identifiers = identifiers, token_path = token_path, apikey = apikey, 
                properties = properties, max_properties = max_properties)
}

#' @rdname updatev3
hs_update_contact <- function(identifiers,
                              properties,
                              token_path = hubspot_token_get(),
                              apikey = hubspot_key_get()) {
  hs_update_object("contacts", identifiers = identifiers, properties = properties, token_path = token_path, apikey = apikey)
}

#' @rdname deletev3
hs_delete_contact <- function(identifiers,
                              token_path = hubspot_token_get(),
                              apikey = hubspot_key_get()) {
  hs_delete_object("contacts", identifiers = identifiers, token_path = token_path, apikey = apikey)
}

#' @rdname getassociationsv3
hs_get_contact_association  <- function(identifiers_from,
                                        objecttype_to,
                                        token_path = hubspot_token_get(),
                                        apikey = hubspot_key_get(),
                                        max_iter = 10,
                                        offsetvalue = 0) {
  hs_get_object_association("contacts", identifiers_from = identifiers_from, objecttype_to = objecttype_to, token_path = token_path, apikey = apikey,
                            max_iter = max_iter, offsetvalue = offsetvalue)
}

#' @rdname createassociationv3
hs_create_contact_association <- function(identifiers_from,
                                          objecttype_from,
                                          identifiers_to,
                                          association_type,
                                          token_path = hubspot_token_get(),
                                          apikey = hubspot_key_get()) {
  hs_create_object_association("contacts", identifiers_from = identifiers_from, objecttype_from = objecttype_from, association_type = association_type,
                               token_path = token_path, apikey = apikey)
}

#' @rdname deleteassociationv3
hs_delete_contact_association <- function(identifiers_from,
                                          objecttype_from,
                                          identifiers_to,
                                          association_type,
                                          token_path = hubspot_token_get(),
                                          apikey = hubspot_key_get()) {
  hs_delete_object_association("contacts", identifiers_from = identifiers_from, objecttype_from = objecttype_from, association_type = association_type,
                               token_path = token_path, apikey = apikey)
}

#######################
# DEALS
#######################

#' @rdname getlistv3
hs_get_deal_list  <- function(token_path = hubspot_token_get(),
                              apikey = hubspot_key_get(),
                              properties = NULL,
                              max_iter = 10,
                              max_properties = 100,
                              offsetvalue = 0) {
  hs_get_object_list("deals", token_path = token_path, apikey = apikey, 
                     properties = properties, max_iter = max_iter, max_properties = max_properties, offsetvalue = offsetvalue)
}

#' @rdname createobjectv3
hs_create_deal <- function(properties,
                           token_path = hubspot_token_get(),
                           apikey = hubspot_key_get()) {
  hs_create_object("deals", properties = properties, token_path = token_path, apikey = apikey)
}

#' @rdname getv3
hs_get_deal <- function(identifiers,
                        token_path = hubspot_token_get(),
                        apikey = hubspot_key_get(),
                        properties = NULL,
                        max_properties = 100) {
  hs_get_object("deals", identifiers = identifiers, token_path = token_path, apikey = apikey, 
                properties = properties, max_properties = max_properties)
}

#' @rdname updatev3
hs_update_deal <- function(identifiers,
                           properties,
                           token_path = hubspot_token_get(),
                           apikey = hubspot_key_get()) {
  hs_update_object("deals", identifiers = identifiers, properties = properties, token_path = token_path, apikey = apikey)
}

#' @rdname deletev3
hs_delete_deal <- function(identifiers,
                           token_path = hubspot_token_get(),
                           apikey = hubspot_key_get()) {
  hs_delete_object("deals", identifiers = identifiers, token_path = token_path, apikey = apikey)
}

#' @rdname getassociationsv3
hs_get_deal_association  <- function(identifiers_from,
                                     objecttype_to,
                                     token_path = hubspot_token_get(),
                                     apikey = hubspot_key_get(),
                                     max_iter = 10,
                                     offsetvalue = 0) {
  hs_get_object_association("deals", identifiers_from = identifiers_from, objecttype_to = objecttype_to, token_path = token_path, apikey = apikey,
                            max_iter = max_iter, offsetvalue = offsetvalue)
}

#' @rdname createassociationv3
hs_create_deal_association <- function(identifiers_from,
                                       objecttype_from,
                                       identifiers_to,
                                       association_type,
                                       token_path = hubspot_token_get(),
                                       apikey = hubspot_key_get()) {
  hs_create_object_association("deals", identifiers_from = identifiers_from, objecttype_from = objecttype_from, association_type = association_type,
                               token_path = token_path, apikey = apikey)
}

#' @rdname deleteassociationv3
hs_delete_deal_association <- function(identifiers_from,
                                       objecttype_from,
                                       identifiers_to,
                                       association_type,
                                       token_path = hubspot_token_get(),
                                       apikey = hubspot_key_get()) {
  hs_delete_object_association("deals", identifiers_from = identifiers_from, objecttype_from = objecttype_from, association_type = association_type,
                               token_path = token_path, apikey = apikey)
}

#######################
# LINE ITEMS
#######################

#' @rdname getlistv3
hs_get_line_item_list  <- function(token_path = hubspot_token_get(),
                                   apikey = hubspot_key_get(),
                                   properties = NULL,
                                   max_iter = 10,
                                   max_properties = 100,
                                   offsetvalue = 0) {
  hs_get_object_list("line_items", token_path = token_path, apikey = apikey, 
                     properties = properties, max_iter = max_iter, max_properties = max_properties, offsetvalue = offsetvalue)
}

#' @rdname createobjectv3
hs_create_line_item <- function(properties,
                                token_path = hubspot_token_get(),
                                apikey = hubspot_key_get()) {
  hs_create_object("line_items", properties = properties, token_path = token_path, apikey = apikey)
}

#' @rdname getv3
hs_get_line_item <- function(identifiers,
                             token_path = hubspot_token_get(),
                             apikey = hubspot_key_get(),
                             properties = NULL,
                             max_properties = 100) {
  hs_get_object("line_items", identifiers = identifiers, token_path = token_path, apikey = apikey, 
                properties = properties, max_properties = max_properties)
}

#' @rdname updatev3
hs_update_line_item <- function(identifiers,
                                properties,
                                token_path = hubspot_token_get(),
                                apikey = hubspot_key_get()) {
  hs_update_object("line_items", identifiers = identifiers, properties = properties, token_path = token_path, apikey = apikey)
}

#' @rdname deletev3
hs_delete_line_item <- function(identifiers,
                                token_path = hubspot_token_get(),
                                apikey = hubspot_key_get()) {
  hs_delete_object("line_items", identifiers = identifiers, token_path = token_path, apikey = apikey)
}

#' @rdname getassociationsv3
hs_get_line_item_association  <- function(identifiers_from,
                                          objecttype_to,
                                          token_path = hubspot_token_get(),
                                          apikey = hubspot_key_get(),
                                          max_iter = 10,
                                          offsetvalue = 0) {
  hs_get_object_association("line_items", identifiers_from = identifiers_from, objecttype_to = objecttype_to, token_path = token_path, apikey = apikey,
                            max_iter = max_iter, offsetvalue = offsetvalue)
}

#' @rdname createassociationv3
hs_create_line_item_association <- function(identifiers_from,
                                            objecttype_from,
                                            identifiers_to,
                                            association_type,
                                            token_path = hubspot_token_get(),
                                            apikey = hubspot_key_get()) {
  hs_create_object_association("line_items", identifiers_from = identifiers_from, objecttype_from = objecttype_from, association_type = association_type,
                               token_path = token_path, apikey = apikey)
}

#' @rdname deleteassociationv3
hs_delete_line_item_association <- function(identifiers_from,
                                            objecttype_from,
                                            identifiers_to,
                                            association_type,
                                            token_path = hubspot_token_get(),
                                            apikey = hubspot_key_get()) {
  hs_delete_object_association("line_items", identifiers_from = identifiers_from, objecttype_from = objecttype_from, association_type = association_type,
                               token_path = token_path, apikey = apikey)
}

#######################
# PRODUCTS
#######################

#' @rdname getlistv3
hs_get_product_list  <- function(token_path = hubspot_token_get(),
                                 apikey = hubspot_key_get(),
                                 properties = NULL,
                                 max_iter = 10,
                                 max_properties = 100,
                                 offsetvalue = 0) {
  hs_get_object_list("products", token_path = token_path, apikey = apikey, 
                     properties = properties, max_iter = max_iter, max_properties = max_properties, offsetvalue = offsetvalue)
}

#' @rdname createobjectv3
hs_create_product <- function(properties,
                              token_path = hubspot_token_get(),
                              apikey = hubspot_key_get()) {
  hs_create_object("products", properties = properties, token_path = token_path, apikey = apikey)
}

#' @rdname getv3
hs_get_product <- function(identifiers,
                           token_path = hubspot_token_get(),
                           apikey = hubspot_key_get(),
                           properties = NULL,
                           max_properties = 100) {
  hs_get_object("products", identifiers = identifiers, token_path = token_path, apikey = apikey, 
                properties = properties, max_properties = max_properties)
}

#' @rdname updatev3
hs_update_product <- function(identifiers,
                              properties,
                              token_path = hubspot_token_get(),
                              apikey = hubspot_key_get()) {
  hs_update_object("products", identifiers = identifiers, properties = properties, token_path = token_path, apikey = apikey)
}

#' @rdname deletev3
hs_delete_product <- function(identifiers,
                              token_path = hubspot_token_get(),
                              apikey = hubspot_key_get()) {
  hs_delete_object("products", identifiers = identifiers, token_path = token_path, apikey = apikey)
}

#' @rdname getassociationsv3
hs_get_product_association  <- function(identifiers_from,
                                        objecttype_to,
                                        token_path = hubspot_token_get(),
                                        apikey = hubspot_key_get(),
                                        max_iter = 10,
                                        offsetvalue = 0) {
  hs_get_object_association("products", identifiers_from = identifiers_from, objecttype_to = objecttype_to, token_path = token_path, apikey = apikey,
                            max_iter = max_iter, offsetvalue = offsetvalue)
}

#' @rdname createassociationv3
hs_create_product_association <- function(identifiers_from,
                                          objecttype_from,
                                          identifiers_to,
                                          association_type,
                                          token_path = hubspot_token_get(),
                                          apikey = hubspot_key_get()) {
  hs_create_object_association("products", identifiers_from = identifiers_from, objecttype_from = objecttype_from, association_type = association_type,
                               token_path = token_path, apikey = apikey)
}

#' @rdname deleteassociationv3
hs_delete_product_association <- function(identifiers_from,
                                          objecttype_from,
                                          identifiers_to,
                                          association_type,
                                          token_path = hubspot_token_get(),
                                          apikey = hubspot_key_get()) {
  hs_delete_object_association("products", identifiers_from = identifiers_from, objecttype_from = objecttype_from, association_type = association_type,
                               token_path = token_path, apikey = apikey)
}

#######################
# TICKETS
#######################

#' @rdname getlistv3
hs_get_ticket_list  <- function(token_path = hubspot_token_get(),
                                apikey = hubspot_key_get(),
                                properties = NULL,
                                max_iter = 10,
                                max_properties = 100,
                                offsetvalue = 0) {
  hs_get_object_list("tickets", token_path = token_path, apikey = apikey, 
                     properties = properties, max_iter = max_iter, max_properties = max_properties, offsetvalue = offsetvalue)
}

#' @rdname createobjectv3
hs_create_ticket <- function(properties,
                             token_path = hubspot_token_get(),
                             apikey = hubspot_key_get()) {
  hs_create_object("tickets", properties = properties, token_path = token_path, apikey = apikey)
}

#' @rdname getv3
hs_get_ticket <- function(identifiers,
                          token_path = hubspot_token_get(),
                          apikey = hubspot_key_get(),
                          properties = NULL,
                          max_properties = 100) {
  hs_get_object("tickets", identifiers = identifiers, token_path = token_path, apikey = apikey, 
                properties = properties, max_properties = max_properties)
}

#' @rdname updatev3
hs_update_ticket <- function(identifiers,
                             properties,
                             token_path = hubspot_token_get(),
                             apikey = hubspot_key_get()) {
  hs_update_object("tickets", identifiers = identifiers, properties = properties, token_path = token_path, apikey = apikey)
}

#' @rdname deletev3
hs_delete_ticket <- function(identifiers,
                             token_path = hubspot_token_get(),
                             apikey = hubspot_key_get()) {
  hs_delete_object("tickets", identifiers = identifiers, token_path = token_path, apikey = apikey)
}

#' @rdname getassociationsv3
hs_get_ticket_association  <- function(identifiers_from,
                                       objecttype_to,
                                       token_path = hubspot_token_get(),
                                       apikey = hubspot_key_get(),
                                       max_iter = 10,
                                       offsetvalue = 0) {
  hs_get_object_association("tickets", identifiers_from = identifiers_from, objecttype_to = objecttype_to, token_path = token_path, apikey = apikey,
                            max_iter = max_iter, offsetvalue = offsetvalue)
}

#' @rdname createassociationv3
hs_create_ticket_association <- function(identifiers_from,
                                         objecttype_from,
                                         identifiers_to,
                                         association_type,
                                         token_path = hubspot_token_get(),
                                         apikey = hubspot_key_get()) {
  hs_create_object_association("tickets", identifiers_from = identifiers_from, objecttype_from = objecttype_from, association_type = association_type,
                               token_path = token_path, apikey = apikey)
}

#' @rdname deleteassociationv3
hs_delete_ticket_association <- function(identifiers_from,
                                         objecttype_from,
                                         identifiers_to,
                                         association_type,
                                         token_path = hubspot_token_get(),
                                         apikey = hubspot_key_get()) {
  hs_delete_object_association("tickets", identifiers_from = identifiers_from, objecttype_from = objecttype_from, association_type = association_type,
                               token_path = token_path, apikey = apikey)
}
