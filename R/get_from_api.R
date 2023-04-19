#' Get data from J-Quants API and return the data

#' @param resource_path a string resource_path.
#' @param query a list or NULL A list must be contain query parameters.
#' @param id_token a string id_token.
#' @return a tibble
#'
#' @examples
#' \dontrun{
#' get_from_api("/listed/info", NULL, id_token)
#' get_from_api("/prices/daily_quotes", list(date = "20201001", code = "86970"))
#' }
get_from_api <- function(resource_path, query, id_token) {
  endpoint <- paste0(BASE_URL, resource_path)
  resp <- httr::RETRY(
    "GET",
    endpoint,
    times = 3,
    query = query,
    httr::add_headers(Authorization = as.character(glue::glue("Bearer {id_token}"))),
    httr::user_agent(default_user_agent())
  )

  status_code <- httr::status_code(resp)
  content <- httr::content(resp)

  if (status_code != 200L) {
    rlang::abort(glue::glue("status_code: {status_code}\nmessage: {content$message}"))
  }

  res <- content %>%
    magrittr::extract2(1) %>%
    purrr::map(function(x) {
      purrr::map(x, function(y) {
        ifelse(is.null(y), NA, y)
      })
    }) %>%
    data.table::rbindlist() %>%
    tibble::as_tibble()
  return(res)
}
