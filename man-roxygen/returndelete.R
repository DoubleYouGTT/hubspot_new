#' @return This function always returns the same, an empty \code{raw} object.
#' If an incorrect input is provided, no warning or error will be given.
#'
#' To see if an object/schema is properly deleted, use \code{hs_get_xxx} to obtain
#' the same object/schema or use \code{hs_get_xxx_list} to obtain
#' multiple objects. If the returning information does not contain the
#' object/schema, it is deleted correctly.
