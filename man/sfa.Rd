% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sfa.R
\name{sfa}
\alias{sfa}
\title{Slow Feature Analysis}
\usage{
sfa(series, ...)
}
\arguments{
\item{series}{a \eqn{T \times K} array with \code{T} observations from the 
\eqn{K}-dimensional time series \eqn{\mathbf{X}_t}. Can be a \code{matrix}, \code{data.frame}, 
or a multivariate \code{ts} object.}

\item{...}{additional arguments}
}
\value{
An object of class \code{sfa} which inherits methods from \code{\link[stats]{princomp}}.
Signals are ordered from slowest to fastest.
}
\description{
\code{sfa} performs Slow Feature Analysis (SFA) on a 
\eqn{K}-dimensional time series with \eqn{T} observations.

\strong{Important:} This implementation of SFA is just the most basic
version; it is merely included here for convenience in 
\code{\link{initialize_weightvector}}.  If you want to use SFA in R please
use the \pkg{rSFA} package, which has many more advanced and efficient implementations
of SFA.  \code{sfa()} here corresponds to \code{sfa1} in the \pkg{rSFA} package.
}
\details{
Slow Feature Analysis (SFA) finds \emph{slow} signals (see References below),
and can be quickly (and analytically) computed solving a generalized eigen-value
problem.   For ForeCA it is important to know that SFA is equivalent to
finding the signal with largest lag \eqn{1} autocorrelation.

The disadvantage of SFA for forecasting is that, e.g., white noise (WN) 
is ranked higher than an AR(1) with negative autocorrelation coefficient 
\eqn{\rho_1 < 0}.  While it is true that WN is slower, it is not more 
forecastable.  Thus we are also interested in the fastest signal, i.e.,
the last eigenvector. The so obtained fastest signal corresponds to minimizing
the lag 1 auto-correlation (possibly \eqn{\rho_1 < 0}).

Note though that maximizing (or minimizing) the lag \eqn{1} auto-correlation does 
not necessarily yield the most forecastable signal (as measured 
by \code{\link{Omega}}), but it is a good start.
}
\examples{
XX <- diff(log(EuStockMarkets[-c(1:100),])) * 100
plot(ts(XX))
ss <- sfa(XX[,1:4])

summary(ss)
plot(ss)
plot(ts(ss$scores))
apply(ss$scores, 2, function(x) acf(x, plot = FALSE)$acf[2])
biplot(ss)

}
\references{
Laurenz Wiskott and Terrence J. Sejnowski (2002). 
\dQuote{Slow Feature Analysis: Unsupervised Learning of Invariances}, 
Neural Computation 14:4, 715-770.
}
\seealso{
\code{\link{initialize_weightvector}}
}

