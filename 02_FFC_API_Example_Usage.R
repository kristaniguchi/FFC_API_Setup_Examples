## 02 Setup FFC API Package
## CEFF Workshop - CABW/Cal-SFS Meeting 2022
##https://github.com/ceff-tech/ffc_api_client 


###########################################
### Setup

#load library
library(ffcAPIClient)

# set token from eflows website, paste your token below 
ffctoken <-'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmaXJzdE5hbWUiOiJLcmlzIiwibGFzdE5hbWUiOiJUYW5pZ3VjaGkgUXVhbiIsImVtYWlsIjoia3Jpc3RpbmV0cUBzY2N3cnAub3JnIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE2MTMwNjkxMDJ9.pOy0lTuKBm75Us_PtD8G2yD_l9ISZea2atsPwWUCsDw'

###########################################
#Calculate observed FFM, 
  #pull predicted natural FFM, 
  #and conduct alteration assessment

##Option 1: if your observed data is from a USGS gage, use "evaluate gage alteration" function.

#Information needed to run function
#USGS gage: 11445500, SF American River near Lotus
#COMID: 14982092 

#run evaluate gage alteration function
SFA_observed <- ffcAPIClient::evaluate_gage_alteration(gage_id = 11445500, 
                                         token = ffctoken, 
                                         comid = 14982092,
                                         plot_output_folder = "./ffc_outputs/")

#create data frames to view the output 
SFA_pred_percentiles <- SFA_observed$predicted_percentiles
SFA_pred_WYT_percentiles <- SFA_observed$predicted_wyt_percentiles
SFA_obs_percentiles <- SFA_observed$ffc_percentiles
SFA_ffc_results <- SFA_observed$ffc_results

SFA_doh_data <- SFA_observed$doh_data
SFA_alteration <- SFA_observed$alteration

#save dataframes as a csv
write.csv(SFA_alteration, file="./data/Output_02/SFA_alteration.csv", row.names = FALSE)


###########################################
### Option 2. FFC with your own flow data

#What you need: COMID (14996611) and flow timeseries

#read in your own flow dataframe with date column and flow column
flow.data <- read.csv("./data/Input_02/sample.csv")

#check column names, if nameas are altered, rename
names(flow.data)
#if column headers are incorrect, rename to date and flow
names(flow.data) <- c("date", "flow")

#run the evaluate alteration function
Sample_observed <- ffcAPIClient::evaluate_alteration(timeseries_df = flow.data, 
                                                     token = ffctoken, 
                                                     plot_output_folder = "./data/Output_02/Sample/", 
                                                     comid=14996611 )


#create data frames to view the output
Sample_pred_percentiles <- Sample_observed$predicted_percentiles
Sample_pred_WYT_percentiles <- Sample_observed$predicted_wyt_percentiles
Sample_obs_percentiles <- Sample_observed$ffc_percentiles
Sample_ffc_results <- Sample_observed$ffc_results
Sample_doh_data <- Sample_observed$doh_data
Sample_alteration <- Sample_observed$alteration


#save as a csv
write.csv(Sample_alteration, file="./data/Output_02/Sample/Sample_alteration.csv", row.names = FALSE)



