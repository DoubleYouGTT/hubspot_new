#' Property create
#' 
#' Helper function to create a new object property with the right settings.
#' Used within the creation or editing of schemas of objects.
#' @param name The internal property name, which must be used when referencing the property from the API.
#' Cannot contain spaces and is commonly lowercase letters and underscores only.
#' @param label A human-readable property label that will be shown in HubSpot. Start with capital letter.
#' @param type The type of property to create. Must be one of `enumeration`, `date`, `datetime`, `string`, `number` or `bool`.
#' @param field_type The method how the property appears in HubSpot or on a form.
#' If provided, it must match the provided \code{type}:
#' \itemize{
#' \item{\code{type}=\code{enumeration}}{This field can only be either of `select`, `checkbox`, or `radio`.}
#' \item{\code{type}=\code{date}}{This field can only be `date`.}
#' \item{\code{type}=\code{datetime}}{This field can only be `date`.}
#' \item{\code{type}=\code{string}}{This field can only be either of `text`, `textarea`, or `file`.}
#' \item{\code{type}=\code{number}}{This field can only be `number`.}
#' \item{\code{type}=\code{bool}}{This field can only be `booleancheckbox`.}
#' }
#' If this parameter is not provided (\code{NULL}) or the \code{type} only supports one \code{field_type},
#' it will take the first value mentioned in the list above.
#' @param group_name The name of the group this property belongs to.
#' The HubSpot API has no functionality to manage groups.
#' Default=\code{NULL}, which does not assign this property to a group.
#' @param description A description of the property that will be shown as help text in HubSpot.
#' Default=\code{NULL}, which leaves the description empty.
#' @param option_labels Vector of string labels for the available options 
#' of an enumeration property (\code{type=enumeration}).
#' This field is only required for enumerated properties and is ignored for any other types.
#' @param option_values Vector of string values for the available options 
#' of an enumeration property (\code{type=enumeration}). Must be of same length as \code{optionlabels}.
#' This field is only required for enumerated properties and is ignored for any other types.
#' @param display_order The order that this property should be displayed in the HubSpot user interface
#' relative to other properties for this object type. Properties are displayed in order starting 
#' with the lowest positive integer value. A value of -1 (default) will cause the property to be displayed 
#' after any positive values.
#' @param has_unique_value Logical. If \code{TRUE}, newly created objects must have this property
#' be different from existing objects with this property. If \code{FALSE}, duplicate values
#' of this property can occur (default).
#' @param hidden Logical. If \code{TRUE}, this property is invisible in the HubSpot user interface.
#' If \code{FALSE}, this property can be seen and used in the interface (default).
#' @param mainpropertylist Provide a list of already created properties to append 
#' the newly created property to. Default=\code{NULL}.
#' @return A list with the property settings, or a list of list with properties settings
#' when \code{mainpropertylist} is provided. Parameters that are left to its default
#' are not returned in the list.
#' @export
#' @examples
#' newprop=hs_build_property(
#'   name = "make",
#'   label = "Make",
#'   type = "string",
#'   field_type = "text",
#'   description = "The manufacturer of a car"
#' )
hs_build_property <- function(name,
                              label,
                              type,
                              field_type=NULL,
                              group_name=NULL,
                              description=NULL,
                              option_labels=NULL,
                              option_values=NULL,
                              display_order=-1,
                              has_unique_value=FALSE,
                              hidden=FALSE,
                              mainpropertylist=NULL) {
  
  options=NULL
  #ensure the right field_type is set
  if (type=="date")
    field_type="date"
  if (type=="datetime")
    field_type="date"
  if (type=="number")
    field_type="number"
  if (type=="bool")
    field_type="booleancheckbox"
  if (type=="string") {
    if (is.null(field_type)) {
      field_type="text"
    } else {
      if (!field_type %in% c("text","textarea","file"))
        stop("Incorrect field_type provided for type=string!")
    }
  }
  if (type=="enumeration") {
    if (is.null(field_type)) {
      field_type="select"
    } else {
      if (!field_type %in% c("select","checkbox","radio"))
        stop("Incorrect field_type provided for type=enumeration!")
    }
    if (is.null(option_labels) | is.null(option_values))
      stop("There are no option_labels or option_values provided for type=enumeration!")
    if (length(option_labels)!=length(option_values))
      stop("The length of option_labels is not the same as option_values for type=enumeration!")
    
    options=list()
    for (i in 1:length(option_labels)) {
      options[[i]]=list(label=option_labels[i],
                      value=option_values[i])
    }
  }
  
  #make property list
  proplist=list(
    name=name,
    label=label,
    type=type,
    fieldType=field_type
  )
  if (!is.null(options))
    proplist$options=options
  if (!is.null(group_name))
    proplist$groupName=group_name
  if (!is.null(description))
    proplist$description=description
  if (display_order != -1)
    proplist$displayOrder=display_order
  if (has_unique_value)
    proplist$hasUniqueValue=has_unique_value
  if (hidden)
    proplist$hidden=hidden

  #connect it to the other properties if they are there
  if(!is.null(mainpropertylist)) {
    proplist=append(mainpropertylist,list(proplist))
  }
  return(proplist)
}
