% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/objects_mapper.R, R/objectsv3.R
\name{hs_get_company_list}
\alias{hs_get_company_list}
\alias{hs_get_contact_list}
\alias{hs_get_deal_list}
\alias{hs_get_line_item_list}
\alias{hs_get_product_list}
\alias{hs_get_ticket_list}
\alias{hs_get_object_list}
\title{Get list of objects}
\usage{
hs_get_company_list(
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  properties = NULL,
  max_iter = 10,
  max_properties = 100,
  offsetvalue = 0
)

hs_get_contact_list(
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  properties = NULL,
  max_iter = 10,
  max_properties = 100,
  offsetvalue = 0
)

hs_get_deal_list(
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  properties = NULL,
  max_iter = 10,
  max_properties = 100,
  offsetvalue = 0
)

hs_get_line_item_list(
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  properties = NULL,
  max_iter = 10,
  max_properties = 100,
  offsetvalue = 0
)

hs_get_product_list(
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  properties = NULL,
  max_iter = 10,
  max_properties = 100,
  offsetvalue = 0
)

hs_get_ticket_list(
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  properties = NULL,
  max_iter = 10,
  max_properties = 100,
  offsetvalue = 0
)

hs_get_object_list(
  objecttype,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  properties = NULL,
  max_iter = 10,
  max_properties = 100,
  offsetvalue = 0
)
}
\arguments{
\item{token_path}{Path to OAuth 2.0 token.
See \code{\link[=hubspot_token_create]{hubspot_token_create()}}.}

\item{apikey}{API key to work with Hubspot (only used if \code{token_path}
is \code{NULL}). See \code{\link[=hubspot_key_set]{hubspot_key_set()}}.}

\item{properties}{Character vector of properties to request}

\item{max_iter}{The API is limited to a certain number of responses by page, use \code{max_iter} to
limit how many pages of data will get returned}

\item{max_properties}{Avoid URLs that are too long, limit the number of
properties returned, if required.}

\item{offsetvalue}{The offset value to use if continuing a previous call. Defaults to 0.}

\item{objecttype}{String name of the main object type.
Can be any of the default HubSpot objects (\code{contacts}, \code{companies}, \code{deals},
\code{tickets}, \code{line_items}, \code{products}, \code{quotes}) or a custom created object.}
}
\value{
List with object data, \code{NULL} in case
no object was found (error 404), or \code{NA} if there was an
internal server error (error 500). All server error codes will display a warning.
An empty list can also be returned if the API call was successful but no objects
returned (e.g. the requested object does not exist anymore).
}
\description{
Get a list of objects.

The functions take into account batch limits for the API. This limit
is 100 objects per batch API call, except for the 'contacts' object,
where the limit is 10 objects per batch API call.
}
\examples{
products <- hs_get_object_list(
  objecttype = "products",
  max_iter = 1,
  max_properties = 10
)
}
