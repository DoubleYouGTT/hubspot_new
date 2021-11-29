#' Product get list
#'
#' Get a list of products.
#' @template endpointv3product
#'
#' @template token_path
#' @template apikey
#' @template properties
#' @template max_iter
#' @template max_properties
#' @template offsetvalue
#'
#' @template returngetobject
#' @export
#' @rdname getlistv3
#' @examples
#' products <- hs_get_product_list(
#'   max_iter = 1,
#'   max_properties = 10
#' )
hs_get_product_list  <- function(token_path = hubspot_token_get(),
                                 apikey = hubspot_key_get(),
                                 properties = hs_object_properties_tidy("products",
                                   hs_object_properties_raw("products",
                                                            token_path = token_path,
                                                            apikey = apikey
                                   )),
                                 max_iter = 10,
                                 max_properties = 100,
                                 offsetvalue = 0) {

  properties <- head(properties, max_properties)

  query <- c(
    list(
      limit = 100
    ),
    purrr::set_names(
      lapply(properties, function(x) {
        x
      }),
      rep("properties", length(properties))
    )
  )

  res <- get_results_paged(
    path = "/crm/v3/objects/products",
    max_iter = max_iter,
    query = query,
    token_path = token_path,
    apikey = apikey,
    element = "results",
    hasmore_name = "after",
    offset_name_in = "after",
    offset_name_out = "after",
    offset_initial = offsetvalue
  )

  map_results(res,mapname="id",element=NULL)
}


#' Product create
#' 
#' Create one or more products with the given properties and return a copy of the object(s), including identifier(s).
#' @template endpointv3product
#' 
#' @template propertiesmake
#' @template token_path
#' @template apikey
#' 
#' @template returncreateobject
#' @export
#' @rdname createobjectv3
#' @examples
#' \dontrun{
#' oneproduct <- hs_create_product(
#'   properties = list(name="New product",
#'                     description="Awesome product for everyone")
#' )
#' twoproducts <- hs_create_product(
#'   properties = list(list(name="First product",
#'                          description="Awesome product for everyone"),
#'                     list(name="Second product",
#'                          description="Even better product for everyone")
#'                    )
#' )
#' }
hs_create_product <- function(properties,
                              token_path = hubspot_token_get(),
                              apikey = hubspot_key_get()) {
  
  #in case we simple send one
  if (length(properties)==1)
    properties=properties[[1]]
  
  if (!is.null(names(properties))) {                         #single object
    query <- c(
      list(
        properties = properties
      )
    )
    
    send_results(
      path = "/crm/v3/objects/products",
      apikey = apikey,
      token_path = token_path,
      body = query,
      sendfunction=httr::POST
    )
  } else {                                                  #multiple objects
    query=list(inputs=lapply(properties, function(x) { list(properties=x) }))
    
    res=send_results(
      path = "/crm/v3/objects/products/batch/create",
      apikey = apikey,
      token_path = token_path,
      body = query,
      sendfunction=httr::POST
    )
    map_results(res,mapname="id",element="results")
  }
}

#' Product get by id
#' 
#' Get one or more products.
#' @template endpointv3product
#'
#' @template identifiers
#' @template token_path
#' @template apikey
#' @template properties
#' @template max_properties
#'
#' @template returngetobject
#' @export
#' @rdname getv3
#' @examples
#' \dontrun{
#' oneproduct <- hs_get_product(
#'   identifiers = 1
#' )
#' twoproducts <- hs_get_product(
#'   identifiers = c(1,2)
#' )
#' }
hs_get_product <- function(identifiers,
                           token_path = hubspot_token_get(),
                           apikey = hubspot_key_get(),
                           properties = hs_object_properties_tidy("products",
                                                                  hs_object_properties_raw("products",
                                                                                           token_path = token_path,
                                                                                           apikey = apikey
                                                                  )),
                           max_properties = 100) {
  
  properties <- head(properties, max_properties)
  
  if (length(identifiers)==1) {                               #single object
    query <- c(
      purrr::set_names(
        lapply(properties, function(x) {
          x
        }),
        rep("properties", length(properties))
      )
    )
    
    get_results(
      path = paste0("/crm/v3/objects/products/",identifiers),
      query = query,
      token_path = token_path,
      apikey = apikey
    )
  } else {                                                    #multiple objects
    query=list(properties=properties,
               inputs=lapply(identifiers, function(x) { list(id=x) }))
    
    res=send_results(
      path = "/crm/v3/objects/products/batch/read",
      body = query,
      token_path = token_path,
      apikey = apikey,
      sendfunction = httr::POST
    )
    map_results(res,mapname="id",element="results")
  }
}

#' Product update
#' 
#' Update one or more products.
#' @template explain_update
#' @template endpointv3product
#'
#' @template identifiers
#' @template propertiesmake
#' @template token_path
#' @template apikey
#'
#' @template returncreateobject
#' @export
#' @rdname updatev3
#' @examples
#' \dontrun{
#' oneproduct <- hs_update_product(
#'   identifiers = 1,
#'   properties = list(name="New product",
#'                     description="Awesome product for everyone")
#' )
#' twoproducts <- hs_update_product(
#'   identifiers = c(1,2),
#'   properties = list(list(name="First product",
#'                          description="Awesome product for everyone"),
#'                     list(name="Second product",
#'                          description="Even better product for everyone")
#'                    )
#' )
#' }
hs_update_product <- function(identifiers,
                              properties,
                              token_path = hubspot_token_get(),
                              apikey = hubspot_key_get()) {

  if (length(identifiers)!=length(properties)) {
    stop("Length of identifiers and properties are not equal!")
  }
  if (length(identifiers)==1) {                               #single object
    query <- c(
      list(
        properties = properties
      )
    )
    
    send_results(
      path = paste0("/crm/v3/objects/products/",identifiers),
      body = query,
      token_path = token_path,
      apikey = apikey,
      sendfunction = httr::PATCH
    )
  } else {                                                    #multiple objects
    #original
    # query=lapply(properties, function(x) { list(properties=x) })
    # for (i in 1:length(identifiers)) {
    #   query[[i]]$id=identifiers[i]
    # }
    # query=list(inputs=query)
    # 
    # res=send_results(
    #   path = "/crm/v3/objects/products/batch/update",
    #   body = query,
    #   token_path = token_path,
    #   apikey = apikey,
    #   sendfunction = httr::POST
    # )
    # map_results(res,mapname="id",element="results")
    #end original
    
    results <- list()
    idchunks=chunk(identifiers, 100)
    propchunks=chunk(properties, 100)
    for (i in 1:length(idchunks)) {
      identifiers=idchunks[[i]]
      properties=propchunks[[i]]
      
      query=lapply(properties, function(x) { list(properties=x) })
      for (i in 1:length(identifiers)) {
        query[[i]]$id=identifiers[i]
      }
      query=list(inputs=query)
      
      res=send_results(
        path = "/crm/v3/objects/products/batch/update",
        body = query,
        token_path = token_path,
        apikey = apikey,
        sendfunction = httr::POST
      )
      if (!is.null(res)) {                                    #can't access data when no content returned
        if (!is.na(res[1])) {
          results[i] <- list(res[["results"]])
        }
      }
    }
    results <- purrr::flatten(results)
    map_results(results,mapname="id")
  }
}


#' Product delete
#' 
#' Delete one or multiple products.
#' @template endpointv3product
#'
#' @template identifiers
#' @template token_path
#' @template apikey
#'
#' @template returndelete
#' @export
#' @rdname deletev3
#' @examples
#' \dontrun{
#' oneproduct <- hs_delete_product(
#'   identifiers = 1
#' )
#' twoproducts <- hs_delete_product(
#'   identifiers = c(1,2)
#' )
#' }
hs_delete_product <- function(identifiers,
                              token_path = hubspot_token_get(),
                              apikey = hubspot_key_get()) {
  
  if (length(identifiers)==1) {                               #one object
    send_results(
      path = paste0("/crm/v3/objects/products/",identifiers),
      body = NULL,
      token_path = token_path,
      apikey = apikey,
      sendfunction = httr::DELETE
    )
  } else {                                                    #multiple objects
    query=list(inputs=lapply(identifiers, function(x) { list(id=x) }))
    
    send_results(
      path = "/crm/v3/objects/products/batch/archive",
      body = query,
      token_path = token_path,
      apikey = apikey,
      sendfunction = httr::POST
    )
  }
}

#' Product filter, sort, search

#TO DO
#https://developers.hubspot.com/docs/api/crm/search
#create filter groups (group OR group)
#create filters (propertyName, operator, value) (filter AND filter)
#sorting (propertyName, direction) (one rule only)
#searching (query)

#' Product get associations (single)
#' 
#' Get a list of associations a single product has.
#' According to HubSpot, products don't have any (default) associations.
#' @template endpointv3product
#'
#' @template identifier
#' @template association_objecttype
#' @template token_path
#' @template apikey
#' @template max_iter
#' @template max_properties
#' @template offsetvalue
#'
#' @template returngetassociation
#' @export
#' @rdname getassociationsv3
#' @examples
#' \dontrun{
#' associations <- hs_get_product_association(
#'   max_iter = 1,
#'   association_objecttype = "contact"
#' )
#' }
hs_get_product_association  <- function(identifier,
                                        association_objecttype,
                                        token_path = hubspot_token_get(),
                                        apikey = hubspot_key_get(),
                                        max_iter = 10,
                                        max_properties = 100,
                                        offsetvalue = 0) {
  
  associationname=get_object_name(association_objecttype,token_path,apikey)
  
  query <- c(
    list(
      limit = 500
    )
  )
  
  res <- get_results_paged(
    path = paste0("/crm/v3/objects/products/",identifier,"/associations/",associationname),
    max_iter = max_iter,
    query = query,
    token_path = token_path,
    apikey = apikey,
    element = "results",
    hasmore_name = "after",
    offset_name_in = "after",
    offset_name_out = "after",
    offset_initial = offsetvalue
  )
  
  map_results(res,mapname="id",element=NULL)
}

#' Product create association (single)
#' 
#' Associate a product with another object.
#' @template endpointv3product
#' 
#' @template identifier
#' @template association_objecttype
#' @template association_identifier
#' @template association_type
#' @template token_path
#' @template apikey
#' 
#' @template returngetassociation
#' @export
#' @rdname createassociationv3
#' @examples
#' \dontrun{
#' associations <- hs_create_product_association(
#'   identifier = 1,
#'   association_objecttype = "contact",
#'   association_identifier = 25,
#'   association_type = "product_to_contact"
#' )
#' }
hs_create_product_association <- function(identifier,
                                          association_objecttype,
                                          association_identifier,
                                          association_type,
                                          token_path = hubspot_token_get(),
                                          apikey = hubspot_key_get()) {
  
  associationname=get_object_name(association_objecttype,token_path,apikey)
  
  send_results(
    path = paste0("/crm/v3/objects/products/",identifier,"/associations/",associationname,"/",association_identifier,"/",association_type),
    body = NULL,
    apikey = apikey,
    token_path = token_path,
    sendfunction=httr::PUT
  )
}

#' Product delete association (single)
#' 
#' Remove an association between the product and another object.
#' @template endpointv3product
#'
#' @template identifier
#' @template association_objecttype
#' @template association_identifier
#' @template association_type
#' @template token_path
#' @template apikey
#'
#' @template returndeleteassociation
#' @export
#' @rdname deleteassociationv3
#' @examples
#' \dontrun{
#' result <- hs_delete_product_association(
#'   identifier = 1,
#'   association_objecttype = "contact",
#'   association_identifier = 25,
#'   association_type = "product_to_contact"
#' )
#' }
hs_delete_product_association <- function(identifier,
                                          association_objecttype,
                                          association_identifier,
                                          association_type,
                                          token_path = hubspot_token_get(),
                                          apikey = hubspot_key_get()) {
  
  associationname=get_object_name(association_objecttype,token_path,apikey)
  
  send_results(
    path = paste0("/crm/v3/objects/products/",identifier,"/associations/",associationname,"/",association_identifier,"/",association_type),
    body = NULL,
    token_path = token_path,
    apikey = apikey,
    sendfunction = httr::DELETE
  )
}
