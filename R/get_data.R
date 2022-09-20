#' Get data from J-Quants API
#'
#' @description Get data from J-Quants API.
#'
#' When you have run "authorize()", you don't need to set "id_token" parameter,
#' because "authorize()" set your ID token in a environment variable named "JQUANTSR_ID_TOKEN".
#'
#' @param code a string stock code.
#' @param from a string the start date of data. "\%Y\%m\%d" and "\%Y-\%m-\%d" formats are valid.
#' @param to a string the end date of data. "\%Y\%m\%d" and "\%Y-\%m-\%d" formats are valid.
#' @param date a string the date of data. "\%Y\%m\%d" and "\%Y-\%m-\%d" formats are valid.
#' @param id_token a string your id_token.
#' @return if successfully fetched data (= status code of the API is 200), a tibble of the fetched data.
#' if not successfully (= status code of the API is not 200), none and message from the API is printed.
#'
#' @details parameter "code", "from", "to", "date" are required as follows.
#' \itemize{
#'   \item{"get_info()"}: {"code" is optional.}
#'   \item{"get_daily_quotes()"}: {At least one of "code" and "date" are mandatory. If "from" and "to" parameters are used, "code" is mandatory.}
#'   \item{"get_financial_annoucements()"}: {At least one of "code" and "date" are mandatory.}
#' }
#' For more information, see \href{https://jpx.gitbook.io/j-quants-api/api-reference}{J-Quants API reference}.
#'
#' @examples
#' \dontrun{
#' # you must have done "authorize()" before running "get_info" or other functions,
#  # if you don't pass "id_token" in such functions.
#' authorize(refresh_token = YOUR_REFRESH_TOKEN)
#' get_info()
#' get_info(code = "86970")
#' get_sections()
#' get_daily_quotes(date = "20220701")
#' get_daily_quotes(code = "86970", from = "20220101", to = "20220630")
#' get_trades_spec()
#' get_trades_spec(section = "TSEPrime")
#' get_trades_spec(from = "20220101", to = "20220630")
#' get_trades_spec(section = "TSEPrime", from = "20220101", to = "20220630")
#' get_financial_statements(code = "86970")
#' get_financial_statements(date = "20220105")
#' get_financial_annoucement()
#' }
#' @export
get_info <- function(code, id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
  if (rlang::is_missing(code)) {
    code <- NULL
  }
  query <- list(code = code)
  get_from_api("/listed/info", query, id_token)
}

#' @rdname get_info
#' @export
get_sections <- function(id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
  query <- NULL
  get_from_api("/listed/sections", query, id_token)
}

#' @rdname get_info
#' @export
get_daily_quotes <- function(code, from, to, date, id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
  if (rlang::is_missing(code)) {
    code <- NULL
  }
  if (rlang::is_missing(from)) {
    from <- NULL
  }
  if (rlang::is_missing(to)) {
    to <- NULL
  }
  if (rlang::is_missing(date)) {
    date <- NULL
  }
  query <- list(code = code, from = from, to = to, date = date)
  get_from_api("/prices/daily_quotes", query, id_token)
}

#' @rdname get_info
#' @export
get_trades_spec <- function(section, from, to, id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
  if (rlang::is_missing(section)) {
    section <- NULL
  }
  if (rlang::is_missing(from)) {
    from <- NULL
  }
  if (rlang::is_missing(to)) {
    to <- NULL
  }
  query <- list(section = section, from = from, to = to)
  get_from_api("/markets/trades_spec", query, id_token)
}

#' @rdname get_info
#' @export
get_financial_statements <- function(code, date, id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
  if (rlang::is_missing(code)) {
    code <- NULL
  }
  if (rlang::is_missing(date)) {
    date <- NULL
  }
  query <- list(code = code, date = date)
  get_from_api("/fins/statements", query, id_token)
}

#' @rdname get_info
#' @export
get_financial_announcement <- function(id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
  query <- NULL
  get_from_api("/fins/announcement", query, id_token)
}
