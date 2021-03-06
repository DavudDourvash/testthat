% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expect-output.R
\name{output-expectations}
\alias{output-expectations}
\alias{expect_output}
\alias{expect_error}
\alias{expect_message}
\alias{expect_warning}
\alias{expect_silent}
\title{Expectation: does code produce output/message/warning/error?}
\usage{
expect_output(object, regexp = NULL, ..., info = NULL, label = NULL)

expect_error(object, regexp = NULL, class = NULL, ..., info = NULL,
  label = NULL, language = NULL)

expect_message(object, regexp = NULL, ..., all = FALSE, info = NULL,
  label = NULL)

expect_warning(object, regexp = NULL, ..., all = FALSE, info = NULL,
  label = NULL)

expect_silent(object)
}
\arguments{
\item{object}{object to test}

\item{regexp}{regular expression to test against.

If \code{NULL}, the default, asserts that there should be an output,
a messsage, a warning, or an error, but does not test for specific value.

If \code{NA}, asserts that there should be no output, messages, warnings,
or errors.}

\item{...}{Arguments passed on to \code{expect_match}
\describe{
  \item{all}{Should all elements of actual value match \code{regexp} (TRUE),
or does only one need to match (FALSE)}
  \item{perl}{logical.  Should Perl-compatible regexps be used?}
  \item{fixed}{logical.  If \code{TRUE}, \code{pattern} is a string to be
    matched as is.  Overrides all conflicting arguments.}
}}

\item{info}{extra information to be included in the message (useful when
writing tests in loops).}

\item{label}{object label. When \code{NULL}, computed from deparsed object.}

\item{class}{Instead of supplying a regular expression, you can also supply
a class name. This is useful for "classed" conditions.}

\item{language}{Optionally overrides current language so that error messages
are constant regardless of system language. Most common option is "en".}

\item{all}{For messages and warnings, do all need to match the \code{regexp}
(TRUE), or does only one need to match (FALSE)}
}
\value{
All expectations apart from \code{expect_error()} invisibly return the
first argument. \code{expect_error()} always invisibly returns \code{NULL}.
}
\description{
Use \code{expect_output()}, \code{expect_message()}, \code{expect_warning()},
or \code{expect_error()} to check for specific outputs. Use
\code{expect_silent()} to assert that there should be no output of
any type. The file-based \code{expect_output_file()} compares the output
to the contents of a text file and optionally updates it.
}
\details{
Note that warnings are captured by a custom signal handler: this means
that \code{options(warn)} has no effect.
}
\examples{
# Output --------------------------------------------------------------------
str(mtcars)
expect_output(str(mtcars), "32 obs")
expect_output(str(mtcars), "11 variables")

# You can use the arguments of grepl to control the matching
expect_output(str(mtcars), "11 VARIABLES", ignore.case = TRUE)
expect_output(str(mtcars), "$ mpg", fixed = TRUE)

# Messages ------------------------------------------------------------------

f <- function(x) {
  if (x < 0) message("*x* is already negative")
  -x
}
expect_message(f(-1))
expect_message(f(-1), "already negative")
expect_message(f(1), NA)

# You can use the arguments of grepl to control the matching
expect_message(f(-1), "*x*", fixed = TRUE)
expect_message(f(-1), "NEGATIVE", ignore.case = TRUE)

# Warnings --------------------------------------------------------------------
f <- function(x) {
  if (x < 0) warning("*x* is already negative")
  -x
}
expect_warning(f(-1))
expect_warning(f(-1), "already negative")
expect_warning(f(1), NA)

# You can use the arguments of grepl to control the matching
expect_warning(f(-1), "*x*", fixed = TRUE)
expect_warning(f(-1), "NEGATIVE", ignore.case = TRUE)

# Errors --------------------------------------------------------------------
f <- function() stop("My error!")
expect_error(f())
expect_error(f(), "My error!")

# You can use the arguments of grepl to control the matching
expect_error(f(), "my error!", ignore.case = TRUE)

# Silent --------------------------------------------------------------------
expect_silent("123")

f <- function() {
  message("Hi!")
  warning("Hey!!")
  print("OY!!!")
}
\dontrun{
expect_silent(f())
}
}
\seealso{
Other expectations: \code{\link{comparison-expectations}},
  \code{\link{equality-expectations}},
  \code{\link{expect_length}}, \code{\link{expect_match}},
  \code{\link{expect_named}},
  \code{\link{inheritance-expectations}},
  \code{\link{logical-expectations}}
}
