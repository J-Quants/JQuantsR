#' Get data from API and return the content
#'
#' @param resource_path a string resource_path.
#' @param query a list or NULL A list must be contain query parameters.
#' @param id_token a string id_token.
#' @return a httr::content() object
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

  return(content)
}

#' Extract content from the fetched data
#'
#' @param content a httr::content() object (return of `get_from_key`)
#' @param data_key_name a string the key name of data (such as "daily_quotes").
#' @param pagination_key_name a string or NULL the key name of pagination key. If not contained, NULL.
#' @return a list (the data and pagination_key)
#'
#' @examples
#' \dontrun{
#' content <- get_from_api("/prices/daily_quotes", list(date = "20201001", code = "86970"))
#' extract_from_content(content, "daily_quotes", "pagination_key")
#' }
extract_from_content <- function(content, data_key_name, pagination_key_name) {
  data <- content %>%
    magrittr::extract2(data_key_name)

  if (data_key_name == "fs_details") {
    if (length(data) == 0L) {
      return(tibble())
    }
    data <- data %>%
      dplyr::bind_rows() %>%
      tibble::as_tibble() %>%
      mutate(
        FinancialStatementName = names(FinancialStatement),
        FinancialStatementValue = flatten_chr(FinancialStatement)
      ) %>%
      select(-FinancialStatement)
  } else {
    data <- data %>%
      purrr::map(function(x) {
        purrr::map(x, function(y) {
          ifelse(is.null(y), NA, y)
        })
      }) %>%
      data.table::rbindlist() %>%
      tibble::as_tibble()
  }
  pagination_key <- content %>%
    magrittr::extract2(pagination_key_name)
  return(list(data=data, pagination_key=pagination_key))
}

#' Get all data from API, considering pagination_key
#'
#' @param resource_path a string resource_path.
#' @param query a list or NULL A list must be contain query parameters.
#' @param data_key_name a string the key name of data (such as "daily_quotes").
#' @param pagination_key_name a string or NULL the key name of pagination key. If not contained, NULL.
#' @param is_paginationable a bool whether the data from the resource path can have pagination key.
#' @param id_token a string id_token.
#' @return a tibble
#'
#' @examples
#' \dontrun{
#' get_full_data("/listed/info", list(date="20220701"), "info", "pagination_key", FALSE, id_token)
#' get_full_data("/prices/daily_quotes", list(date = "20201001", code = "86970"), "daily_quotes", "pagination_key", TRUE, id_token)
#' }
get_full_data <- function(resource_path, query, data_key_name, pagination_key_name, is_paginationable, id_token) {
  if (!is_paginationable) {
    content <- get_from_api(resource_path, query, id_token)
    extracted_content <- extract_from_content(content, data_key_name, pagination_key_name)
    data <- extracted_content[["data"]]
    return(data)
  }
  else {
    data <- list()
    query <- c(query, list(pagination_key = NULL))
    while (TRUE) {
      content <- get_from_api(resource_path, query, id_token)
      extracted_content <- extract_from_content(content, data_key_name, pagination_key_name)

      data_tmp <- extracted_content[["data"]]
      pagination_key_tmp <- extracted_content[["pagination_key"]]
      data <- c(data, list(data_tmp))

      if (is.null(pagination_key_tmp)) {
        break
      }
      query[["pagination_key"]] <- pagination_key_tmp
      rlang::inform(glue::glue("continue to next pagination: pagination_key={pagination_key_tmp}"))
    }
    data <- dplyr::bind_rows(data)
    return(data)
  }
}
