#' Uses the \href{https://developers.hubspot.com/docs/api/crm/crm-custom-objects}{objects v3 endpoint}.
#' This endpoint supports the default HubSpot object types as well. The specific object functions
#' (for example \code{\link{hs_get_company_list}}) internally call the object endpoint when their
#' functionality is the same.
#' 
#' The functions take into account batch limits for the API. This limit
#' is 100 objects per batch API call, except for the 'contacts' object,
#' where the limit is 10 objects per batch API call.
