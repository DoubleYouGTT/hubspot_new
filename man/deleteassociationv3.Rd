% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/objects_mapper.R, R/objectsv3.R
\name{hs_delete_company_association}
\alias{hs_delete_company_association}
\alias{hs_delete_contact_association}
\alias{hs_delete_deal_association}
\alias{hs_delete_line_item_association}
\alias{hs_delete_product_association}
\alias{hs_delete_ticket_association}
\alias{hs_delete_object_association}
\title{Object delete association (single)}
\usage{
hs_delete_company_association(
  identifiers_from,
  objecttype_from,
  identifiers_to,
  association_type,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get()
)

hs_delete_contact_association(
  identifiers_from,
  objecttype_from,
  identifiers_to,
  association_type,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get()
)

hs_delete_deal_association(
  identifiers_from,
  objecttype_from,
  identifiers_to,
  association_type,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get()
)

hs_delete_line_item_association(
  identifiers_from,
  objecttype_from,
  identifiers_to,
  association_type,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get()
)

hs_delete_product_association(
  identifiers_from,
  objecttype_from,
  identifiers_to,
  association_type,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get()
)

hs_delete_ticket_association(
  identifiers_from,
  objecttype_from,
  identifiers_to,
  association_type,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get()
)

hs_delete_object_association(
  objecttype_from,
  identifiers_from,
  objecttype_to,
  identifiers_to,
  association_type,
  token_path = hubspot_token_get(),
  apikey = hubspot_key_get()
)
}
\arguments{
\item{identifiers_from}{The base object identifier(s) (either \code{vid} or \code{id}).}

\item{objecttype_from}{String name of the base object type, the object type to associate from.
Can be any of the default HubSpot objects (\code{contacts}, \code{companies}, \code{deals},
\code{tickets}, \code{line_items}, \code{products}, \code{quotes}, \code{engagements}) or a custom created object.}

\item{identifiers_to}{The object identifier(s) (either \code{vid} or \code{id}) of the object(s) to associate with.}

\item{association_type}{String name of the association type.
Follows the \code{object_to_object} string format. A full list is
not available, but the \href{https://legacydocs.hubspot.com/docs/methods/crm-associations/crm-associations-overview}{CRM associations API}
table provides most association types. Custom objects create
new association type names as can be found in the \href{https://developers.hubspot.com/docs/api/crm/crm-custom-objects}{CRM Custom Objects API}.}

\item{token_path}{Path to OAuth 2.0 token.
See \code{\link[=hubspot_token_create]{hubspot_token_create()}}.}

\item{apikey}{API key to work with Hubspot (only used if \code{token_path}
is \code{NULL}). See \code{\link[=hubspot_key_set]{hubspot_key_set()}}.}

\item{objecttype_to}{String name of the object type to associate with.}
}
\value{
This function always returns the same, an empty \code{raw} object.
If an incorrect input is provided, no warning or error will be given.
Obtain the association using the get association function (function \code{hs_get_xxx_association})
with the same input to this function to see if it was properly deleted
(the returning association list would not have the \code{identifiers_to} listed anymore).
}
\description{
Remove an association between an object and another object. The function
will remove the first object in vector \code{identifier_from} that's associated to the first
object of vector \code{identifier_to}, second element to second element,
and so on. When you want to remove multiple associations of one base object
to multiple other objects, you have to provide the \code{identifier_from} multiple times.

The functions take into account batch limits for the API. This limit
is 100 objects per batch API call, except for the 'contacts' object,
where the limit is 10 objects per batch API call.
}
\examples{
\dontrun{
deletedcompanytocontactassociation <- hs_delete_object_association(
  objecttype_from = "companies",
  identifier = 1,
  objecttype_to = "contact",
  identifiers_to = 25,
  association_type = "company_to_contact"
)
deletedcompaniestocontactsassociations <- hs_delete_object_association(
  objecttype_from = "companies",
  identifier = c(1,2),
  objecttype_to = "contact",
  identifiers_to = c(25,26),
  association_type = "company_to_contact"
)
}
}
