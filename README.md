# yacca

<!-- badges: start -->
[![R build status](https://github.com/CarterButts/yacca/workflows/R-CMD-check/badge.svg)](https://github.com/CarterButts/yacca/actions)
[![CRAN status](https://www.r-pkg.org/badges/version/yacca)](https://CRAN.R-project.org/package=yacca)
<!-- badges: end -->

### Yet Another Canonical Correlation Analysis Package for R

The `yacca` package contains basic functionality for canonical correlation analysis and related calculations (e.g., canonical redundancy, loadings, etc.).  As the name implies, this is one of many (including the cancor function of base R).  `yacca` is not necessarily superior to the others, but supplies various bits of functionality that are convenient and otherwise difficult to find in one place (e.g., helio plots for loadings, redundancy score calculation, regularization support).  If you prefer a different package, rest assured that the author is not offended.

`yacca` was originally hosted on CRAN, but was mothballed due to lack of active maintenance.  This version is refreshed and apparently functional with recent R versions.  It may return to CRAN at some point, but in the interim it is available via this fine repository.  If you use this package in your research, it would be greatly appreciated if you could cite it.  E.g.:

> Butts, Carter T.  2008.  "yacca: Yet Another Canonical Correlation Analysis Package."  Software package.

(Or the `citation()` command in R, to specifically cite the current version.)

More information regarding the package and its use may be found within the package documentation.

## Installing Within R

To install the `yacca` package from the comfort of your own home or office, first ensure that you have the `devtools` package installed and loaded.  Then, type the following:

	install_github("carterbutts/yacca", subdir="yacca")

Alternately, cloning this repository and building/installing the package locally is another option.  But in that case, you don't need my help to tell you what to do, now do you?

\-CTB, 2/5/21
