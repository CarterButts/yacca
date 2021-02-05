\name{cca}
\alias{cca}
\alias{print.cca}
\alias{print.summary.cca}
\alias{summary.cca}
\alias{plot.cca}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Canonical Correlation Analysis }
\description{
  Performs a canonical correlation (and canonical redundancy) analysis on two sets of variables.
}
\usage{
cca(x, y, xlab = colnames(x), ylab = colnames(y), xcenter = TRUE, 
    ycenter = TRUE, xscale = FALSE, yscale = FALSE,
    standardize.scores = TRUE, use = "complete.obs", na.rm = TRUE,
    use.eigs = FALSE, max.dim = Inf, reg.param = NULL)

\method{plot}{cca}(x, \dots)

\method{print}{cca}(x, \dots)

\method{summary}{cca}(object, \dots)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ for \code{cca}, a single vector or a matrix whose columns contain the \code{x} variables.  Otherwise, a \code{cca} object.  }
  \item{y}{ a single vector or a matrix whose columns contain the \code{x} variables. }
  \item{xlab}{ an optional vector of \code{x} labels. }
  \item{ylab}{ an optional vector of \code{y} labels. }
  \item{xcenter}{ boolean; demean the \code{x} variables? }
  \item{ycenter}{ boolean; demean the \code{y} variables? }
  \item{xscale}{ boolean; scale the \code{x} variables to unit variance? }
  \item{yscale}{ boolean; scale the \code{y} variables to unit variance? }
  \item{standardize.scores}{ boolean; rescale scores (and coefficients) to produce scores of unit variance?}
  \item{use}{ \code{use} argument to be passed to \code{\link{var}} when creating covariance matrices. }
  \item{na.rm}{ boolean; remove missing values during redundancy analysis? }
  \item{use.eigs}{boolean; use \code{\link[RSpectra]{eigs}} instead of \code{\link{eigen}} for diagonalization?}
  \item{max.dim}{ maximum number of canonical variates to extract (only relevant if less than the minimum of the number of columns of \code{x} and \code{y})}
  \item{reg.param}{ an optional L2 regularization parameter (or vector thereof). }
  \item{object}{ a \code{cca} object.}
  \item{\dots}{ additional arguments.}
}
\details{
Canonical correlation analysis (CCA) is a form of linear subspace analysis, and involves the projection of two sets of vectors (here, the variable sets \code{x} and \code{y}) onto a joint subspace.  The goal of (CCA) is to find a squence of linear transformations of each variable set, such that the correlations between the transformed variables are maximized (under the proviso that each transformed variable must be orthogonal to those preceding it).  These transformed variables -- known as \dQuote{canonical variates} (CVs) -- can be thought of as expressing the common variation across the data sets, in a manner analogous to the role of principal components in within-set analysis (see, e.g., \code{\link{princomp}}).  Since the rank of the joint subspace is equal to the minimum of the ranks of the two spaces spanned by the initial data vectors, it follows that the number of CVs will usually be equal to the minimum of the number of \code{x} and \code{y} variables (perhaps fewer, if the sets are not of full rank or if \code{max.dim} is used to constrain the number of variables extracted).

Formally, we may describe the CCA solution as follows.  Given data matrices \eqn{X} and \eqn{Y}, let \eqn{\Sigma_{XX}}{Cxx}, \eqn{\Sigma_{XY}}{Cxy}, \eqn{\Sigma_{YX}}{Cyx} and \eqn{\Sigma_{YY}}{Cyy} be the respective sample covariance matrices for \eqn{X} versus itself, \eqn{X} versus \eqn{Y}, \eqn{Y} versus \eqn{X}, and \eqn{Y} versus itself.  Now, for some \eqn{i} less than or equal to the minimum rank of \eqn{X} and \eqn{Y}, let \eqn{u_i} be the \eqn{i}th eigenvector of \eqn{\Sigma_{XX}^{-1} \Sigma_{XY} \Sigma_{YY}^{-1} \Sigma_{YX}}{Cxx^-1 \%*\% Cxy \%*\% Cyy^-1 \%*\% Cyx}, with corresponding eigenvalue \eqn{\lambda_i}.  Then the vector \eqn{u_i} contains the coefficients projecting \eqn{X} onto the \eqn{i
}th canonical variate; the corresponding scores are given by \eqn{X u_i}{X \%*\% u_i}.  Similarly, let \eqn{v_i} be the \eqn{i}th eigenvector of \eqn{\Sigma_{YY}^{-1} \Sigma_{YX} \Sigma_{XX}^{-1} \Sigma_{XY}}{Cyy^-1 \%*\% Cyx \%*\% Cxx^-1 \%*\% Cxy}.  Then \eqn{v_i} contains the coefficients projecting \eqn{Y} onto the \eqn{i}th canonical variate (with scores \eqn{Y v_i}{Y \%*\% v_i}).  The eigenvalue in the second case will be the same as the first, and corresponds to the square of the \eqn{i}th canonical correlation for the CCA solution -- that is, the correlation between the \eqn{X} and \eqn{Y} scores on the \eqn{i}th canonical variate.  Since the canonical correlation structure is unaffected by rescaling of the canonical variate scores, it is common to adjust the coefficients \eqn{u_i} and \eqn{v_i} to ensure that the resulting scores have unit variance; this option is controlled here via the \code{standardize.scores} argument.

CCA output can be fairly complex.  Quantities of particular interest include the correlations between the original variables in each set and their respective canonical variates (\emph{structural correlations} or \emph{loadings}), the coefficients which take the original variables into the CVs, and of course the correlations between the CV scores in one set and their corresponding scores in the opposite set (the \emph{canonical correlations}).  The canonical correlations provide a basic measure of concordance between the transformed variables, but are surprisingly uninformative by themselves; canonical redundancies (see below) are of more typical interest.  Interpretation of CVs is usually performed by inspection of loadings, which reveal the extent to which each CV is associated with particular variables in each set.  The squared loadings, in particular, convey the fraction of variance in each original variable which is accounted for by a given CV (though not necessarily by the variables in the opposite set!).

A common interest in the context of CCA is the extent to which the variance of one set of variables can be accounted for by the other (in the usual least squares sense).  While it is tempting to interpret the squared canonical correlations in this manner, this is incorrect: the squared canonical correlations convey the fraction of variance in the CV scores from one variable set which can be accounted for by scores from the other, but say nothing about the extent to which the CVs themselves account for variation in the original variables.  The variance in one set explainable by the other is instead expressed via the so-called \emph{redundancy index}, which combines the squared canonical correlations with the \emph{canonical adequacy} (within-set variance accounted for) for each CV.  The use of the redundancy index in this way is sometimes called \dQuote{(canonical) redundancy analysis}, although it is simply an alternate means of presenting CCA results.

As the name of the technique implies, CCA is a symmetric procedure: the designation of one variable set as \code{x} and another as \code{y} is arbitrary, and may be reversed without incident.  (Note, however, that the coefficients and redundancies are set-specific, and will also be reversed in this case.)  CCA with one \code{x} or \code{y} variable is equivalent to OLS regression (with the squared canonical correlation corresponding to the \eqn{R^2}), and CCA on one variable pair yields the familiar Pearson product-moment correlation.  Centering and scaling data prior to analysis is equivalent to working with correlation matrices in the underlying analysis (with interpretation/effects analogous to the principal components case).

Finding the CCA solution can pose numerical challenges, ironically more so when the degree of potential dimension reduction is highest.  In recalcitrant cases, it can be useful to apply regularization to the solution for purposes of stabilization.  The optional \code{reg.param} can be used for this purpose: if given as a single numeric value, it adds an L2 (aka \dQuote{ridge}) penalty to each variable set with the corresponding multiplier value.  \code{reg.param} can also be given as a vector of length 2, in which case the first value is applied to the \code{x} variables and the second is applied to the \code{y} variables.  Relatedly, in high-dimension/low-rank problems it can be useful to extract a much smaller number of canonical variates than the nominal maximum.  This can be controlled by \code{max.dim}, though the default diagonalization method computes the entire eigendecomposition prior to canonical variate extraction.  In such cases, it can be helpful to employ the alternative diagonalization method controlled by the \code{use.eigs} argument to compute only those dimensions that are actually required.  Experience suggests that this method (\code{\link[RSpectra]{eigs}}) is less stable than the base \code{\link{eigen}}, but it can be much faster in high-dimensional settings.
}
\value{
  An object of class \code{cca}, whose elements are as follows:
  \item{corr }{Canonical correlations.}
  \item{corrsq }{Squared canonical correlations (shared variance across canonical variates).}
  \item{xcoef }{Coefficients for the \code{x} variables on each canonical variate.}
  \item{ycoef }{Coefficients for the \code{y} variables on each canonical variate.}
  \item{canvarx }{Canonical variate scores for the \code{x} variables.}
  \item{canvary }{Canonical variate scores for the \code{y} variables.}
  \item{xstructcorr }{Structural correlations (loadings) for \code{x} variables on each canonical variate.}
  \item{ystructcorr }{Structural correlations (loadings) for \code{y} variables on each canonical variate.}
  \item{xstructcorrsq }{Squared structural correlations for \code{x} variables on each canonical variate (i.e., fraction of \code{x} variance associated with each variate).}
  \item{ystructcorrsq }{Squared structural correlations for \code{y} variables on each canonical variate (i.e., fraction of \code{y} variance associated with each variate).}
  \item{xcrosscorr }{Canonical cross-loadings for \code{x} variables on the \code{y} scores for each canonical variate.}
  \item{ycrosscorr }{Canonical cross-loadings for \code{y} variables on the \code{y} scores for each canonical variate.}
  \item{xcrosscorrsq }{Squared canonical cross-loadings for \code{x} variables on the \code{y} scores for each canonical variate (i.e., the fraction of variance in each \code{x} variable attributable to \code{y} through the respective CVs).}
  \item{ycrosscorrsq }{Squared canonical cross-loadings for \code{y} variables on the \code{x} scores for each canonical variate (i.e., the fraction of variance in each \code{y} variable attributable to \code{x} through the respective CVs).}
  \item{xcancom }{Canonical communalities for \code{x} variables (for each \code{x} variable, fraction associated with all canonical variates).}
  \item{ycancom }{Canonical communalities for \code{y} variables (for each \code{y} variable, fraction associated with all canonical variates).}
  \item{xcanvad }{Canonical variate adequacies for \code{x} variables (for each canonical variate, fraction of total \code{x} variance for which it is associated).}
  \item{ycanvad }{Canonical variate adequacies for \code{y} variables (for each canonical variate, fraction of total \code{y} variance for which it is associated).}
  \item{xvrd }{Canonical redundancies for \code{x} variables (i.e., total fraction of \code{x} variance accounted for by \code{y} variables, through each canonical variate).}
  \item{yvrd }{Canonical redundancies for \code{y} variables (i.e., total fraction of \code{y} variance accounted for by \code{x} variables, through each canonical variate).}
  \item{xrd }{Total canonical redundancy for \code{x} variables (i.e., total fraction of \code{x} variance accounted for by \code{y} variables, through all canonical variates).}
  \item{yrd }{Total canonical redundancy for \code{y} variables (i.e., total fraction of \code{y} variance accounted for by \code{x} variables, through all canonical variates).}
  \item{chisq }{Sequential \eqn{\chi^2}{chi-squared} values for tests of each respective canonical variate using Bartlett's omnibus statistic.}
  \item{df }{Degrees of freedom for Bartlett's test.}
  \item{xlab }{Variable names for \code{x}.}
  \item{ylab }{Variable names for \code{y}.}
  \item{reg.param }{Regularization parameter (if any).}
}
\references{ Mardia, K. V.; Kent, J. T.; and Bibby, J. M.  1979.  \emph{Multivariate Analysis}.  London: Academic Press. }
\author{ Carter T. Butts <buttsc@uci.edu> }
%\note{ ~~further notes~~ 
%
% ~Make other sections like Warning with \section{Warning }{....} ~
%}
\seealso{ \code{\link{F.test.cca}}, \code{\link{cancor}}, \code{\link{princomp}} }
\examples{
#Example parallels the R builtin cancor example
data(LifeCycleSavings)
pop <- LifeCycleSavings[, 2:3]
oec <- LifeCycleSavings[, -(2:3)]
cca.fit <- cca(pop, oec)
cca.regfit <- cca(pop, oec, reg.param=1) # Some minimal regularization

#View the results
cca.fit
summary(cca.fit)
plot(cca.fit)
cca.regfit       #Not a vast difference, usually....
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ models }
\keyword{ multivariate }% __ONLY ONE__ keyword per line
