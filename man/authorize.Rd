% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/authorize.R
\name{authorize}
\alias{authorize}
\title{Get ID_token from J-Quants API and set your ID_token in a environment variable}
\usage{
authorize(refresh_token = Sys.getenv("JQUANTSR_REFRESH_TOKEN"))
}
\arguments{
\item{refresh_token}{a string your refresh_token.
If you have set a environment variable named "JQUANTSR_REFRESH_TOKEN", you don't need to set "refresh_token" parameter.}
}
\value{
a string your id_token.
}
\description{
Get ID_token from J-Quants API and set your ID_token in a environment variable
}
\examples{
\dontrun{
authorize(your_refresh_token)
}
}