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



#' Change parameter scope.
#' 
#' Function to change the parameter scope.
#' 
#' 
#' @param object The xpose data object.
#' @param listall whether we should list all the current parameters.
#' @param classic true if used in the classic menu system (for internal use).
#' @return If classic then return nothing.  Otherwise return the new data
#' object.
#' @author Andrew C. Hooker
#' @keywords methods
#' @export change.parm
"change.parm"<-
function(object, listall=TRUE, classic=FALSE)
{
  data <- object
  if(listall) {
    db.names(object)
  }
  cat("Please type the names of the parameters you want to use\n")
  cat("and finish with a blank line. Note that no data checking\n")
  cat("is done during this step - so type carefully.\n")
  covs <- scan(what = character())
  data@Prefs@Xvardef$parms <- covs
  if (classic==TRUE) {
    c1<-call("assign",paste("xpdb", object@Runno, sep = ""), data, immediate=T, envir = .GlobalEnv)
    eval(c1)
    c2<-call("assign",pos = 1, ".cur.db", eval(as.name(paste("xpdb", object@Runno, sep = ""))))
    eval(c2)
    return(cat(""))
    
  } else {
    return(data)
  }
}
