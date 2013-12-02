


#************************************************************
#
#				SPAM Filter 3 
#			Generalized Lnear Models of SPAM 
#
#
#************************************************************


#*****************************
#
# Load the data & source files
#
#*****************************

setwd("/Users/deb/Dropbox/department/sys 421 2011/Data/")

spam <- read.table("spam.txt", header = F)

setwd("/Users/deb/Dropbox/department/sys 421 2011/R Code/")
source("PCAplots.R")
source("pc.glm-1.R")



summary(spam)

spam$V58 <- as.factor(spam$V58)

summary(spam)

#*****************************
#
# GLM with and without log transformations.
#
#*****************************

# Compare a main effects model with all variables to this same model that also includes
# the interaction terms between V5, V6, V7. 
# Do the comparison with a partial likelihood test.
# (note: do not do a complete interacton model! Unless you have time.)

spam.main <- glm(V58~., data = spam, family = binomial)

spam.int <- glm(V58~.+(V5+V6+V7)^2, data=spam,family=binomial)

anova(spam.main,spam.int, test="Chi")

# Now compare a main effects model with log transformed predictors to this same model that also includes
# the interaction terms between the log transformed variables V5, V6, V7. 
logspam <- spam
logspam[,1:57] <- log(spam[,1:57]+.01)
summary(logspam)

logspam.main <- glm(V58~., data = logspam, family = binomial)

logspam.int <- glm(V58~.+(V5+V6+V7)^2, data=logspam,family=binomial)



# Do this comparison with a partial likelihood test.
# (note: Again do not do a complete interacton model! Unless you have time.) 
anova(logspam.main,logspam.int, test="Chi")

#**************************************************
#
# Evaluate performance with AIC
#
#**************************************************

# Compare the AIC for the 4 models you developed.
# Which model would you choose?

AIC(spam.int, spam.main,logspam.int,logspam.main)

#***********************************************************
#
#  Princomp Regression
#
#***********************************************************

# obtain the principal components for the predictors with a correlation matrix
spam.pca <- princomp(spam[,1:57],cor=T)

# to see how many components are needed for 90% of the variance we use
# var.comp(spam.pca, 90). How many components do we need for 98%?
var.comp(spam.pca, 90)
 
var.comp(spam.pca, 98)


# Use pc.glm() to get the principal component regression results.

spampca.glm98 <- pc.glm(spam.pca, 98, spam[,58])

# Do a model utility test starting with pc.null()

spampc.null <- pc.null(spam.pca, 98, spam[,58])

summary(spampc.null)


# Create a principal components model that captures 100% of the variance 
# in the original data set. 

spampca.glm100 <- pc.glm(spam.pca, 100, spam[,58])

# Do a model utility test

summary(spampca.glm100)

# Do a partial likelihood test between the two pca models.

anova(spampc.null, spampca.glm98, test="Chi")

# Use AIC to compare these two principal component models to the 4 other models 
# which one would you choose?
AIC(spampc.null, spampca.glm98)
