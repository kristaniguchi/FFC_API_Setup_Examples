# Script to run functional flows calculator and plot results on interactive dashboard
# Annie Holt (adpated from Ethan Baruch script plot_FFC_metrics.R, which was shared with SCCWRP(Kris) by Sarah Yarnell via email)

# libraries
library(tidyverse)
library(lubridate)
library(plotly)
library(ffcAPIClient)

# sample flow data (COMID 14996611)
setwd("C:/Users/anneh/Documents/Repositories/FFC_API_Setup_Examples")
flow_dat <- read.csv("./data/Input_02/sample.csv")

#### RUN FFC ####

# Annie's FFC toke, update depending on user
ffctoken <- ffcAPIClient::set_token("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmaXJzdE5hbWUiOiJBbm5lIiwibGFzdE5hbWUiOiJIb2x0IiwiZW1haWwiOiJhZ2hvbHRAdWNkYXZpcy5lZHUiLCJyb2xlIjoiVVNFUiIsImlhdCI6MTYwNTI5NTQzMn0.wzbBa5rLs6DAvEpUQVVLmQx23g2EBgEQhM2wcqyweUc")

# create 'flow' and 'date' columns with proper formatting (date in MM/DD/YYY)
flow_dat_2 <- flow_dat %>% 
  mutate(date = mdy(date)) %>%
  mutate(date = format(date, "%m/%d/%Y")) %>%
  mutate(date = as.character(date), as.character(flow)) %>% 
  select(date, flow)

# run through FFC evaluate gage alteration function
ex_ffc <- ffcAPIClient::evaluate_alteration(timeseries_df  = flow_dat_2, 
                                            token = get_token(),
                                            comid = 14996611)

# extract results/creating result dataframes
ex_ffm_results <- ex_ffc$ffc_results
# ex_pred_percentiles <- ex_ffc$predicted_percentiles
# ex_pred_WYT_percentiles <- ex_ffc$predicted_wyt_percentiles
# ex_obs_percentiles <- ex_ffc$ffc_percentiles
# ex_doh_data <- ex_ffc$doh_data
# ex_alteration <- ex_ffc$alteration

### PREP FOR PLOTTING ####

# NOTE: timing is output in water year days. Need to convert to Julian days before plotting
ex_ffm_dates <- ex_ffm_results %>% 
  mutate(Year = as.integer(Year)) %>% 
  mutate(DS_Tim_Dt = as.Date(paste(DS_Tim, Year), '%j %Y')-91, #Date in Julian days
         FA_Tim_Dt = as.Date(paste(FA_Tim, Year-1), '%j %Y')+274, #add 274 because water year starts Oct 1
         Wet_Tim_Dt = as.Date(paste(Wet_Tim, Year), '%j %Y')-91, #Date in Julian days
         SP_Tim_Dt = as.Date(paste(SP_Tim, Year), '%j %Y')-91) #Date in Julian days

# Add timing for each flow metric
flow_tim <- flow_dat_2 %>%
  mutate(date = mdy(date)) %>% 
  left_join(select(ex_ffm_dates, DS_Tim_Dt, DS_Mag_50), by = c("date" = "DS_Tim_Dt"))%>% 
  left_join(select(ex_ffm_dates, FA_Tim_Dt, FA_Mag), by = c("date" = "FA_Tim_Dt"))%>% 
  left_join(select(ex_ffm_dates, Wet_Tim_Dt, Wet_BFL_Mag_10), by = c("date" = "Wet_Tim_Dt")) %>% 
  left_join(select(ex_ffm_dates, SP_Tim_Dt, SP_Mag), by = c("date" = "SP_Tim_Dt"))

# Create interactive figure
hydro_fig <- plot_ly(data = flow_tim, x = ~date, y = ~flow, type = 'scatter', mode = 'line',
                        name = "Discharge") %>%
  add_trace(y = ~DS_Mag_50,  name = 'DS_Mag_50 + DS_Tim', mode = 'markers') %>%  #Add DS timing
  add_trace(y = ~FA_Mag,  name = 'FA_Mag + FA_Tim', mode = 'markers') %>%  #Add Fall timing
  add_trace(y = ~Wet_BFL_Mag_10,  name = 'Wet_BFL_Mag_10 + Wet_Tm', mode = 'markers') %>%  #Add Wet timing
  add_trace(y = ~SP_Mag,  name = 'SP_Mag + SP_Tm', mode = 'markers') %>% #Add spring timing
  layout(title = "COMID 14996611",
         xaxis = list(title = "Date"),
         yaxis = list(title = "Streamflow (CFS)"))
  layout(title = "Example")
         xaxis = list(title = "Date"),
         yaxis = list (title = "Streamflow (CFS)"))

hydro_fig



