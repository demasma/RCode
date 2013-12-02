# Functions used today
?princomp # actually performs the principal component analysis (PCA)
?biplot # it's a...biplot
?screeplot
loadingsplot   # one of Prof. Brown's functions, plots the loadings
               # for you
cumplot  # another Prof. Brown plot, plots cumulative variance of loadings
?cumsum # calculates the cumulative sum of a vector (returns a vector)

# where is R working from right now?
getwd()

# load important functions into your workspace
source("AccidentInput-1.R")
source("PCAplots.R")

# load your data
my.path <- "/Users/sie/Dropbox/SYS_4021/Class Sessions/Data/"
acts <- file.inputl(my.path=my.path)

# but today, we're only working with the tenth
acts10 <- acts[[10]]

acts10.pca.cov <- princomp(acts10[,c("EQPDMG", "TRKDMG","ACCDMG","TOTINJ","TOTKLD")], cor = F)

acts10.pca.cor <- princomp(acts10[,c("EQPDMG", "TRKDMG","ACCDMG","TOTINJ","TOTKLD")], cor = T)


# What seems to have the most influence in the covariance matrix version?
biplot(acts10.pca.cov)

# What has influence in the correlation matrix version?
biplot(acts10.pca.cor)

# where is all the variance accounted for in each?
screeplot(acts10.pca.cov)
screeplot(acts10.pca.cor)

# what story does this tell? 
# Can you think of any "latent" variables from this?
loadingsplot(acts10.pca.cor, k=3, col = "steelblue")

# how many components do you need to capture most of the information?
cumplot(acts10.pca.cor, col = "steel blue")

# loadings in printed form
# how much variance does the first principal component account for? 
# the 3rd?
# how about the first three together?

acts10.pca.cor$loadings

# store as a variable
acts10.loads <- acts10.pca.cor$loadings

dim(acts10.loads)

# first principal component
acts10.loads[,1]

# how to calculate yourself
eigvals <- acts10.pca.cor$sdev

# cumulative sum function returns a vector where each new element 
# is the sum of the original vector's elements through that element
cumsum(1:10) 
cumsum(eigvals)
sum(eigvals)

# so each element here is the cumulative proportion of variance 
cumsum(eigvals)/sum(eigvals)





########    BONUS explanation
# this finds the common (thus, intersection) variables names between the 
# 1st and 9th datasets in acts
comvars <- intersect(x=names(acts[[1]]),y=names(acts[[8]]))
# this function takes the list, and appends the common variables
# as saved in comvars together from each dataset in the list
# Data.List into a single dataset.
totacts <- combine.data(Data.List=acts,Vars=comvars)

