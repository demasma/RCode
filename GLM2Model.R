

#************************************************************
#
#				SPAM Filter 2 
#			Generalized Lnear Models of SPAM 
#
#
#************************************************************


#*****************************
#
# Load the data & source files
#
#*****************************

setwd("C:/LocalData/AccidentInput.R")

spam <- read.table("Spam.txt", header = F)

summary(spam)

spam[,58] <- as.factor(spam[,58])
#*****************************
#
# GLM
#
#*****************************

# Use the glm() function to obtain the glm for the spam filter.

spam.glm <- glm(V58~., data = spam, family = binomial)

# Use summary to evaluate the model



#Perform a model utility test for the glm

# Model Utility Test using Chi2 statistic

# What do you conclude?

spam.null <- glm(V58~1, data = spam, family = binomial)

anova(spam.null, spam.glm, test = "Chi")


# Create a model with just the capital letters at predictors (V55 - V58)


# How does this model do on the model utility test?


# Use the likelihood ratio or partial chi square test to compare the full main effects model with the capital letters model
# Hint: use the anova() function but with additional paramter setting of test = "Chi"


# What is the contribution of variable 52 to the model?
# notice that we add one to the variable number (51)
# to account for the intercept


(exp(spam.glm$coefficients[52]) -1)*100


# Repeat this for 57

# Variable 57 (total number of capital letters)
# notice that we add one to the variable number (57)
# to account for the intercept



# compare the drop1 chi square test to the approximate Gaussian test in summary.

library(MASS)

drop1(spam.glm, response~., test = "Chi", data = dspam)

#  Compare the step model with capital letter predictors to the capital letter model
#  Hint use the step() function but with family = binomial

step.cap <- step(spam.cap, data = spam, family = binomial)

# Do this at home when you have time.
# Compare a stepwise model that starts with the full main effects model to the main effects model.





