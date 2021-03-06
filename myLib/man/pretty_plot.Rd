% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/pretty_plot.R
\name{pretty_plot}
\alias{pretty_plot}
\title{pretty_plot}
\usage{
pretty_plot(df, xlim = NULL, ylim = NULL, type = "l", main = "",
  xlab = "", ylab = "", lwd = 1, lty = 1, cex = 0.5, kleur = 1,
  transparent = FALSE, ccloc = 1, pch = 19, add = FALSE,
  source = NULL, xat = NULL, yat = NULL, mai = NULL, palet = 2, ...)
}
\arguments{
\item{df}{a 2 column data frame or a time series}

\item{type}{extension of styandard plot type. "e" is empty, "f"is a fanplot, "v" is an area below the line plot, "a" is a polygon with lower side in df[,3]}

\item{kleur}{the palet colour}

\item{ccloc}{the location of the Creative Common License within the plot}

\item{add}{if TRUE, add content to existing plot, otherwise produce a new one}

\item{source}{small note in lower right bottom for source of data}

\item{palet}{the palet to choose (1-4)}
}
\value{
NA
}
\description{
put a palet wrapper around the standard plot (function) with extra's
}
\examples{
# pretty_plot(hc4, type="f")
}

