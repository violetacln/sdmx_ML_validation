

### efficient package for comparing df -----------------------

## https://cran.r-project.org/web/packages/arsenal/vignettes/comparedf.html

library(arsenal)

## apply to the example datasets we have tested for rule-suggestions, etc.

## example data HAGS ------*--------
d2 <- read.csv("file_X.csv", sep=";", header=TRUE)

d10 <- read.csv("file_Y.csv", sep=";", header=TRUE)

d_map <- read.csv("file_Z.csv", sep=";", header=TRUE)

#d1 <- map(d10)    ### mapping betweeen d10 and d2, by using d_map if needed

  
summary(comparedf(d1,d2))


## more detailed comparisons: with same function; with tidyverse, etc


##....

###-------------------------------------



