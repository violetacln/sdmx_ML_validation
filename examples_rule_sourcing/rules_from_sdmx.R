


###------------------- derived from sdmx by using the validate-package --------------------

library(validate)
library(rsdmx)

sdmx_endpoint(registry="global")

codelist <- sdmx_codelist(
  endpoint = sdmx_endpoint("global")
  , agency_id = "ESTAT"
  , resource_id = "CL_ACTIVITY")

head(codelist)


## directly:
codelist <- global_codelist(agency_id="ESTAT", resource_id="CL_ACTIVITY")
head(codelist)


## reading a codelist from the registry *******************
## see https://github.com/SNStatComp/validatesdmx/blob/main/test_registries/R/global_registry.R 

url1 <- "https://registry.sdmx.org/ws/public/sdmxapi/rest/codelist/ESTAT/CL_ACTIVITY/latest" 
codelist1 <- readSDMX(url1)

df10 <- as.data.frame(codelist1)  ###****the main info*****###


## reading a dsd from the registry *************************
## see https://github.com/SNStatComp/validatesdmx/blob/main/test_registries/R/global_registry.R :

url2 <- "https://registry.sdmx.org/ws/public/sdmxapi/rest/datastructure/ESTAT/CPI/latest"
dsd <- readSDMX(url2)

dimensions <- slot(slot(dsd, "datastructures")[[1]], "Components")
df2 <- as.data.frame(dimensions)

## then we could add -------------
cl_vars <- !is.na(df2$codelist)
df1 <- df2[cl_vars,]

                  
endpoint<- sdmx_endpoint("global")





##*_____________________________not working:______________________

###(because not saying resource="datastructure" and resource_id="CPI" anywhere, for reading he dsd (see url2)
### while for codelists, (see url1) we have resource="codelists" and resource_id="CL_ACTIVITY" indeed

## generating rules:
# rules <- validator_from_dsd(endpoint = sdmx_endpoint("global")
#                             , agency_id = "ESTAT" 
#                             , resource_id = "CL_ACTIVITY"
#                            , version="latest")
# # length(rules)
# 
# 
# library(rsdmx)
# dsd <- readSDMX(providerId = "ESTAT", resource = "datastructure", resourceId = "CL_ACTIVITY", dsd=TRUE)

##*__________________________________________________________________________


###=============================== our shortcut =======================

library(rsdmx)


## shortest access:
url <- "https://registry.sdmx.org/ws/public/sdmxapi/rest/codelist/ESTAT/CL_ACTIVITY/latest"

cl <- as.data.frame(readSDMX(url))
cl$description.en.description[!is.na(cl$description.en.description)]

## these (above) are our rules, basically! (in some form)  #-----------our best rule collection until now ----------



## also we can do more ----------------------------------------

## Correct endpoint to get dataflows from ESTAT
url <- "https://registry.sdmx.org/ws/public/sdmxapi/rest/dataflow/ESTAT"

## Send GET request
resp <- httr::GET(url)

# Parse XML content
xml <- xml2::read_xml(httr::content(resp, "text", encoding = "UTF-8"))

# Define SDMX structure namespace
ns <- xml2::xml_ns(xml)

# Find all Dataflow nodes
flows <- xml2::xml_find_all(xml, ".//str:Dataflow", ns)

# Extract IDs
ids <- xml2::xml_attr(flows, "id")

# View result
print(ids)
##
url <- "https://registry.sdmx.org/ws/public/sdmxapi/rest/codelist/ESTAT"

# Send GET request
resp <- httr::GET(url)

# Parse XML content
xml <- xml2::read_xml(httr::content(resp, "text", encoding = "UTF-8"))

# Define SDMX structure namespace
ns <- xml2::xml_ns(xml)

# Find all Dataflow nodes
flows <- xml2::xml_find_all(xml, ".//str:Codelist", ns)

# Extract IDs
ids <- xml2::xml_attr(flows, "id")

# View result
print(ids)

###-------------------------------------------------------------------



## from the github code of the function we need:
## https://github.com/data-cleaning/validate/blob/master/pkg/R/sdmx.R
## we can create our own function by modifying this as needed



#validator_from_dsd <- function(endpoint, agency_id, resource_id, version="latest"){
  
  #dsd <- download_sdmx(endpoint, "datastructure", agency_id, resource_id, version)
  
  dsd <- cl_dsd
  
  dimensions <- slot(slot(dsd, "datastructures")[[1]], "Components")
  
          ### slot(slot(dsd, "")[[1]], "Components")
  
  df <- as.data.frame(dimensions)
  
  cl_vars <- !is.na(df$codelist)
  
  template <- '%s %%in%% sdmx_codelist(endpoint  = "%s", agency_id = "%s", resource_id = "%s", version = "%s")'
  
  df1 <- df[cl_vars,]
  
  
  
  rules <- data.frame(
    rule = sprintf(template
                   , df1$conceptRef
                   , endpoint
                   , df1$codelistAgency
                   , df1$codelist
                   , version=df1$codelistVersion)
    , name = paste0("CL_", df1$conceptRef)
    , origin = attr(dsd,"url")
    , description = sprintf("Code list from %s::%s %s", resource_id, df1$conceptRef, version)
  )
  
  validator(.data=rules)

  #}

  
######
  
  ## vtl reference
  ## https://cros.ec.europa.eu/book-page/vtl 
  
  
