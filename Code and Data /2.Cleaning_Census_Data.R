#### Preamble ####
# Purpose: Cleaning Census data
# Author: Leyi Wang (1006318682)
# Data: 16 December 2020
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data and save it into the 
#   same folder as this document


#### Workspace setup ####
setwd("~/Desktop/R studio/STA304/Final Project")
gss <- read.csv("gss.csv")
library(tidyverse)
library(plyr)


census_data <- select(gss, c(sex, province, education,income_respondent))
head(census_data)
census_data<-na.omit(census_data)
census_data<-rename(census_data, c("sex"="gender","income_respondent"="income"))

#cleaning income variable 
census_data$income<-revalue(census_data$income, c("Less than $25,000"="Low-income",
                                           "$25,000 to $49,999"="Low-income",
                                           "$50,000 to $74,999"="Middle-income",
                                           "$75,000 to $99,999"="Middle-income",
                                           "$100,000 to $ 124,999"="Middle-income",
                                           "$125,000 and more"="Upper-income"))
                                           

#cleaning education variable

census_data$education<-revalue(census_data$education, c("Less than high school diploma or its equivalent"="Below Upper-Secondary",
                                                        "High school diploma or a high school equivalency certificate"="Upper Secondary",
                                                        "Trade certificate or diploma"="Tertiary Education",
                                                        "College, CEGEP or other non-university certificate or di..."="Tertiary Education",
                                                        "University certificate or diploma below the bachelor's level"="Tertiary Education",
                                                        "University certificate, diploma or degree above the bach..."="Tertiary Education",
                                                        "Bachelor's degree (e.g. B.A., B.Sc., LL.B.)"="Tertiary Education"))

