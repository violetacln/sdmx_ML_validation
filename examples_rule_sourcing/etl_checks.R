

### efficient package for comparing df -----------------------

## https://cran.r-project.org/web/packages/arsenal/vignettes/comparedf.html

library(arsenal)

## apply to the example datasets we have tested for rule-suggestions, etc.

## example data HAGS ------*--------
d2 <- read.csv("C:/Users/violetac/OneDrive - Public Administration/Desktop/sdmx_validation_R_py/BCS_QBD_Q2_2023OllgognAnDataflow.csv", sep=";", header=TRUE)

d10 <- read.csv("C:/Users/violetac/OneDrive - Public Administration/Desktop/sdmx_validation_R_py/Bure_ini.csv", sep=";", header=TRUE)

d_map <- read.csv("C:/Users/violetac/OneDrive - Public Administration/Desktop/sdmx_validation_R_py/isat_sdmx.csv", sep=";", header=TRUE)

d1 <-     ### mapping betweeen d10 and d2, by using d_map

  
summary(comparedf(d1,d2))


## more detailed comparisons: with same function; with tidyverse, etc


### anomaly detection ------------------

##....

###-------------------------------------


