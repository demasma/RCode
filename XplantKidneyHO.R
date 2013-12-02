
#***************************************************************
#***************************************************************
#
#  Designs to improve numbers of Treated Kidney Transplant Patients
#
#***************************************************************
#***************************************************************



#***************************************************************
#
#  Read in the data
#
#***************************************************************

uva <- read.table("UVAxplant.csv", sep = ",", header = T)

mcv <- read.table("MCVxplant.csv", sep = ",", header = T)

duke <- read.table("Dukexplant.csv", sep = ",", header = T)

unc <- read.table("UNCxplant.csv", sep = ",", header = T)

uvaeth <- read.table("UVAethnic.csv", sep = ",", header =T)

mcveth <- read.table("MCVethnic.csv", sep = ",", header =T)

dukeeth <- read.table("DukeEthnic.csv", sep = ",", header =T)



#***************************************************************
#
#  Source files and libraries
#
#***************************************************************

# Source 

source("TSbootfunctions.R") # Get the new version of this.
source("Transplant.plots.R")
library(boot)

#***********************************
# Center plot
#***********************************

center.plot(cbind( uva$Kidney[-25], unc$Kidney[-25], mcv$Kidney[-25], duke$Kidney[-25]), Year = seq(1988,2011, 1), title = "Kidney")

# What do you conclude from this center plot


#*******************************************
#
#		Ethnic Diversity Analysis
#
#*******************************************

# Form data sets for the kidney transplants


uvaketh <- subdata("Kidney", uvaeth)

mcvketh <- subdata("Kidney", mcveth)

dukeketh <- subdata("Kidney", dukeeth)

