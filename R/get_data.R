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
#' if not successfully (= status code of the API is not 200), message from the API is printed.
#'
#' @details parameter "code", "from", "to", "date" are required as follows.
#' \itemize{
#'   \item{"get_info()"}: {Both of "code" and "date" are optional.}
#'   \item{"get_daily_quotes()"}: {At least one of "code" and "date" are mandatory. If "from" and "to" parameters are used, "code" is mandatory.}
#'   \item{"get_topix()"}: {Both of "from" and "to" are optional.}
#'   \item{"get_financial_annoucements()"}: {At least one of "code" and "date" are mandatory.}
#' }
#' For more information, see \href{https://jpx.gitbook.io/j-quants-ja/api-reference}{J-Quants API reference}.
#'
#' @examples
#' \dontrun{
#' # you must have done "authorize()" before running "get_info" or other functions,
#  # if you don't pass "id_token" in such functions.
#' authorize(refresh_token = YOUR_REFRESH_TOKEN)
#'
#' get_info()
#' get_info(code = "86970")
#' get_info(date = "20220701")
#' get_info(code = "86970", date = "20220701")
#'
#' get_daily_quotes(code = "86970")
#' get_daily_quotes(date = "20220701")
#' get_daily_quotes(code = "86970", from = "20220101", to = "20220630")
#'
#' get_prices_am()
#' get_prices_am(code = "86970")
#'
#' get_trades_spec(section = "TSEPrime")
#' get_trades_spec(from = "20220101", to = "20220630")
#' get_trades_spec(section = "TSEPrime", from = "20220101", to = "20220630")
#'
#' get_weekly_margin_interest(code = "86970")
#' get_weekly_margin_interest(date = "20220701")
#' get_weekly_margin_interest(code = "86970", from = "20220101", to = "20220630")
#'
#' get_short_selling(sector33code = "0050")
#' get_short_selling(date = "20220701")
#' get_short_selling(sector33code = "0050", from = "20220101", to = "20220630")
#'
#' get_breakdown(code = "86970")
#' get_breakdown(date = "20220701")
#' get_breakdown(code = "86970", from = "20220101", to = "20220630")
#'
#' get_trading_calendar()
#' get_trading_calendar(holidaydivision = "1")
#' get_trading_calendar(holidaydivision = "1", from = "20220101")
#' get_trading_calendar(holidaydivision = "1", to = "20220630")
#' get_trading_calendar(holidaydivision = "1", from = "20220101", to = "20220630")
#' get_trading_calendar(from = "20220101", to = "20220630")
#'
#' get_topix()
#' get_topix(from = "20220101")
#' get_topix(to = "20220630")
#' get_topix(from = "20220101", to = "20220630")
#'
#' get_financial_statements(code = "86970")
#' get_financial_statements(date = "20220105")
#' get_financial_statements(code = "86970", date = "20220105")
#'
#' get_financial_details(code = "86970")
#' get_financial_details(date = "20220127")
#' get_financial_details(code = "86970", date = "20220127")
#'
#' get_financial_dividend(code = "86970")
#' get_financial_dividend(date = "20220701")
#' get_financial_dividend(code = "86970", from = "20220101", to = "20220630")
#'
#' get_financial_announcement()
#'
#' get_index_option(date = "20220701")
#' }
#' @export
get_info <- function(code, date, id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
  if (rlang::is_missing(code)) {
    code <- NULL
  }
  if (rlang::is_missing(date)) {
    date <- NULL
  }
  query <- list(code = code, date = date)
  get_full_data("/listed/info", query, "info", "pagination_key", FALSE, id_token)
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
  get_full_data("/prices/daily_quotes", query, "daily_quotes", "pagination_key", TRUE, id_token)
}

#' @rdname get_info
#' @export
get_prices_am <- function(code, id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
  if (rlang::is_missing(code)) {
    code <- NULL
  }
  query <- list(code = code)
  get_full_data("/prices/prices_am", query, "prices_am", "pagination_key", TRUE, id_token)
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
  get_full_data("/markets/trades_spec", query, "trades_spec", "pagination_key", TRUE, id_token)
}

#' @rdname get_info
#' @export
get_weekly_margin_interest <- function(code, from, to, date, id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
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
  get_full_data("/markets/weekly_margin_interest", query, "weekly_margin_interest", "pagination_key", TRUE, id_token)
}

#' @rdname get_info
#' @export
get_short_selling <- function(sector33code, from, to, date, id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
  if (rlang::is_missing(sector33code)) {
    sector33code <- NULL
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
  query <- list(sector33code = sector33code, from = from, to = to, date = date)
  get_full_data("/markets/short_selling", query, "short_selling", "pagination_key", TRUE, id_token)
}

#' @rdname get_info
#' @export
get_breakdown <- function(code, from, to, date, id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
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
  get_full_data("/markets/breakdown", query, "breakdown", "pagination_key", TRUE, id_token)
}

#' @rdname get_info
#' @export
get_trading_calendar <- function(holidaydivision, from, to, id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
  if (rlang::is_missing(holidaydivision)) {
    holidaydivision <- NULL
  }
  if (rlang::is_missing(from)) {
    from <- NULL
  }
  if (rlang::is_missing(to)) {
    to <- NULL
  }
  query <- list(holidaydivision = holidaydivision, from = from, to = to)
  get_full_data("/markets/trading_calendar", query, "trading_calendar", "pagination_key", FALSE, id_token)
}

#' @rdname get_info
#' @export
get_topix <- function(from, to, id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
  if (rlang::is_missing(from)) {
    from <- NULL
  }
  if (rlang::is_missing(to)) {
    to <- NULL
  }
  query <- list(from = from, to = to)
  get_full_data("/indices/topix", query, "topix", "pagination_key", TRUE, id_token)
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
  get_full_data("/fins/statements", query, "statements", "pagination_key", TRUE, id_token)
}

#' @rdname get_info
#' @export
get_financial_details <- function(code, date, id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
  if (rlang::is_missing(code)) {
    code <- NULL
  }
  if (rlang::is_missing(date)) {
    date <- NULL
  }
  query <- list(code = code, date = date)
  get_full_data("/fins/fs_details", query, "fs_details", "pagination_key", TRUE, id_token)
}

#' @rdname get_info
#' @export
get_financial_dividend <- function(code, from, to, date, id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
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
  get_full_data("/fins/dividend", query, "dividend", "pagination_key", TRUE, id_token)
}

#' @rdname get_info
#' @export
get_financial_announcement <- function(id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
  query <- NULL
  get_full_data("/fins/announcement", query, "announcement", "pagination_key", TRUE, id_token)
}

#' @rdname get_info
#' @export
get_index_option <- function(date = date, id_token = Sys.getenv("JQUANTSR_ID_TOKEN")) {
  if (rlang::is_missing(date)) {
    date <- NULL
  }
  query <- list(date = date)
  get_full_data("/option/index_option", query, "index_option", "pagination_key", TRUE, id_token)
}
