


df <- read.csv("C:/Users/violetac/OneDrive - Public Administration/Desktop/sdmx_validation_R_py/BCS_QBD_Q2_2023OllgognAnDataflow.csv", sep=";", header=TRUE)
head(df)

## association rules discovery

### df  <- ggplot2::diamonds[,2:4]
#(citation("arules"))
 
library(arules)   
tdata <- as(df, "transactions")
 
 ## apriori algorithm -------------
rules <- apriori(tdata, parameter=list(support=0.3))  
apriori_summary <- summary(rules)
#apriori_res <- inspect(rules)
 
inspect(head(rules, n = 100, by = "confidence"))

library(arulesViz)
if (length(rules) > 0) {
  plot(rules, method = "scatterplot", measure = c("support", "confidence"), 
       shading = "lift", main = "Scatter Plot of Association Rules")
}
 
 
 ## eclat algorithm -----------
rules_eclat <- eclat(tdata, parameter = list(supp=0.07, maxlen=15))
eclat_res <- inspect(rules_eclat)

eclat_plot <- itemFrequencyPlot(tdata, topN=10, type="absolute", main="item freguency")
summary_data <- summary(tdata)

eclat_summary <- summary(eclat(tdata, 
                               parameter = list(supp=0.07, maxlen=15)))


## Create rules from the frequent itemsets
rules_fromEclat <- ruleInduction(rules_eclat, confidence = .6)
rules_fromEclat

if (length(rules_fromEclat) > 0) {
  plot(rules_fromEclat, method = "scatterplot", measure = c("support", "confidence"), 
       shading = "lift", main = "Scatter Plot of Association Rules")
}


###---------- Deep learning: anomaly detection --------------

## https://rpubs.com/michaelmallari/anomaly-detection-r
## https://www.mindbridge.ai/blog/anomaly-detection-techniques-how-to-uncover-risks-identify-patterns-and-strengthen-data-integrity/#:~:text=Deep%20learning%20techniques%20use%20neural,points%20have%20higher%20reconstruction%20errors.
## https://cran.r-project.org/web/packages/anomaly/index.html

## https://arxiv.org/abs/2407.18439 



