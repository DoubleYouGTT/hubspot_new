% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/objects_mapper.R, R/objectsv3.R
\name{hs_get_company_association}
\alias{hs_get_company_association}
\alias{hs_get_contact_association}
\alias{hs_get_deal_association}
\alias{hs_get_line_item_association}
\alias{hs_get_product_association}
\alias{hs_get_ticket_association}
\alias{hs_get_object_association}
\title{Object get associations}
\usage{
hs_get_company_association(
  identifiers_from,
  objecttype_to,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  max_iter = 10,
  offsetvalue = 0
)

hs_get_contact_association(
  identifiers_from,
  objecttype_to,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  max_iter = 10,
  offsetvalue = 0
)

hs_get_deal_association(
  identifiers_from,
  objecttype_to,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  max_iter = 10,
  offsetvalue = 0
)

hs_get_line_item_association(
  identifiers_from,
  objecttype_to,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  max_iter = 10,
  offsetvalue = 0
)

hs_get_product_association(
  identifiers_from,
  objecttype_to,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  max_iter = 10,
  offsetvalue = 0
)

hs_get_ticket_association(
  identifiers_from,
  objecttype_to,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  max_iter = 10,
  offsetvalue = 0
)

hs_get_object_association(
  objecttype_from,
  identifiers_from,
  objecttype_to,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get(),
  max_iter = 10,
  offsetvalue = 0
)
}
\arguments{
\item{identifiers_from}{The base object identifier(s) (either \code{vid} or \code{id}).}

\item{objecttype_to}{String name of the object type to associate with.}

\item{token_path}{Path to OAuth 2.0 token.
See \code{\link[=hubspot_token_create]{hubspot_token_create()}}.}

\item{apikey}{API key to work with Hubspot (only used if \code{token_path}
is \code{NULL}). See \code{\link[=hubspot_key_set]{hubspot_key_set()}}.}

\item{max_iter}{The API is limited to a certain number of responses by page, use \code{max_iter} to
limit how many pages of data will get returned}

\item{offsetvalue}{The offset value to use if continuing a previous call. Defaults to 0.}

\item{objecttype_from}{String name of the base object type, the object type to associate from.
Can be any of the default HubSpot objects (\code{contacts}, \code{companies}, \code{deals},
\code{tickets}, \code{line_items}, \code{products}, \code{quotes}, \code{engagements}) or a custom created object.}

\item{max_properties}{Avoid URLs that are too long, limit the number of
properties returned, if required.}
}
\value{
List with association data or \code{NULL} in case
no object was found (error 404), or \code{NA} if there was an
internal server error (error 500). All server error codes will display a warning.

The returned list of association data won't always be the same length
as the provided identifiers. Identifiers that do not have associations
are excluded from the returned list.
}
\description{
Get a list of associations one or multiple objects have.

The functions take into account batch limits for the API. This limit
is 100 objects per batch API call, except for the 'contacts' object,
where the limit is 10 objects per batch API call.
}
\examples{
\dontrun{
onecompanytocontactassociations <- hs_get_object_association(
  objecttype_from = "companies",
  identifiers_from = 1,
  objecttype_to = "contact"
)
twocompaniestocontactsassociations <- hs_get_object_association(
  objecttype_from = "companies",
  identifiers_from = c(1,2),
  objecttype_to = "contact"
)
}
}
