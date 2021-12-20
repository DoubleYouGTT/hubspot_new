#' @return List with association data or \code{NULL} in case
#' no object was found (error 404), or \code{NA} if there was an
#' internal server error (error 500). All server error codes will display a warning.
#' 
#' The returned list of association data won't always be the same length
#' as the provided identifiers. Identifiers that do not have associations
#' are excluded from the returned list.
