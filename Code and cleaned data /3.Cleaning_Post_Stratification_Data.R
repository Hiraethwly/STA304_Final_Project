#### Preamble ####
# Purpose: Cleaning post stratification data
# Author: Leyi Wang (1006318682), 
# Data: 3 November 2020
# License: MIT
# Pre-requisites: 
# - Need to run the previous Rscript (1,2,3) and restart R session now





############# Cleaning Post stratification data #################

# !!!!!!!!!!!!! Restart R session before running this code !!!!!!!!!!!!!

#### Workspace setup ####
library(tidyverse)



# Set up Post stratification data, grouping by age and sex

post_data <- 
  census_data %>%
  count(province,gender,income,education) %>%
  group_by(province,gender,income,education) 




# Saving the poststratification data

write_csv(post_data, "post_census_data.csv")



