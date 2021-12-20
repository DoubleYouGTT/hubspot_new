#' Get list of objects
#'
#' Get a list of objects.
#' @template endpointv3object
#' @template endpointv3object_list
#'
#' @template objecttype
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
#' products <- hs_get_object_list(
#'   objecttype = "products",
#'   max_iter = 1,
#'   max_properties = 10
#' )
hs_get_object_list  <- function(objecttype,
                                token_path = hubspot_token_get(),
                                apikey = hubspot_key_get(),
                                properties = NULL,
                                max_iter = 10,
                                max_properties = 100,
                                offsetvalue = 0) {

  if (is.null(properties)) {
    properties=hs_object_properties_tidy(objecttype,
                                         hs_object_properties_raw(objecttype,
                                                                  token_path = token_path,
                                                                  apikey = apikey
                                         ))
  }
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
    path = paste0("/crm/v3/objects/",objecttype),
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


#' Object create
#' 
#' Create one or more objects with the given properties and return a copy of the object(s), including identifier(s).
#' @template endpointv3object
#' 
#' @template objecttype
#' @template propertiesmake
#' @template token_path
#' @template apikey
#' 
#' @template returncreateobject
#' @export
#' @rdname createobjectv3
#' @examples
#' \dontrun{
#' oneproduct <- hs_create_object(
#'   objecttype = "products",
#'   properties = list(name="New product",
#'                     description="Awesome product for everyone")
#' )
#' twoproducts <- hs_create_object(
#'   objecttype = "products",
#'   properties = list(list(name="First product",
#'                          description="Awesome product for everyone"),
#'                     list(name="Second product",
#'                          description="Even better product for everyone")
#'                    )
#' )
#' }
hs_create_object <- function(objecttype,
                             properties,
                             token_path = hubspot_token_get(),
                             apikey = hubspot_key_get()) {
  
  if (objecttype=="contacts") chunksize=10
  
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
      path = paste0("/crm/v3/objects/",objecttype),
      apikey = apikey,
      token_path = token_path,
      body = query,
      sendfunction=httr::POST
    )
  } else {                                                  #multiple objects
    results <- list()
    propchunks=chunk(properties, getchunksize(objecttype))  #chunking into groups
    for (i in 1:length(propchunks)) {
      properties=propchunks[[i]]
      query=list(inputs=lapply(properties, function(x) { list(properties=x) }))

      res=send_results(
        path = paste0("/crm/v3/objects/",objecttype,"/batch/create"),
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

#' Object get by id
#' 
#' Get one or more object.
#' @template endpointv3object
#'
#' @template objecttype
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
#' oneproduct <- hs_get_object(
#'   objecttype = "products",
#'   identifiers = 1
#' )
#' twoproducts <- hs_get_object(
#'   objecttype = "products",
#'   identifiers = c(1,2)
#' )
#' }
hs_get_object <- function(objecttype,
                          identifiers,
                          token_path = hubspot_token_get(),
                          apikey = hubspot_key_get(),
                          properties = NULL,
                          max_properties = 100) {
  
  if (is.null(properties)) {
    properties=hs_object_properties_tidy(objecttype,
                                         hs_object_properties_raw(objecttype,
                                                                  token_path = token_path,
                                                                  apikey = apikey
                                         ))
  }
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
      path = paste0("/crm/v3/objects/",objecttype,"/",identifiers),
      query = query,
      token_path = token_path,
      apikey = apikey
    )
  } else {                                                    #multiple objects
    results <- list()
    idchunks=chunk(identifiers, 100)                          #chunking into groups of 100 objects
    for (i in 1:length(idchunks)) {
      identifiers=idchunks[[i]]
      
      #query making
      query=list(properties=properties,
                 inputs=lapply(identifiers, function(x) { list(id=x) }))
      
      res=send_results(
        path = paste0("/crm/v3/objects/",objecttype,"/batch/read"),
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

#' Object update
#' 
#' Update one or more objects.
#' @template explain_update
#' @template endpointv3object
#'
#' @template objecttype
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
#' oneproduct <- hs_update_object(
#'   objecttype = "products",
#'   identifiers = 1,
#'   properties = list(name="New product",
#'                     description="Awesome product for everyone")
#' )
#' twoproducts <- hs_update_object(
#'   objecttype = "products",
#'   identifiers = c(1,2),
#'   properties = list(list(name="First product",
#'                          description="Awesome product for everyone"),
#'                     list(name="Second product",
#'                          description="Even better product for everyone")
#'                    )
#' )
#' }
hs_update_object <- function(objecttype,
                             identifiers,
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
      path = paste0("/crm/v3/objects/",objecttype,"/",identifiers),
      body = query,
      token_path = token_path,
      apikey = apikey,
      sendfunction = httr::PATCH
    )
  } else {                                                    #multiple objects
    results <- list()
    idchunks=chunk(identifiers, getchunksize(objecttype))     #chunking into groups of 100 objects
    propchunks=chunk(properties, getchunksize(objecttype))    #need to be sure that properties are also chunked
    for (i in 1:length(idchunks)) {
      identifiers=idchunks[[i]]
      properties=propchunks[[i]]

      query=lapply(properties, function(x) { list(properties=x) })
      for (i in 1:length(identifiers)) {
        query[[i]]$id=identifiers[i]
      }
      query=list(inputs=query)
      
      res=send_results(
        path = paste0("/crm/v3/objects/",objecttype,"/batch/update"),
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


#' Object delete
#' 
#' Delete one or multiple objects.
#' @template endpointv3object
#'
#' @template objecttype
#' @template identifiers
#' @template token_path
#' @template apikey
#'
#' @template returndelete
#' @export
#' @rdname deletev3
#' @examples
#' \dontrun{
#' oneproduct <- hs_delete_object(
#'   objecttype = "products",
#'   identifiers = 1
#' )
#' twoproducts <- hs_delete_object(
#'   objecttype = "products",
#'   identifiers = c(1,2)
#' )
#' }
hs_delete_object <- function(objecttype,
                             identifiers,
                             token_path = hubspot_token_get(),
                             apikey = hubspot_key_get()) {
  
  if (length(identifiers)==1) {                               #one object
    send_results(
      path = paste0("/crm/v3/objects/",objecttype,"/",identifiers),
      body = NULL,
      token_path = token_path,
      apikey = apikey,
      sendfunction = httr::DELETE
    )
  } else {                                                    #multiple objects
    results <- list()
    idchunks=chunk(identifiers, getchunksize(objecttype))     #chunking into groups of 100 objects
    for (i in 1:length(idchunks)) {
      identifiers=idchunks[[i]]

      query=list(inputs=lapply(identifiers, function(x) { list(id=x) }))

      res=send_results(
        path = paste0("/crm/v3/objects/",objecttype,"/batch/archive"),
        body = query,
        token_path = token_path,
        apikey = apikey,
        sendfunction = httr::POST
      )
    }
    return(res)
  }
}

# Object filter, sort, search

#TO DO
#https://developers.hubspot.com/docs/api/crm/search
#create filter groups (group OR group)
#create filters (propertyName, operator, value) (filter AND filter)
#sorting (propertyName, direction) (one rule only)
#searching (query)

#' Object get associations
#' 
#' Get a list of associations one or multiple objects have.
#' @template association_explain
#' 
#' @template endpointv3object
#'
#' @template objecttype_from
#' @template identifiers_from
#' @template objecttype_to
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
#' onecompanytocontactassociations <- hs_get_object_association(
#'   objecttype_from = "companies",
#'   identifiers_from = 1,
#'   objecttype_to = "contact"
#' )
#' twocompaniestocontactsassociations <- hs_get_object_association(
#'   objecttype_from = "companies",
#'   identifiers_from = c(1,2),
#'   objecttype_to = "contact"
#' )
#' }
hs_get_object_association  <- function(objecttype_from,
                                       identifiers_from,
                                       objecttype_to,
                                       token_path = hubspot_token_get(),
                                       apikey = hubspot_key_get(),
                                       max_iter = 10,
                                       offsetvalue = 0) {
  
  associationname=get_object_name(objecttype_to,token_path,apikey)
  
  if (length(identifiers_from)==1) {                               #one object
    query <- c(
      list(
        limit = 500
      )
    )
    
    res <- get_results_paged(
      path = paste0("/crm/v3/objects/",objecttype_from,"/",identifiers_from,"/associations/",associationname),
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
  } else {                                                    #multiple objects
    results <- list()
    idchunks=chunk(identifiers_from, 100)                     #chunking into groups of 100 objects
    for (i in 1:length(idchunks)) {
      identifiers=idchunks[[i]]
      
      query=list(inputs=lapply(identifiers, function(x) { list(id=x) }))
      
      res=send_results(
        path = paste0("/crm/v3/associations/",objecttype_from,"/",objecttype_to,"/batch/read"),
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
    return(results)
  }
}

#' Object create association
#' 
#' Associate one or more objects with one or more other objects. The function
#' will associate the first element of vector `identifier_from` to the first
#' element of vector `identifier_to`, second element to second element, 
#' and so on. When you want to associate one base object to multiple other objects,
#' you have to provide the `identifier_from` multiple times.
#' @template association_explain
#' 
#' @template endpointv3object
#' 
#' @template objecttype_from
#' @template identifiers_from
#' @template objecttype_to
#' @template identifiers_to
#' @template association_type
#' @template token_path
#' @template apikey
#' 
#' @template returngetassociation
#' @export
#' @rdname createassociationv3
#' @examples
#' \dontrun{
#' newcompanytocontactassociation <- hs_create_object_association(
#'   objecttype_from = "companies",
#'   identifiers_from = 1,
#'   objecttype_to = "contact",
#'   identifiers_to = 25,
#'   association_type = "company_to_contact"
#' )
#' newcompaniestocontactsassociations <- hs_create_object_association(
#'   objecttype_from = "companies",
#'   identifiers_from = c(1,2),
#'   objecttype_to = "contact",
#'   identifiers_to = c(25,26),
#'   association_type = "company_to_contact"
#' )
#' }
hs_create_object_association <- function(objecttype_from,
                                         identifiers_from,
                                         objecttype_to,
                                         identifiers_to,
                                         association_type,
                                         token_path = hubspot_token_get(),
                                         apikey = hubspot_key_get()) {
  
  if (length(identifiers_from)!=length(identifiers_to)) {
    stop("Length of identifiers_from and identifiers_to are not equal!")
  }
  
  associationname=get_object_name(objecttype_to,token_path,apikey)
  
  if (length(identifiers_from)==1) {                               #one object
    send_results(
      path = paste0("/crm/v3/objects/",objecttype_from,"/",identifiers_from,"/associations/",associationname,"/",identifiers_to,"/",association_type),
      body = NULL,
      apikey = apikey,
      token_path = token_path,
      sendfunction=httr::PUT
    )
  } else {
    results <- list()
    idchunksfrom=chunk(identifiers_from, 100)                     #chunking into groups of 100 objects
    idchunksto=chunk(identifiers_to, 100)
    for (i in 1:length(idchunksfrom)) {
      identifiersf=idchunksfrom[[i]]
      identifierst=idchunksto[[i]]
      
      query=list()
      for (j in 1:length(identifiersf)) {
        query[[j]]=list()
        query[[j]]$from=list(id=identifiersf[j])
        query[[j]]$to=list(id=identifierst[j])
        query[[j]]$type=association_type
      }
      query=list(inputs=query)
      
      res=send_results(
        path = paste0("/crm/v3/associations/",objecttype_from,"/",associationname,"/batch/create"),
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
    return(results)
  }
}

#' Object delete association (single)
#' 
#' Remove an association between an object and another object. The function
#' will remove the first object in vector `identifier_from` that's associated to the first
#' object of vector `identifier_to`, second element to second element, 
#' and so on. When you want to remove multiple associations of one base object 
#' to multiple other objects, you have to provide the `identifier_from` multiple times.
#' @template association_explain
#' 
#' @template endpointv3object
#'
#' @template objecttype_from
#' @template identifiers_from
#' @template objecttype_to
#' @template identifiers_to
#' @template association_type
#' @template token_path
#' @template apikey
#'
#' @template returndeleteassociation
#' @export
#' @rdname deleteassociationv3
#' @examples
#' \dontrun{
#' deletedcompanytocontactassociation <- hs_delete_object_association(
#'   objecttype_from = "companies",
#'   identifier = 1,
#'   objecttype_to = "contact",
#'   identifiers_to = 25,
#'   association_type = "company_to_contact"
#' )
#' deletedcompaniestocontactsassociations <- hs_delete_object_association(
#'   objecttype_from = "companies",
#'   identifier = c(1,2),
#'   objecttype_to = "contact",
#'   identifiers_to = c(25,26),
#'   association_type = "company_to_contact"
#' )
#' }
hs_delete_object_association <- function(objecttype_from,
                                         identifiers_from,
                                         objecttype_to,
                                         identifiers_to,
                                         association_type,
                                         token_path = hubspot_token_get(),
                                         apikey = hubspot_key_get()) {
  
  if (length(identifiers_from)!=length(identifiers_to)) {
    stop("Length of identifiers_from and identifiers_to are not equal!")
  }
  
  associationname=get_object_name(objecttype_to,token_path,apikey)
  
  if (length(identifiers_from)==1) {                               #one object
    send_results(
      path = paste0("/crm/v3/objects/",objecttype_from,"/",identifiers_from,"/associations/",associationname,"/",identifiers_to,"/",association_type),
      body = NULL,
      token_path = token_path,
      apikey = apikey,
      sendfunction = httr::DELETE
    )
  } else {
    results <- list()
    idchunksfrom=chunk(identifiers_from, 100)                     #chunking into groups of 100 objects
    idchunksto=chunk(identifiers_to, 100)
    for (i in 1:length(idchunksfrom)) {
      identifiersf=idchunksfrom[[i]]
      identifierst=idchunksto[[i]]
      
      query=list()
      for (j in 1:length(identifiersf)) {
        query[[j]]=list()
        query[[j]]$from=list(id=identifiersf[j])
        query[[j]]$to=list(id=identifierst[j])
        query[[j]]$type=association_type
      }
      query=list(inputs=query)
      
      res=send_results(
        path = paste0("/crm/v3/associations/",objecttype_from,"/",associationname,"/batch/archive"),
        body = query,
        token_path = token_path,
        apikey = apikey,
        sendfunction = httr::POST
      )
    }
    return(res)
  }
}
