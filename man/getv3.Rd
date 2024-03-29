% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/objects_mapper.R, R/objectsv3.R
\name{hs_get_company}
\alias{hs_get_company}
\alias{hs_get_contact}
\alias{hs_get_deal}
\alias{hs_get_line_item}
\alias{hs_get_product}
\alias{hs_get_ticket}
\alias{hs_get_object}
\title{Object get by id}
\usage{
hs_get_company(
  identifiers,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  properties = NULL,
  max_properties = 100
)

hs_get_contact(
  identifiers,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  properties = NULL,
  max_properties = 100
)

hs_get_deal(
  identifiers,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  properties = NULL,
  max_properties = 100
)

hs_get_line_item(
  identifiers,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  properties = NULL,
  max_properties = 100
)

hs_get_product(
  identifiers,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  properties = NULL,
  max_properties = 100
)

hs_get_ticket(
  identifiers,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  properties = NULL,
  max_properties = 100
)

hs_get_object(
  objecttype,
  identifiers,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  properties = NULL,
  max_properties = 100
)
}
\arguments{
\item{identifiers}{One or more object identifiers (either \code{vid} or \code{id}) of the related object(s).}

\item{token_path}{Path to OAuth 2.0 token.
See \code{\link[=hubspot_token_create]{hubspot_token_create()}}.}

\item{apikey}{API key to work with Hubspot (only used if \code{token_path}
is \code{NULL}). See \code{\link[=hubspot_key_set]{hubspot_key_set()}}.}

\item{properties}{Character vector of properties to request}

\item{max_properties}{Avoid URLs that are too long, limit the number of
properties returned, if required.}

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
Get one or more object.

The functions take into account batch limits for the API. This limit
is 100 objects per batch API call, except for the 'contacts' object,
where the limit is 10 objects per batch API call.
}
\examples{
\dontrun{
oneproduct <- hs_get_object(
  objecttype = "products",
  identifiers = 1
)
twoproducts <- hs_get_object(
  objecttype = "products",
  identifiers = c(1,2)
)
}
}
