## 01 Setup FFC API Package
## CEFF Workshop - SRF Meeting 4/20/22

#1. install {devtools}, only have to do this once
install.packages('devtools') 
#load devtools library
library(devtools)

#2. install {ffcAPIClient} package, only have to do this once
devtools::install_github("ceff-tech/ffc_api_client/ffcAPIClient")
#load ffc library
library(ffcAPIClient)

#3. obtain token from eflows website, see setup instructions at https://github.com/ceff-tech/ffc_api_client 

#4. PASTE YOUR TOKEN HERE for reference: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmaXJzdE5hbWUiOiJTYXJhaCIsImxhc3ROYW1lIjoiWWFybmVsbCIsImVtYWlsIjoic215YXJuZWxsQHVjZGF2aXMuZWR1Iiwicm9sZSI6IlVTRVIiLCJpYXQiOjE1Nzg0MjE4NjN9.9XR7j2lUDPZ-gdROroHspXjIySpF4kFSYPkXnLSfkBs"
ffctoken <- 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmaXJzdE5hbWUiOiJLcmlzIiwibGFzdE5hbWUiOiJUYW5pZ3VjaGkgUXVhbiIsImVtYWlsIjoia3Jpc3RpbmV0cUBzY2N3cnAub3JnIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE2MTMwNjkxMDJ9.pOy0lTuKBm75Us_PtD8G2yD_l9ISZea2atsPwWUCsDw'
