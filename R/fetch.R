#' Fetch from API and return the content
#'
#' @param resource_path a string resource_path.
#' @param query a list or NULL A list must be contain query parameters.
#' @param id_token a string id_token.
#' @return a httr::content() object
#'
#' @examples
#' \dontrun{
#' fetch("/listed/info", NULL, id_token)
#' fetch("/prices/daily_quotes", list(date = "20201001", code = "86970"))
#' }
fetch <- function(resource_path, query, id_token) {
  endpoint <- paste0(BASE_URL, resource_path)
  resp <- httr::RETRY(
    "GET",
    endpoint,
    times = 3,
    query = query,
    httr::add_headers(Authorization = as.character(glue::glue("Bearer {id_token}"))),
    httr::user_agent(get_user_agent())
  )

  status_code <- httr::status_code(resp)
  content <- httr::content(resp)

  if (status_code != 200L) {
    rlang::abort(glue::glue("status_code: {status_code}\nmessage: {content$message}"))
  }

  return(content)
}

#' Get all data from API, considering pagination_key
#'
#' @param resource_path a string resource_path.
#' @param query a list or NULL A list must be contain query parameters.
#' @param key_name a string the key name of data (such as "daily_quotes").
#' @param id_token a string id_token.
#' @return a tibble
#'
#' @examples
#' \dontrun{
#' get_full_data("/listed/info", list(date="20220701"), "info", id_token)
#' get_full_data("/prices/daily_quotes", list(date = "20201001", code = "86970"), "daily_quotes", id_token)
#' }
get_full_data <- function(resource_path, query, key_name, id_token) {
  data <- list()
  query <- c(query, list(pagination_key = NULL))
  while (TRUE) {
    content <- fetch(resource_path, query, id_token)
    pagination_key <- content[["pagination_key"]]
    data <- c(data, content[[key_name]])

    if (is.null(pagination_key)) {
      break
    }
    query[["pagination_key"]] <- pagination_key
    rlang::inform(glue::glue("continue to next pagination: pagination_key={pagination_key}"))
  }
  data <- data |>
    purrr::modify_tree(leaf = \(x) {ifelse(is.null(x), NA, x)})

  if (key_name == "fs_details" & length(data) > 1L) {
    res <- data |>
      dplyr::bind_rows() |>
      dplyr::mutate(
        FinancialStatementName = names(FinancialStatement),
        FinancialStatementValue = purrr::flatten_chr(FinancialStatement)
      ) |>
      dplyr::select(-FinancialStatement)
    return(res)
  }

  res <- data |>
    data.table::rbindlist() |>
    tibble::as_tibble()
  return(res)
}

#' Get user agent string
#'
#' @return a string
get_user_agent <- function() {
  versions <- c(
    libcurl = curl::curl_version()$version,
    `r-curl` = as.character(utils::packageVersion("curl")),
    httr = as.character(utils::packageVersion("httr")),
    JQuantsR = as.character(utils::packageVersion("JQuantsR")),
    R = stringr::str_extract(R.version.string, "[0-9]+\\.[0-9]+\\.[0-9]+")
  )
  user_agent <- paste0(names(versions), "/", versions, collapse = " ")
  return(user_agent)
}
