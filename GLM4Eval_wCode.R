


#************************************************************
#
#				SPAM Filter 4 
#			Evaluation of Generalized Lnear Models 
#
#
#************************************************************


#*****************************
#
# Load the data & source files
#
#*****************************

# This stuff all depends on the machine you are using.
# I recommend you put all the files you want to source in a single folder
# and make that your working directory.

# the home directory for the machines in the lab:
setwd("C:/LocalData/")

# this assumes the files are in your working directory
# if they aren't you'll have to make a file path
# to them. Or you could use file.choose() in place of the 
# quoted filename and just select the file for each.
spam <- read.table("spam.txt", header = F)

source("ROC.R")
source("Testset.R")
source("PCAplots.R")
source("pc.glm.R")


#**************************************************
#
# Test and taining sets
#
#**************************************************

# Obtain test and training sets from the spam data
# Make the test set 1/3 of the size of spam
# Use test.set()

Spam <- test.set(data=spam,size=1/3)

#notice Spam is a named list with two datasets
# named test and train in each list element
names(Spam)

#*****************************
#
# GLM with training data
#
#*****************************

# Obtain a GLM with all predictor variables
# using the training data
spam.glm <- glm(V58~.,data=Spam$train, family=binomial)
 
# Obtain a GLM with the log transform of all predictor variables
# using the training data
lspam.train <-data.frame(log(Spam$train[,-58]+.01),Spam$train[,58])
names(lspam.train) <- names(Spam$train)

lspam.glm <- glm(V58~.,data=lspam.train,family=binomial)

# Here is an example of how to 
# obtain a GLM with principal components
# accounting for 90% of the variance
# using the training data.


spam.pca <- princomp(Spam$train[,-58], cor = T)

spampca.glm90 <- pc.glm(spam.pca, 90, Spam$train[,58])

# Obtain a GLM with principal components
# accounting for 98% of the variance.
# Use the training data

spampca.glm98 <- pc.glm(spam.pca, 98, Spam$train[,58])


#*****************************
#
# Predictions with test data
#
#*****************************


# Use the test data to obtain predictions for the 
# GLM with all predictor variables

# type = "response" is VERY important. It makes the predicted values probabilities
# newdata =Spam$test runs the model you created with the training data
# on the test data predicting what the observations in the test set are.
spam.pred <- predict(spam.glm, type = "response", newdata = Spam$test)

# Use the test data to obtain predictions for the  
# GLM with the log transform of all predictor variables
# Remember you first need to log transform your test data set.

lspam.test <-data.frame(log(Spam$test[,-58]+.01),Spam$test[,58])
names(lspam.test) <- names(Spam$test)

lspam.pred <- predict(lspam.glm, type= "response", newdata=lspam.test)

# Use the test data to obtain predictions for the  
# GLM with principal components
# accounting for 98% of the variance.

spampca.pred <- predict.pc.glm(spampca.glm98, spam.pca,Spam$test[,1:57] )

#*****************************
#
#   score tables
#
#*****************************

# Set the decision threshold to 0.5 
# compute score tables for each model
# use score.table()

score.table(p=spam.pred, r=Spam$test[,58], threshold=.5)

score.table(lspam.pred, lspam.test[,58], .5)

score.table(spampca.pred, Spam$test[,58], .5)

# Set the decision threshold to 0.6 
# compute score tables for each model

score.table(p=spam.pred, r=Spam$test[,58], threshold=.6)

score.table(lspam.pred, lspam.test[,58], .6)

score.table(spampca.pred, Spam$test[,58], .6)

# Which model would you choose for your filter?



#*****************************
#
#   ROC Curves
#
#*****************************

# Plot the ROC curve showing the performance of all models

plot.roc(spam.pred, Spam$test[,58], main = "ROC Curve - SPAM Filter")

lines.roc(lspam.pred, Spam$test[,58], col = "orange")

lines.roc(spampca.pred, Spam$test[,58], col = "green")

legend(.6, .4, legend = c("Main Effects", "Log", "Prin. Comp."), col = c("blue", "orange", "green"), lwd = 1)

# which model would you choose for your filter?
