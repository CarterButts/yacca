\name{helio.plot}
\alias{helio.plot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Helio Plots }
\description{
  Displays data using a circular layout; function is designed to be used with \code{\link{cca}} objects, but could perhaps be rigged for use in other circumstances.
}
\usage{
helio.plot(c, cv = 1, xvlab = c$xlab, yvlab = c$ylab, 
    x.name = "X Variables", y.name = "Y Variables", lab.cex = 1,
    wid.fact = 0.75, main = "Helio Plot", 
    sub = paste("Canonical Variate", cv, sep = ""), zero.rad = 30, 
    range.rad = 20, name.padding = 5, name.cex = 1.5, 
    axis.circ = c(-1, 1), x.group = rep(0, dim(c$xstructcorr)[1]),
    y.group = rep(0, dim(c$ystructcorr)[1]), type = "correlation")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{c}{ object to be plotted (generally output from \code{\link{cca}}. }
  \item{cv}{ the canonical variate to display. }
  \item{xvlab}{ X variable labels. }
  \item{yvlab}{ Y variable labels. }
  \item{x.name}{ name for the X variable set. }
  \item{y.name}{ name for the Y variable set. }
  \item{lab.cex}{ character expansion for plot labels. }
  \item{wid.fact}{ width multiplier for data bars. }
  \item{main}{ plot main title. }
  \item{sub}{ plot subtitle. }
  \item{zero.rad}{ radius for the zero-value reference circle. }
  \item{range.rad}{ difference between inner and outer plotting radius. }
  \item{name.padding}{ offset for variable names. }
  \item{name.cex}{ character expansion for variable names. }
  \item{axis.circ}{ location to draw axis circles. }
  \item{x.group}{ optional grouping vector for X variables.}
  \item{y.group}{ optional grouping vector for Y variables. }
  \item{type}{ one of \dQuote{correlation} or \dQuote{variance}, depending on the type of data to be displayed. }
}
\details{
  Helio plots display data in radial bars, with larger values pointing outward from a base reference circle and smaller (more negative) values pointing inward).  Such plots are well-suited to the display of multivariate information with several groups of variables, as with canonical correlation analysis.
}
\value{
  None.
}
%\references{ ~put references to the literature/web site here ~ }
\author{ Carter T. Butts <buttsc@uci.edu> }
%\note{ ~~further notes~~ 
%
% ~Make other sections like Warning with \section{Warning }{....} ~
%}
\seealso{ \code{\link{cca}} }
\examples{
data(LifeCycleSavings)
pop <- LifeCycleSavings[, 2:3]
oec <- LifeCycleSavings[, -(2:3)]
cca.fit <- cca(pop, oec)

#Show loadings on first canonical variate
helio.plot(cca.fit, x.name="Population Variables", 
    y.name="Economic Variables")

#Show variances on second canonical variate
helio.plot(cca.fit, cv=2, x.name="Population Variables", 
    y.name="Economic Variables", type="variance")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ hplot }
