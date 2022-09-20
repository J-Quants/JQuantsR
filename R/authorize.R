#' Get ID_token from J-Quants API and set your refresh token and ID token in a environment variable
#'
#' @description Get ID_token from J-Quants API and set your refresh token and ID token in a environment variable.
#'
#' Normally, you don't have to run "authorize_refresh_token()" and "authorize_id_token()".
#' You only have to run "authorize()" to acquire refresh token and ID token.
#'
#' Your refresh token and ID token are set in enrivonment variables
#' named "JQUANTSR_REFRESH_TOKEN" and JQUANTSR_ID_TOKEN".
#'
#' @param mail_address a string your mail address.
#' @param password a string your password.
#' @return
#' \itemize{
#'   \item{"authorize()"}: {a list your refresh token and ID token.}
#'   \item{"authorize_refresh_token()"}: {a character your refresh token.}
#'   \item{"authorize_id_token()"}: {a character your ID token.}
#' }
#' @examples
#' \dontrun{
#' authorize(your_mail_address, your_password)
#' }
#' @export
authorize <- function(mail_address = Sys.getenv("JQUANTSR_MAIL_ADDRESS"), password = Sys.getenv("JQUANTSR_PASSWORD")) {
  refresh_token <- authorize_refresh_token(mail_address = mail_address, password = password)
  id_token <- authorize_id_token(refresh_token = refresh_token)
  invisible(list(refresh_token = refresh_token, id_token = id_token))
}

#' @rdname authorize
#' @export
authorize_refresh_token <- function(mail_address = Sys.getenv("JQUANTSR_MAIL_ADDRESS"), password = Sys.getenv("JQUANTSR_PASSWORD")) {
  endpoint <- paste0(BASE_URL, "/token/auth_user")
  resp <- httr::RETRY(
    "POST",
    endpoint,
    times = 3,
    body = jsonlite::toJSON(list(mailaddress = mail_address, password = password), auto_unbox = TRUE),
    httr::user_agent(default_user_agent())
  )

  status_code <- httr::status_code(resp)
  content <- httr::content(resp)

  if (status_code != 200L) {
    rlang::abort(glue::glue("status_code: {status_code}\nmessage: {content$message}"))
  }

  res <- content$refreshToken
  Sys.setenv(JQUANTSR_REFRESH_TOKEN = res)
  rlang::inform("You have successfully gotten your refresh token.\nYour refresh token is set in a environment variable as 'JQUANTSR_REFRESH_TOKEN'.")
  invisible(res)
}

#' @rdname authorize
#' @export
authorize_id_token <- function(refresh_token = Sys.getenv("JQUANTSR_REFRESH_TOKEN")) {
  endpoint <- paste0(BASE_URL, "/token/auth_refresh")
  resp <- httr::RETRY(
    "POST",
    endpoint,
    times = 3,
    query = list(refreshtoken = refresh_token),
    httr::user_agent(default_user_agent())
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
