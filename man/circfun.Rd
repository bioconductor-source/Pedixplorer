% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_fct.R
\name{circfun}
\alias{circfun}
\title{Circular element}
\usage{
circfun(nslice, n = 50)
}
\arguments{
\item{nslice}{Number of slices in the circle}

\item{n}{Total number of points in the circle}
}
\value{
A list of x and y coordinates per slice.
}
\description{
Create a list of x and y coordinates for a circle
with a given number of slices.
}
\examples{

circfun(1)
circfun(1, 10)
circfun(4, 50)
}
\keyword{Pedigree-plot}
\keyword{internal,}
