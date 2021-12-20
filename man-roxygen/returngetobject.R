#' @return List with object data, \code{NULL} in case
#' no object was found (error 404), or \code{NA} if there was an
#' internal server error (error 500). All server error codes will display a warning.
#' An empty list can also be returned if the API call was successful but no objects
#' returned (e.g. the requested object does not exist anymore).
