## 01 Setup FFC API Package
## CEFF Workshop - CABW/Cal-SFS Meeting 2022
##https://github.com/ceff-tech/ffc_api_client 


#1. install {devtools}, only have to do this once
install.packages('devtools') 
#load devtools library
library(devtools)

#2. install {ffcAPIClient} package, only have to do this once
devtools::install_github("ceff-tech/ffc_api_client/ffcAPIClient")
#load ffc library
library(ffcAPIClient)

#3. obtain token from eflows website, see setup instructions at https://github.com/ceff-tech/ffc_api_client 

#4. PASTE YOUR TOKEN HERE for reference: "paste_long_string_of_letters_and_numbers_here"
