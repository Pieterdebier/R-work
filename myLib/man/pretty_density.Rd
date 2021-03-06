% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/pretty_density.R
\name{pretty_density}
\alias{pretty_density}
\title{pretty_density}
\usage{
pretty_density(data, xlab = "value", ylab = "",
  main = "Density plot with 95\% confidence interval", kleur = 1,
  ccloc = 0, mid = NA, ...)
}
\arguments{
\item{data}{a vector with the data}

\item{kleur}{the line color in the palet}

\item{mid}{is NA, the mean of the data, otherwise a given value such as median}

\item{...}{other values for pretty_plot}
}
\value{
NA
}
\description{
makes a pretty density plot with mean and CI
}
\examples{
# pretty_density(rnorm(1000, 0,1), mid=0)
}

