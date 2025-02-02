% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/norm_data.R
\name{norm_ped}
\alias{norm_ped}
\title{Normalise a Ped object dataframe}
\usage{
norm_ped(
  ped_df,
  na_strings = c("NA", ""),
  missid = NA_character_,
  try_num = FALSE
)
}
\arguments{
\item{ped_df}{A data.frame with the individuals informations.
The minimum columns required are:

\if{html}{\out{<div class="sourceCode">}}\preformatted{- `indID` individual identifiers -> `id`
- `fatherId` biological fathers identifiers -> `dadid`
- `motherId` biological mothers identifiers -> `momdid`
- `gender` sex of the individual -> `sex`
- `family` family identifiers -> `famid`
}\if{html}{\out{</div>}}

The \code{family} column, if provided, will be merged to the \emph{ids} field
separated by an underscore using the \code{\link[=upd_famid_id]{upd_famid_id()}} function.

The following columns are also recognize and will be transformed with the
\code{\link[=vect_to_binary]{vect_to_binary()}} function:

\if{html}{\out{<div class="sourceCode">}}\preformatted{- `sterilisation` status -> `steril`
- `available` status -> `avail`
- `vitalStatus`, is the individual dead -> `status`
- `affection` status -> `affected`
}\if{html}{\out{</div>}}

The values recognized for those columns are \code{1} or \code{0}, \code{TRUE} or \code{FALSE}.}

\item{na_strings}{Vector of strings to be considered as NA values.}

\item{missid}{A character vector with the missing values identifiers.
All the id, dadid and momid corresponding to those values will be set
to \code{NA_character_}.}

\item{try_num}{Boolean defining if the function should try to convert
all the columns to numeric.}
}
\value{
A dataframe with different variable correctly standardized
and with the errors identified in the \code{error} column
}
\description{
Normalise dataframe for a Ped object
}
\details{
Normalise a dataframe and check for columns correspondance
to be able to use it as an input to create a Ped object.
Multiple test are done and errors are checked.
Sex is calculated based on the \code{gender} column.

The \code{steril} column need to be a boolean either TRUE, FALSE or 'NA'.
Will be considered available any individual with no 'NA' values in the
\code{available} column.
Duplicated \code{indId} will nullify the relationship of the individual.
All individuals with errors will be remove from the dataframe and will
be transfered to the error dataframe.

A number of checks are done to ensure the dataframe is correct:
\subsection{On identifiers:}{
\itemize{
\item All ids (id, dadid, momid, famid) are not empty (\verb{!= ""})
\item All \code{id} are unique (no duplicated)
\item All \code{dadid} and \code{momid} are unique in the id column (no duplicated)
\item id is not the same as dadid or momid
\item Either have both parents or none
}
}

\subsection{On sex}{
\itemize{
\item All sex code are either \code{male}, \code{female}, \code{terminated} or \code{unknown}.
\item No parents are steril
\item All fathers are male
\item All mothers are female
}
}
}
\examples{
df <- data.frame(
    indId = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
    fatherId = c("A", 0, 1, 3, 0, 4, 1, 0, 6, 6),
    motherId = c(0, 0, 2, 2, 0, 5, 2, 0, 8, 8),
    gender = c(1, 2, "m", "man", "f", "male", "m", "m", "f", "f"),
    available = c("A", "1", 0, NA, 1, 0, 1, 0, 1, 0),
    famid = c(1, 1, 1, 1, 1, 1, 1, 2, 2, 2),
    sterilisation = c("TRUE", "FALSE", TRUE, FALSE, 1, 0, 1, 0, 1, "TRUE"),
    vitalStatus = c("TRUE", "FALSE", TRUE, FALSE, 1, 0, 1, 0, 1, 0),
    affection = c("TRUE", "FALSE", TRUE, FALSE, 1, 0, 1, 0, 1, 0)
)
tryCatch(
     norm_ped(df),
     error = function(e) print(e)
)

}
\seealso{
\code{\link[=Ped]{Ped()}}, \linkS4class{Ped}, \code{\link[=Pedigree]{Pedigree()}}
}
