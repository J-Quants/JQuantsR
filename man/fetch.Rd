% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fetch.R
\name{fetch}
\alias{fetch}
\title{Fetch from API and return the content}
\usage{
fetch(resource_path, query, id_token)
}
\arguments{
\item{resource_path}{a string resource_path.}

\item{query}{a list or NULL A list must be contain query parameters.}

\item{id_token}{a string id_token.}
}
\value{
a httr::content() object
}
\description{
Fetch from API and return the content
}
\examples{
\dontrun{
fetch("/listed/info", NULL, id_token)
fetch("/prices/daily_quotes", list(date = "20201001", code = "86970"))
}
}
