# Xpose 4
# An R-based population pharmacokinetic/
# pharmacodynamic model building aid for NONMEM.
# Copyright (C) 1998-2004 E. Niclas Jonsson and Mats Karlsson.
# Copyright (C) 2005-2008 Andrew C. Hooker, Justin J. Wilkins, 
# Mats O. Karlsson and E. Niclas Jonsson.
# Copyright (C) 2009-2010 Andrew C. Hooker, Mats O. Karlsson and 
# E. Niclas Jonsson.

# This file is a part of Xpose 4.
# Xpose 4 is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public License
# as published by the Free Software Foundation, either version 3
# of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public License
# along with this program.  A copy can be cound in the R installation
# directory under \share\licenses. If not, see http://www.gnu.org/licenses/.



#' Dependent variable vs population predictions, conditioned on covariates, for
#' Xpose 4
#' 
#' This is a plot of the dependent variable (DV) vs population predictions
#' (PRED) conditioned by covariates, a specific function in Xpose 4.  It is a
#' wrapper encapsulating arguments to the \code{xpose.plot.default} function.
#' Most of the options take their default values from xpose.data object but may
#' be overridden by supplying them as arguments.
#' 
#' Each of the covariates in the Xpose data object, as specified in
#' \code{object@Prefs@Xvardef$Covariates}, is evaluated in turn, creating a
#' stack of plots.
#' 
#' A wide array of extra options controlling \code{xyplot}s are available. See
#' \code{\link{xpose.plot.default}} and \code{\link{xpose.panel.default}} for
#' details.
#' 
#' @inheritParams dv.vs.ipred.by.cov
#' @param object An xpose.data object.
#' @param abline Vector of arguments to the \code{\link[lattice]{panel.abline}}
#' function. No abline is drawn if \code{NULL}.
#' @param smooth Logical value indicating whether an x-y smooth should be
#' superimposed.  The default is TRUE.
#' @param main The title of the plot.  If \code{"Default"} then a default title
#' is plotted. Otherwise the value should be a string like \code{"my title"} or
#' \code{NULL} for no plot title.  
#' @param \dots Other arguments passed to \code{link{xpose.plot.default}}.
#' @return Returns a stack of xyplots of DV vs PRED, conditioned on covariates.
#' @author E. Niclas Jonsson, Mats Karlsson, Andrew Hooker & Justin Wilkins
#' @seealso \code{\link{dv.vs.pred}}, \code{\link{xpose.plot.default}},
#' \code{\link{xpose.panel.default}}, \code{\link[lattice]{xyplot}},
#' \code{\link{xpose.prefs-class}}, \code{\link{xpose.data-class}}
#' @keywords methods
#' @examples
#' dv.vs.pred.by.cov(simpraz.xpdb, covs=c("HCTZ","WT"), max.plots.per.page=2)
#' 
#' @export dv.vs.pred.by.cov
#' @family specific functions 
dv.vs.pred.by.cov <-
  function(object,
           covs="Default",
           #xlb  = NULL,
           #ylb  = NULL,
           #onlyfirst=FALSE,
           #inclZeroWRES=FALSE,
           #subset=xsubset(object),
           #mirror=FALSE,
           #seed  = NULL,
           abline = c(0,1),
           #abllwd = object@Prefs@Graph.prefs$abllwd,
           #abllty = object@Prefs@Graph.prefs$abllty,
           #ablcol = object@Prefs@Graph.prefs$ablcol,
           #prompt = FALSE,
           smooth=TRUE,
           #main=NULL,
           #samp  = NULL,
           #max.plots.per.page=1,
           #scales=list(),
           #aspect = object@Prefs@Graph.prefs$aspect,#"fill"
           #mirror.aspect="fill",
           #pass.plot.list=FALSE,
           #x.cex=NULL,
           #y.cex=NULL,
           #main.cex=NULL,
           main="Default",
           ...) {

    
    ## Make sure we have the necessary variables defined in the 
    ## object.                                                  
    if(is.null(check.vars(c("dv","ipred"),object))) return(NULL)
    
    # handle covs argument
    if(all(covs == "Default")) {
      if(is.null(check.vars(c("covariates"),object))) return(NULL)
      covs <- xvardef("covariates", object)
    } else {
      if(is.null(check.vars(covs,object))) return(NULL)
    }
    
    ## create plot list
    plotList <- vector("list",length(covs))
    plot.num <- 0 # initialize plot number      
    for (i in covs) {      
      
      xplot <- xpose.plot.default(xvardef("pred",object),
                                  xvardef("dv",object),
                                  #xlb = xlb,
                                  #ylb = ylb,
                                  abline=abline,
                                  #abllwd=abllwd,
                                  #scales=scales,
                                  #aspect=aspect,
                                  object,
                                  main=NULL,
                                  by=i,
                                  #subset=subset,
                                  smooth=smooth,
                                  #samp=samp,
                                  pass.plot.list=TRUE,
                                  ...)
      
      
      plot.num <- plot.num+1
      plotList[[plot.num]] <- xplot
    }

    default.plot.title <- paste(xlabel(xvardef("dv",object),object)," vs ",
                                xlabel(xvardef("pred",object),object),
                                sep="")
    plotTitle <- xpose.multiple.plot.title(object=object,
                                           plot.text = default.plot.title,
                                           main=main,
                                           ...)
    obj <- xpose.multiple.plot(plotList,plotTitle,...)
    return(obj)
    
  }
