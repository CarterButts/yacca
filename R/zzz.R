######################################################################
#
# zzz.R
#
# copyright (c) 2018, Carter T. Butts <buttsc@uci.edu>
# Last Modified 2/25/18
# Licensed under the GNU General Public License version 3
#
# Part of the R/yacca package; based on the zzz.R files from sna
# and other statnet packages (all hail).
#
# .onAttach is run when the package is loaded with library(yacca)
#
######################################################################


.onAttach <- function(libname, pkgname){
  temp<-packageDescription("yacca")
  msg<-paste(temp$Package,": ",temp$Title,"\n",
      "Version ",temp$Version,
      " created on ",
      temp$Date,".\n", sep="")
  msg<-paste(msg,"copyright (c) 2008, Carter T. Butts, University of California-Irvine\n",sep="")
  msg<-paste(msg,'For citation information, type citation("yacca").\n')
  msg<-paste(msg,'Type help("yacca-package") to get started.\n')
  packageStartupMessage(msg)
}

