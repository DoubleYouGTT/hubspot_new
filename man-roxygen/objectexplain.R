#' Can be any of the default HubSpot objects (\code{contact}, \code{company}, \code{deal}, 
#' \code{ticket}, \code{line_item}, \code{product}, \code{quote}) or a custom created object.
#' 
#' When the object identifier is provided, this needs to be the full \code{objectTypeId},
#' which for custom objects is defined as \code{{meta-type}-{object_type_id}},
#' where the meta-type is always 2 (portal-specific).
#' 
#' When the object name is provided, this can be either the name of the object itself,
#' including the name of a custom object (as long as this name does not contain numerals).
#' For example, \code{object="contact"} will refer to the Contact object,
#' a custom object Car can be referenced to as \code{object="car"}.
#' 
#' The object name for a custom object will be automatically transformed to 
#' to the fully qualified name, which is defined as \code{p{portal_id}_{object_name}}. 
#' When it detects numerals in its object name, it assumes that either an \code{objectTypeId} 
#' or fully qualified name is provided and does not transform it to a fully 
#' qualified name using the \code{portal_id}.
