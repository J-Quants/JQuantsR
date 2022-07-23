#' Get ID_token from J-Quants API and set your ID_token in a environment variable
#'
#' @param refresh_token a string your refresh_token.
#' If you have set a environment variable named "JQUANTSR_REFRESH_TOKEN", you don't need to set "refresh_token" parameter.
#' @return a string your id_token.
#'
#' @examples
#' \dontrun{
#' authorize(your_refresh_token)
#' }
#' @export
authorize <- function(refresh_token = Sys.getenv("JQUANTSR_REFRESH_TOKEN")) {
  endpoint <- paste0(BASE_URL, "/token/auth_refresh")
  resp <- httr::POST(
    endpoint,
    query = list(refreshtoken = refresh_token),
    httr::user_agent(USER_AGENT)
  )

  status_code <- httr::status_code(resp)
  content <- httr::content(resp)

  if (status_code != 200L) {
    rlang::abort(glue::glue("status_code: {status_code}\nmessage: {content$message}"))
  }

  res <- content$idToken
  Sys.setenv(JQUANTSR_ID_TOKEN = res)
  rlang::inform("You have successfully gotten your ID token.\nYour ID token is set in a environment variable as 'JQUANTSR_ID_TOKEN'.")
  invisible(res)
}
