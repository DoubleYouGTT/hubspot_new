#' @return This function always returns the same, an empty \code{raw} object.
#' If an incorrect identifier is provided, no warning or error will be given.
#' 
#' To see if an object is properly deleted, use \code{hs_get_\emph{xxx}} to obtain
#' the object with the same identifier (it should return \code{NULL}),
#' or use \code{hs_get_\emph{xxx}_list} to obtain multiple objects 
#' with the same identifiers (it should return an empty list).
