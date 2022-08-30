#' Market information code
#'
#' @description A tibble of market type and market code
#' which is the same as a "MarketCode" column in a return tibble of "get_info()".
#' @format
#' A tibble with 12 rows 2 columns:
#' \itemize{
#'   \item{MarketType}: {Market type}
#'   \item{MarketCode}: {The same as a "MarketCode" column in a return tibble of "get_info()"}
#' }
#' @examples
#' \dontrun{
#' market_information
#' }
#' @source \url{https://jpx.gitbook.io/j-quants-api/api-reference/listed-api/segment}
"market_information"
