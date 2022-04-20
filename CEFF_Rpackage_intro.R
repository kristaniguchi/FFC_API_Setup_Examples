### intro to FFC API R package ###
#https://github.com/ceff-tech/ffc_api_client 

####install packages####
library(devtools)
devtools::install_github('ceff-tech/ffc_api_client/ffcAPIClient')

#obtain token from eflows website, see setup instructions at https://github.com/ceff-tech/ffc_api_client 


#PASTE YOUR TOKEN HERE for reference: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmaXJzdE5hbWUiOiJTYXJhaCIsImxhc3ROYW1lIjoiWWFybmVsbCIsImVtYWlsIjoic215YXJuZWxsQHVjZGF2aXMuZWR1Iiwicm9sZSI6IlVTRVIiLCJpYXQiOjE1Nzg0MjE4NjN9.9XR7j2lUDPZ-gdROroHspXjIySpF4kFSYPkXnLSfkBs"


####Pull observed and predicted data, and perform an alteration assessment####

##Option 1: if your observed data is from a USGS gage, use "evaluate gage alteration" function.

#Information needed to run function
#USGS gage: 11445500, SF American River near Lotus
#COMID: 14982092

#run the function
SFA_observed <- ffcAPIClient::evaluate_gage_alteration(gage_id = 11445500, token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmaXJzdE5hbWUiOiJBbHlzc2EiLCJsYXN0TmFtZSI6Ik9iZXN0ZXIiLCJlbWFpbCI6ImFseXNzYS5vYmVzdGVyQHdpbGRsaWZlLmNhLmdvdiIsInJvbGUiOiJVU0VSIiwiaWF0IjoxNTg0OTc4OTIwfQ.FvHgSUyLPN387rnFWiCQJFwEhPz6XRVn-N2j1IwfTq4", comid = 14982092, plot_output_folder = "C:/Users/aobester/OneDrive - California Department of Fish and Wildlife/R/Data_Output/SFA_output")

#create data frames to view the output 
SFA_pred_percentiles <- SFA_observed$predicted_percentiles
SFA_pred_WYT_percentiles <- SFA_observed$predicted_wyt_percentiles
SFA_obs_percentiles <- SFA_observed$ffc_percentiles
SFA_ffc_results <- SFA_observed$ffc_results
SFA_doh_data <- SFA_observed$doh_data
SFA_alteration <- SFA_observed$alteration


##Option 2: if your observed data is not from a USGS gage, use "evaluate alteration" function. Your data frame must have date and flow fields (just like the FFC on the eflows website). Date column needs to be in the format mm/dd/yyyy. You also need the COMID associated with these data.

#Information needed to run the function
#COMID: 14994421 (Middle Fork American near Auburn)
MFA_forFFC <- read.csv("C:/Users/aobester/OneDrive - California Department of Fish and Wildlife/R/Data/MFA_forFFC.csv") #data frame containing date and flow data to run through FFC and perform alteration assessment
MFA_forFFC <- rename(MFA_forFFC, "date" = ?..date) #needed to rename this header because the formatting got weird

#run the function
MFA_observed <- ffcAPIClient::evaluate_alteration(timeseries_df = MFA_forFFC, token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmaXJzdE5hbWUiOiJBbHlzc2EiLCJsYXN0TmFtZSI6Ik9iZXN0ZXIiLCJlbWFpbCI6ImFseXNzYS5vYmVzdGVyQHdpbGRsaWZlLmNhLmdvdiIsInJvbGUiOiJVU0VSIiwiaWF0IjoxNTg0OTc4OTIwfQ.FvHgSUyLPN387rnFWiCQJFwEhPz6XRVn-N2j1IwfTq4", plot_output_folder = "C:/Users/aobester/OneDrive - California Department of Fish and Wildlife/R/Data_Output/MFA_output", comid=14994421 )

#create data frames to view the output
MFA_pred_percentiles <- MFA_observed$predicted_percentiles
MFA_pred_WYT_percentiles <- MFA_observed$predicted_wyt_percentiles
MFA_obs_percentiles <- MFA_observed$ffc_percentiles
MFA_ffc_results <- MFA_observed$ffc_results
MFA_doh_data <- MFA_observed$doh_data
MFA_alteration <- MFA_observed$alteration



#testing Ventura gage
#gage ID: 11118500 - doesn't work
#11118501 -runs
#COMID: 948070372

ventura_observed <- ffcAPIClient::evaluate_gage_alteration(gage_id = 11118501, token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmaXJzdE5hbWUiOiJBbHlzc2EiLCJsYXN0TmFtZSI6Ik9iZXN0ZXIiLCJlbWFpbCI6ImFseXNzYS5vYmVzdGVyQHdpbGRsaWZlLmNhLmdvdiIsInJvbGUiOiJVU0VSIiwiaWF0IjoxNTg0OTc4OTIwfQ.FvHgSUyLPN387rnFWiCQJFwEhPz6XRVn-N2j1IwfTq4", comid = 948070372, plot_output_folder = "C:/Users/aobester/OneDrive - California Department of Fish and Wildlife/R/Data_Output/Ventura_output")

