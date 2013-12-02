#***************************************************************
#
#     Transplant Center 
#			Observational Analysis
#
#***************************************************************

#*************************************************************
#
# Load the transplant data
# R11xplant.csv, R11donor.csv, UVAxplant.csv, Dukexplant.csv,
# MCVxplant.csv, & UNCxplant.csv (headers, "," delimiter)
#
#**************************************************************




##  Summarize the data?  What are we look at?


##  How many years of transplant data are there?


##  How many organs?


#***************************************************************
#
# Soure the scatter plot matrix code and transplant plotting code
# SPM_Panel.R and Transplant.plots.R
#
#***************************************************************




#***************************************************************
#
# Scatter plot matrix 
#
#***************************************************************

##  Create a scatter plot matrix for liver transplants using UVA, Duke, MCV, UNC, & Region 11 donors


##  What do you notice about the distributions of data for liver transplants? Are any symmetric?


##  Which center has the highest correlation with region 11 liver donors?


##  Create a scatter plot matrix for pancreas transplants


##  What do you notice about the distributions of data for pancreas transplants? Are any symmetric?


##  Which center has the highest correlation with region 11 pancreas donors?


#***************************************************************
#
#  donortype.plot
#
#***************************************************************

# Note in all the plots that follow we should remove the 26th observation
# (2013) since the data were not complete for that year.

# Lung transplants-DD means deceased donor; LD means living donor
donortype.plot(cbind(r11xplant$Lung_DD[-26], r11xplant$Lung_LD[-26], r11donor$Lung_DD[-26],r11donor$Lung_LD[-26]), title = "Lung")


##  Create a donortype.plot for heart transplants in region 11



##What do you observe in both the Lung and the Heart plots? 


#***************************************************************
#
#  region.plot
#
#***************************************************************

#  region.plot for Heart transplants
region.plot(cbind(r11xplant$Heart[-26], r11donor$Heart[-26], uva$Heart[-26], unc$Heart[-26], mcv$Heart[-26], duke$Heart[-26]), title = "Heart")

##  Create a region.plot for Liver transplants


##  Which center has more heart transplants?  liver transplants?


##  What else do you oberve?


#***************************************************************
#
#  center.plot
#
#***************************************************************

#center.plot for Pancreas transplants
center.plot(cbind( uva$Pancreas[-26], unc$Pancreas[-26], mcv$Pancreas[-26], duke$Pancreas[-26]), title = "Pancreas")

##  Create center.plot for Heart transplants


##  Which center does the most pancreas transplants over the last ten years?  Heart transplants?


##  What else do you oberve?

