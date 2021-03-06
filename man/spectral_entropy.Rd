% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spectral_entropy.R
\name{spectral_entropy}
\alias{spectral_entropy}
\title{Estimates spectral entropy of a time series}
\usage{
spectral_entropy(series = NULL, spectrum.control = list(),
  entropy.control = list(), mvspectrum.output = NULL, ...)
}
\arguments{
\item{series}{univariate time series of length \eqn{T}.  In the rare case
that users want to call this for a multivariate time \code{series}, note 
that the estimated spectrum is in general \emph{not} normalized for the computation. 
Only if the original data is whitened, then it is normalized.}

\item{spectrum.control}{list; control settings for spectrum estimation. 
See \code{\link{complete_spectrum_control}} for details.}

\item{entropy.control}{list; control settings for entropy estimation.
See \code{\link{complete_entropy_control}} for details.}

\item{mvspectrum.output}{optional; one can directly provide an estimate of 
the spectrum of \code{series}. Usually the output of \code{\link{mvspectrum}}.}

\item{...}{additional arguments passed to \code{\link{mvspectrum}}.}
}
\value{
A non-negative real value for the spectral entropy \eqn{H_s(x_t)}.
}
\description{
Estimates \emph{spectral entropy} from a univariate (or multivariate) 
normalized spectral density.
}
\details{
The \emph{spectral entropy} equals the Shannon entropy of the spectral density
\eqn{f_x(\lambda)} of a stationary process \eqn{x_t}: 
\deqn{ 
H_s(x_t) = - \int_{-\pi}^{\pi} f_x(\lambda) \log f_x(\lambda) d \lambda, 
}
where the density is normalized such that 
\eqn{\int_{-\pi}^{\pi} f_x(\lambda) d \lambda = 1}. An estimate of \eqn{f(\lambda)}
 can be obtained 
by the (smoothed) periodogram (see \code{\link{mvspectrum}}); thus using discrete, and 
not continuous entropy.
}
\examples{

set.seed(1)
eps <- rnorm(100)
spectral_entropy(eps)

phi.v <- seq(-0.95, 0.95, by = 0.1)
kMethods <- c("wosa", "multitaper", "direct", "pgram")
SE <- matrix(NA, ncol = length(kMethods), nrow = length(phi.v))
for (ii in seq_along(phi.v)) {
  xx.tmp <- arima.sim(n = 200, list(ar = phi.v[ii]))
  for (mm in seq_along(kMethods)) {
    SE[ii, mm] <- spectral_entropy(xx.tmp, spectrum.control = 
                                     list(method = kMethods[mm]))
  }
}

matplot(phi.v, SE, type = "l", col = seq_along(kMethods))
legend("bottom", kMethods, lty = seq_along(kMethods), 
       col = seq_along(kMethods))
       
# AR vs MA
SE.arma <- matrix(NA, ncol = 2, nrow = length(phi.v))
SE.arma[, 1] <- SE[, 2]

for (ii in seq_along(phi.v)){
  yy.temp <- arima.sim(n = 1000, list(ma = phi.v[ii]))
  SE.arma[ii, 2] <- 
    spectral_entropy(yy.temp, spectrum.control = list(method = "multitaper"))
}

matplot(phi.v, SE.arma, type = "l", col = 1:2, xlab = "parameter (phi or theta)",
        ylab = "Spectral entropy")
abline(v = 0, col = "blue", lty = 3)
legend("bottom", c("AR(1)", "MA(1)"), lty = 1:2, col = 1:2)

}
\references{
Jerry D. Gibson and Jaewoo Jung (2006). \dQuote{The
Interpretation of Spectral Entropy Based Upon Rate Distortion Functions}.
IEEE International Symposium on Information Theory, pp. 277-281.

L. L. Campbell, \dQuote{Minimum coefficient rate for stationary random processes}, 
Information and Control, vol. 3, no. 4, pp. 360 - 371, 1960.
}
\seealso{
\code{\link{Omega}}, \code{\link{discrete_entropy}}
}
\keyword{math}
\keyword{ts}
\keyword{univar}

