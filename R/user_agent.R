default_user_agent <- function() {
  versions <- c(
    libcurl = curl::curl_version()$version,
    `r-curl` = as.character(utils::packageVersion("curl")),
    httr = as.character(utils::packageVersion("httr")),
    JQuantsR = as.character(packageVersion("JQuantsR"))
  )
  default_user_agent <- paste0(names(versions), "/", versions, collapse = " ")
  return(default_user_agent)
}
