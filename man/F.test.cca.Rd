\name{F.test.cca}
\alias{F.test.cca}
\alias{print.F.test.cca}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ F Test for Canonical Correlations Using Rao's Approximation}
\description{
  Tests a series of canonical correlations (sequentially) against the null hypothesis that the tested coefficient and all succeeding coefficients are zero.
}
\usage{
F.test.cca(x, \dots)

\method{print}{F.test.cca}(x, \dots)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ a \code{cca} object.  }
  \item{\dots}{ additional arguments.}
}
\details{
  Several related tests have been proposed for the evaluation of canonical correlations (including Bartlett's Chi-squared test, which is computed by default within \code{\link{cca}}).  This function employs Rao's statistic (related to Wilks' Lambda) as the basis for an F test of each coefficient (and all others in ascending sequence) against the hypothesis that the associated population correlations are zero.
}
\value{
  An object of class \code{F.test.cca}, whose elements are as follows:
  \item{corr }{Canonical correlations.}
  \item{statistic }{Squared canonical correlations (shared variance across canonical variates).}
  \item{parameter }{Coefficients for the \code{x} variables on each canonical variate.}
  \item{p.value }{Coefficients for the \code{y} variables on each canonical variate.}
  \item{method }{Canonical variate scores for the \code{x} variables.}
  \item{data.name }{Canonical variate scores for the \code{y} variables.}
}
\references{ Mardia, K. V.; Kent, J. T.; and Bibby, J. M.  1979.  \emph{Multivariate Analysis}.  London: Academic Press. }
\author{ 
Nicholas L. Crookston <ncrookston@fs.fed.us>

Carter T. Butts <buttsc@uci.edu> }
%\note{ ~~further notes~~ 
%
% ~Make other sections like Warning with \section{Warning }{....} ~
%}
\seealso{ \code{\link{cca}} }
\examples{
#Example: perceived personal attributes versus professional performance
#for US Judges
data(USJudgeRatings)
personal <- USJudgeRatings[,c("INTG","DMNR","DILG","FAMI","PHYS")]
performance <- USJudgeRatings[,c("CFMG","DECI","PREP","ORAL","WRIT")]
cca.fit <- cca(personal, performance)

#Test the canonical correlations (see also summary(cca.fit))
F.test.cca(cca.fit)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ htest }
\keyword{ multivariate }% __ONLY ONE__ keyword per line
