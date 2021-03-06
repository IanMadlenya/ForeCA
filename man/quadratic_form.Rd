% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/quadratic_form.R
\name{quadratic_form}
\alias{fill_hermitian}
\alias{quadratic_form}
\title{Computes quadratic form x' A x}
\usage{
quadratic_form(mat, vec)

fill_hermitian(mat)
}
\arguments{
\item{mat}{numeric; \eqn{n \times n} matrix (real or complex).}

\item{vec}{numeric; \eqn{n \times 1} vector (real or complex).}
}
\value{
A real/complex value \eqn{\mathbf{x}' \mathbf{A} \mathbf{x}}.
}
\description{
\code{quadratic_form} computes the quadratic form \eqn{\mathbf{x}' \mathbf{A} \mathbf{x}} for an
\eqn{n \times n} matrix \eqn{\mathbf{A}} and an \eqn{n}-dimensional vector
\eqn{\mathbf{x}}, i.e., a wrapper for \code{t(x) \%*\% A \%*\% x}. 

\code{fill_symmetric} and \code{quadratic_form} work with 
real and complex valued matrices/vectors.

\code{fill_hermitian} fills up the lower triangular part (\code{NA})
of an upper triangular matrix to its
Hermitian (symmetric if real matrix) version, such that it satisfies 
\eqn{\mathbf{A} = \bar{\mathbf{A}}'}, where \eqn{\bar{z}} is the complex
conjugate of \eqn{z}.  If the matrix is real-valued this makes it 
simply symmetric.

Note that the input matrix must have a \strong{real-valued} diagonal and 
\code{NA}s in the lower triangular part.
}
\examples{
 set.seed(1)
 AA <- matrix(1:4, ncol = 2)
 bb <- matrix(rnorm(2))
 t(bb) \%*\% AA \%*\% bb
 quadratic_form(AA, bb)



AA <- matrix(1:16, ncol = 4)
AA[lower.tri(AA)] <- NA
AA

fill_hermitian(AA)

}
\keyword{math}
\keyword{univar}

