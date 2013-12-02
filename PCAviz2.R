# indexing using logical arguments
vec1 <- 1:10

# Relational operators return logical arguments: TRUE or FALSE for each case
# in the logical relation.

# For example, vec1>3 will return TRUE for each element in the vector that is 
# greater than 3 and FALSE for the remaining cases
vec1>3
vec1<3 
vec1==3
vec1!=3
vec1[vec1>3]


# The function duplicated will find elements that are duplicates of elements with 
# smaller subscriptsin a vector, and rows in a dataframe
duplicated(c(1,1,1,2,3,4,1,2)) # shows TRUE for each element that duplicates an earlier element

vec2 <- c(1,2,1,3,4,5,2)
duplicated(vec2) 
vec2[duplicated(vec2)] # returns only those that are duplicated

vec2[!duplicated(vec2)] # returns only one of each type (i.e., no duplicates)

vec3 <- vec2 #copy vec2 and call it vec3

# cbind binds two vectors into a single matrix making the vectors columns
mat1 <- cbind(vec2,vec3)
mat1

mat2 <- rbind(vec2,vec3)
mat2

mat3 <- rbind(mat2,1:7)
mat3

df1 <- data.frame(mat1,newVec=c(1,2,1,5,3,4,2))
# returns logical vector indicating which rows are duplicates of earlier rows
duplicated(df1) 
# returns logical vector indicating which rows are NOT duplicates of earlier, i.e., originals
!duplicated(df1) 

df1[duplicated(df1)]
# GOTCHA! If you don't include the comma in the brackets, it'll mess up.

#Only duplicated rows
df1[duplicated(df1),]

# Only original rows
df1[!duplicated(df1),]

df2 <- df1[!duplicated(df1),]



data(iris)

iris.pca <- princomp(iris[,1:4],scores=T,cor=T)
library(lattice)

iris.pca.data <- data.frame(iris.pca$scores,iris$Species)

summary(iris.pca.data)
# notice how it names the Species variable. 
names(iris.pca.data)
# By default R replaces illegal characters with a dot.

#some plots for our new data
bwplot(iris.Species ~ Comp.2, data=iris.pca.data)

xyplot(Comp.1 ~ Comp.2 | iris.Species,data=iris.pca.data)

# Did PCA really split the original variables into new orthonormal variables? 
library(psych)
pairs.panels(iris.pca.data)

# Why are the correlations that value? 
# What do the correlations of the components with the species variable tell us?