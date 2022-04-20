## 02 Setup FFC API Package
## CEFF Workshop - SRF Meeting 4/20/22

###########################################
### Set up

#load library
library(ffcAPIClient)

# set token from eflows website 
ffctoken <-'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmaXJzdE5hbWUiOiJLcmlzIiwibGFzdE5hbWUiOiJUYW5pZ3VjaGkgUXVhbiIsImVtYWlsIjoia3Jpc3RpbmV0cUBzY2N3cnAub3JnIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE2MTMwNjkxMDJ9.pOy0lTuKBm75Us_PtD8G2yD_l9ISZea2atsPwWUCsDw'

###########################################
### 1. FFC for a single USGS Gage

# start ffc processor
ffc <- FFCProcessor$new()

# set up gage id and token
ffc$set_up(gage_id = 11427000,
           token = ffctoken)  
           # OPTIONAL: indicate NHD COMID, set up the plot output folder
           #comid = segment_comid,
           #plot_output_folder = "./data/Output_02/")

#run calculator
ffc$run()

#get FFC results - annual metrics
ffc$ffc_results
#save as a csv
write.csv(ffc$ffc_results, file="./data/Output_02/ffc_annual_results.csv", row.names = TRUE)

#get FFC percentiles - p10-p90 for every metric
ffc$ffc_percentiles
#save as a csv
write.csv(ffc$ffc_percentiles, file="./data/Output_02/ffc_percentiles_observed.csv", row.names = TRUE)

#get predicted reference percentiles
ffc$predicted_percentiles
#save as a csv
write.csv(ffc$predicted_percentiles, file="./data/Output_02/ffc_percentiles_reference.csv", row.names = TRUE)

#get alteration
ffc$alteration
#save as a csv
write.csv(ffc$alteration, file="./data/Output_02/ffc_alteration.csv", row.names = TRUE)

###########################################
#### 2. Save results in a single folder

#run evaluate gage alteration to calculate FFM, pull predicted natural FFM, 
  #and conduct alteration assessment

#evaluate alteration function
alteration <- evaluate_gage_alteration(gage_id = 11427000, 
                                       token = ffctoken, 
                                       force_comid_lookup = TRUE,
                                       plot_output_folder = "./data/Output_02/")
#get alteration data
alteration$alteration
#save as a csv
write.csv(ffc$ffc_percentiles, file="./data/Output_02/ffc_percentiles_observed.csv", row.names = TRUE)


###########################################
### 3. FFC with your own flow data

#read in your own flow dataframe with date column and flow column
flow.data <- read.csv("./data/Input_02/sample.csv")

#check column names, if nameas are altered, rename
names(flow.data)
#if column headers are incorrect, rename to date and flow
names(flow.data) <- c("date", "flow")

#format date to YYYY-mm-dd
flow.data$date <- as.POSIXct(flow.data$date, format = "%m/%d/%Y")
#format date as class
flow.data$date <- format(flow.data$date, "%Y-%m-%d")
#format flow as numeric
flow.data$flow <- as.numeric(flow.data$flow)

# start ffc processor
ffc <- FFCProcessor$new()

# set up flow timeseries, token, and comid
ffc$set_up(timeseries = flow.data,
           token = ffctoken,
           comid = 14996611)  

# run calculator
ffc$run()

#get FFC results - annual metrics
ffc$ffc_results
#save as a csv
write.csv(ffc$ffc_results, file="./data/Output_02/ffc_annual_results.csv", row.names = TRUE)

#get FFC percentiles - p10-p90 for every metric
ffc$ffc_percentiles
#save as a csv
write.csv(ffc$ffc_percentiles, file="./data/Output_02/ffc_percentiles_observed.csv", row.names = TRUE)

#get predicted reference percentiles
ffc$predicted_percentiles
#save as a csv
write.csv(ffc$predicted_percentiles, file="./data/Output_02/ffc_percentiles_reference.csv", row.names = TRUE)

#get alteration
ffc$alteration
#save as a csv
write.csv(ffc$alteration, file="./data/Output_02/ffc_alteration.csv", row.names = TRUE)


