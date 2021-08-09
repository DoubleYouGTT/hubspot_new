#' hubspot
#'
#' Utilizing the \href{https://developers.hubspot.com/docs}{'Hubspot CRM' API} to
#' retrieve customer relationship data for reporting and analysis.
"_PACKAGE"

usethis::use_package("purrr", "Imports")
usethis::use_package("dplyr", "Imports")
usethis::use_package("httr", "Imports")
usethis::use_package("magrittr", "Imports")
usethis::use_package("tidyr", "Imports")
usethis::use_package("rlang", "Imports")
usethis::use_package("keyring", "Imports")
usethis::use_package("methods", "Imports")
usethis::use_package("tibble", "Imports")
usethis::use_package("anytime", "Imports")
usethis::use_package("memoise", "Imports")
usethis::use_package("ratelimitr", "Imports")
usethis::use_package("glue", "Imports")

usethis::use_package("testthat", "Suggests", min_version = "2.1.0")
usethis::use_package("knitr", "Suggests")
usethis::use_package("rmarkdown", "Suggests")
usethis::use_package("covr", "Suggests")
usethis::use_package("pkgload", "Suggests")


# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL
