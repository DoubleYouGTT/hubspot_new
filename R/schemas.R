#' Schema get one or a list
#'
#' Get a list of custom schemas, or get a single one by name or identifier.
#' @template endpointv3schema
#'
#' @template token_path
#' @template apikey
#'
#' @template returngetschema
#' @export
#' @rdname getschemav3
#' @examples
#' schemas <- hs_get_schema_list()
hs_get_schema_list  <- function(token_path = hubspot_token_get(),
                                apikey = hubspot_key_get()) {

  res <- get_results(
    path = "/crm/v3/schemas",
    query = NULL,
    token_path = token_path,
    apikey = apikey
  )

  map_results(res,mapname="name",element=NULL)
}

#' @template object
#' @export
#' @rdname getschemav3
#' @examples
#' oneschema <- hs_get_schema(
#'   object = "contact"
#' )
hs_get_schema <- function(object,
                          token_path = hubspot_token_get(),
                          apikey = hubspot_key_get()) {
  objecttype=get_object_name(object,token_path,apikey)
  get_results(
    path = paste0("/crm/v3/objects/schemas/",objecttype),
    query = NULL,
    token_path = token_path,
    apikey = apikey
  )
}

#' Schema (custom object) create
#'
#' Define a new custom object schema, along with its properties and associations.
#' @template onlyapi
#'
#' @details
#' When a new custom object is created, the HubSpot API requires you to refer to it
#' through its \code{objectTypeId} or its fully qualified name.
#' The \code{objectTypeId} is defined as \code{{meta-type}-{object_type_id}},
#' where the meta-type is always 2 (portal-specific).
#' The fully qualified name is defined as \code{p{portal_id}_{object_name}}.
#'
#' The functions in this package use an automatic detection system that automatically
#' transform a custom object name (without numerals) to the fully qualified name.
#' When it detects numerals in its object name, it assumes either an \code{objectTypeId}
#' or fully qualified name is provided and does not transform it to a fully
#' qualified name using the \code{portal_id}.
#'
#' To make either the \code{objectTypeId} or fully qualified name yourself, you can store the
#' returned identifier after creation of a custom object to make the \code{objectTypeId}
#' or you can use the \code{portal_id} and the name used in its creation.
#' The \code{portal_id} can be obtained through \code{\link{hs_account_details}()[["portalId"]]}.
#'
#' @template endpointv3schema
#'
#' @param name The schema (custom object) name, using characters only (no numerals).
#' It's common to use lower case only. Cannot be modified after creation.
#' @param singular_label The human-readable object name (label) to use for display in its singular form.
#' Start with capital letter. Cannot be modified after creation.
#' @param plural_label The human-readable object name (label) to use for display in its plural form.
#' Start with capital letter. Cannot be modified after creation.
#' @param properties List of list containing all properties and their related property settings to create.
#' Use \code{\link{hs_build_property}()} to create a set of properties.
#' @template display_properties
#' @template required_properties
#' @template searchable_properties
#' @param associated_objects Vector of object names to associate the custom object with.
#' @template apikey
#'
#' @template returnschema
#' @export
#' @rdname createschemav3
#' @examples
#' \dontrun{
#' proplist=hs_build_property(
#'   name = "make",
#'   label = "Make",
#'   type = "string",
#'   field_type = "text",
#'   description = "The manufacturer of a car"
#' )
#' proplist=hs_build_property(
#'   name = "model",
#'   label = "Model",
#'   type = "string",
#'   field_type = "text",
#'   description = "The model of a car",
#'   mainpropertylist = proplist
#' )
#' schema <- hs_create_schema(
#'   name = "car",
#'   singular_label = "Car",
#'   plural_label = "Cars",
#'   properties = proplist,
#'   display_properties = c("make","model"),
#'   associated_obects = c("contact","deal")
#' )
#' }
hs_create_schema <- function(name,
                             singular_label,
                             plural_label,
                             properties,
                             display_properties,
                             required_properties=NULL,
                             searchable_properties=NULL,
                             associated_objects,
                             apikey = hubspot_key_get()) {

  #query preparation for JSON transformation
  query=list(
    name=name,
    labels=list(singular=singular_label,
                plural=plural_label),
    properties=properties,
    primaryDisplayProperty=display_properties[1]
  )
  if (length(display_properties)>1) {
    query$secondaryDisplayProperties=display_properties[2:length(display_properties)]
    if (length(display_properties)==2) {
      query$secondaryDisplayProperties=list(query$secondaryDisplayProperties)
    }
  }
  if (!is.null(required_properties)){
    query$requiredProperties=required_properties
    if (length(required_properties)==1)
      query$requiredProperties=list(required_properties)
  }
  if (!is.null(searchable_properties)) {
    query$searchable_properties=searchable_properties
    if (length(searchable_properties)==1)
      query$searchable_properties=list(searchable_properties)
  }
  query$associatedObjects=associated_objects
  if (length(associated_objects)==1)
    query$associatedObjects=list(searchable_properties)
  #end query preparation

  send_results(
    path = "/crm/v3/schemas",
    apikey = apikey,
    token_path = NULL,
    body = query,
    sendfunction=httr::POST
  )
}

#' @export
#' @rdname createschemav3
hs_create_custom_object <- hs_create_schema


#' Schema update
#'
#' Update the details for an existing object schema.
#' Can only update the display, required, and searchable properties.
#' To add new properties to an object schema, use \code{\link{hs_create_property}}.
#' To add new associations to an object schema, use \code{\link{hs_create_schema_association}}.
#' @template onlyapi
#' @template endpointv3schema
#'
#' @template object
#' @template display_properties
#' @template required_properties
#' @template searchable_properties
#' @template token_path
#' @template apikey
#'
#' @template returnschema
#' @export
#' @rdname updateschemav3
#' @examples
#' \dontrun{
#' schema <- hs_update_schema(
#'   object = "car",
#'   display_properties = c("make","model","year")
#' )
#' }
hs_update_schema <- function(object,
                             display_properties=NULL,
                             required_properties=NULL,
                             searchable_properties=NULL,
                             token_path = hubspot_token_get(),
                             apikey = hubspot_key_get()) {

  objecttype=get_object_name(object,token_path,apikey)

  #build query
  query=list(
    name=objecttype
  )
  if (!is.null(display_properties)) {
    query$primaryDisplayProperty=display_properties[1]
    if (length(display_properties)>1) {
      query$secondaryDisplayProperties=display_properties[2:length(display_properties)]
      if (length(display_properties)==2) {
        query$secondaryDisplayProperties=list(query$secondaryDisplayProperties)
      }
    }
  }
  if (!is.null(required_properties)){
    query$requiredProperties=required_properties
    if (length(required_properties)==1)
      query$requiredProperties=list(required_properties)
  }
  if (!is.null(searchable_properties)) {
    query$searchable_properties=searchable_properties
    if (length(searchable_properties)==1)
      query$searchable_properties=list(searchable_properties)
  }
  #end query

  if (all(names(query)=="name"))
    return(NULL)

  send_results(
    path = paste0("/crm/v3/objects/schemas/",objecttype),
    body = query,
    token_path = NULL,
    apikey = apikey,
    sendfunction = httr::PATCH
  )
}


#' Schema delete
#'
#' Delete an object schema. Deletion is only possible after all instances of
#' the object has been deleted.
#' @template onlyapi
#' @template endpointv3schema
#'
#' @template object
#' @param harddelete Logical. Set to \code{TRUE} to hard-delete the schema, so that
#' a new custom object can be made with with the same name. Recommended to use,
#' otherwise the custom object might linger around (and an account has a maximum
#' of 10 custom objects). Default=\code{FALSE}.
#' @template token_path
#' @template apikey
#'
#' @template returndelete
#' @export
#' @rdname deleteschemav3
#' @examples
#' \dontrun{
#' oneschema <- hs_delete_schema(
#'   object = "car"
#' )
#' }
hs_delete_schema <- function(object,
                             harddelete = FALSE,
                             token_path = hubspot_token_get(),
                             apikey = hubspot_key_get()) {

  objecttype=get_object_name(object,token_path,apikey)

  send_results(
    path = paste0("/crm/v3/objects/schemas/",objecttype),
    query = list(archived=harddelete),
    body = NULL,
    token_path = token_path,
    apikey = apikey,
    sendfunction = httr::DELETE
  )
}



#' Schema create association
#'
#' Associate a schema with another object.
#' @template onlyapi
#' @template endpointv3schema
#'
#' @template object
#' @template association_objecttype
#' @template association_typemake
#' @template token_path
#' @template apikey
#'
#' @template returngetassociation
#' @export
#' @rdname createschemaassociationv3
#' @examples
#' \dontrun{
#' association <- hs_create_schema_association(
#'   object = "car",
#'   association_objecttype = "contact"
#' )
#' }
hs_create_schema_association <- function(object,
                                         association_objecttype,
                                         association_type = NULL,
                                         token_path = hubspot_token_get(),
                                         apikey = hubspot_key_get()) {

  objecttype=get_object_name(object,token_path,apikey)
  associationname=get_object_name(association_objecttype,token_path,apikey)

  query=list(
    fromObjectTypeId=objecttype,
    toObjectTypeId=associationname
  )
  if (!is.null(association_type))
    query$name=association_type

  send_results(
    path = paste0("/crm/v3/schemas/",objecttype,"/associations"),
    body = query,
    apikey = apikey,
    token_path = token_path,
    sendfunction=httr::POST
  )
}

#' schema delete association
#'
#' Remove an association between the schema and another object.
#' @template onlyapi
#' @template endpointv3schema
#'
#' @template object
#' @template association_objecttype
#' @template token_path
#' @template apikey
#'
#' @template returndeleteassociation
#' @export
#' @rdname deleteschemaassociationv3
#' @examples
#' \dontrun{
#' result <- hs_delete_schema_association(
#'   object = "car",
#'   association_objecttype = "contact"
#' )
#' }
hs_delete_schema_association <- function(object,
                                         association_objecttype,
                                         token_path = hubspot_token_get(),
                                         apikey = hubspot_key_get()) {

  objecttype=get_object_name(object,token_path,apikey)
  associationname=get_object_name(association_objecttype,token_path,apikey)

  send_results(
    path = paste0("/crm/v3/schemas/",objecttype,"/associations/",associationname),
    body = NULL,
    token_path = token_path,
    apikey = apikey,
    sendfunction = httr::DELETE
  )
}
