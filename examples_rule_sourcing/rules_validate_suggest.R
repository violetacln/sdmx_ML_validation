
## main validation rules, see https://cran.r-project.org/web/packages/validatesuggest/validatesuggest.pdf 


library(validatesuggest)

## example
data("car_owner") 
rules <- suggest_cond_rule(car_owner) 
rules$rules

d <- data.frame(car_owner)

## example data HAGS
d <- read.csv("C:/Users/violetac/OneDrive - Public Administration/Desktop/sdmx_validation_R_py/BCS_QBD_Q2_2023OllgognAnDataflow.csv", sep=";", header=TRUE)

suggest_rules( d, vars = names(d), domain_check = TRUE,
               range_check = TRUE, pos_check = TRUE,
               type_check = TRUE, na_check = TRUE,
               unique_check = TRUE, ratio_check = TRUE,
               conditional_rule = TRUE )

suggest_all( d, vars = names(d), domain_check = TRUE,
             range_check = TRUE, pos_check = TRUE,
             type_check = TRUE, na_check = TRUE,
             unique_check = TRUE, ratio_check = TRUE,
             conditional_rule = TRUE )

write_all_suggestions( d, vars = names(d), 
                       file = stdout(), 
                      ## file=stout("sdmx_validation_R_py/validate_suggest_derived_rules.txt"),
                       domain_check = TRUE,
                       range_check = TRUE, type_check = TRUE,
                       pos_check = TRUE, na_check = TRUE,
                       unique_check = TRUE, ratio_check = TRUE,
                       conditional_rule = TRUE )

##suggest_cond_rule(d)