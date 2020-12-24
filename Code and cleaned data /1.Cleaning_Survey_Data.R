#### Preamble ####
# Purpose: Cleaning Survey data
# Author: Leyi Wang (1006318682)
# Data: 16 December 2020
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data and save it into the 
#   same folder as this document


#### Workspace setup ####
setwd("~/Desktop/R studio/STA304/Final Project")
library(tidyverse)
library(plyr)
devtools::install_github("hodgettsp/cesR")

library(cesR)

get_ces("ces2019_web")

ces2019_web <- labelled::to_factor(ces2019_web)
head(ces2019_web)

survey_data <- select(ces2019_web, c(cps19_gender, cps19_ResponseId, cps19_province, cps19_education , 
                                     cps19_income_cat, cps19_v_likely, cps19_votechoice,
                                     cps19_vote_unlikely, cps19_v_advance, cps19_vote_lean))

head(survey_data)
survey_data<-survey_data%>%mutate(cps19_vote = case_when(cps19_votechoice == "Liberal Party" ~ "Liberal Party",
                                                         cps19_votechoice == "Conservative Party"  ~ "Conservative Party",
                                                         cps19_votechoice == "ndp" ~ "NDP",
                                                         cps19_votechoice == "Bloc Québécois" ~ "Bloc Québécois",
                                                         cps19_votechoice == "Green Party" ~ "Green Party",
                                                         cps19_votechoice == "People's Party" ~ "People's Party",
                                                         cps19_vote_unlikely == "Liberal Party" ~ "Liberal Party", 
                                                         cps19_vote_unlikely == "Conservative Party"  ~ "Conservative Party",
                                                         cps19_vote_unlikely == "ndp" ~ "NDP",
                                                         cps19_vote_unlikely == "Bloc Québécois" ~ "Bloc Québécois",
                                                         cps19_vote_unlikely == "Green Party" ~ "Green Party",
                                                         cps19_vote_unlikely == "People's Party" ~ "People's Party",
                                                         cps19_v_advance == "Liberal Party" ~ "Liberal Party",
                                                         cps19_v_advance == "Conservative Party"  ~ "Conservative Party",
                                                         cps19_v_advance == "ndp" ~ "NDP",
                                                         cps19_v_advance == "Bloc Québécois" ~ "Bloc Québécois",
                                                         cps19_v_advance == "Green Party" ~ "Green Party",
                                                         cps19_v_advance == "People's Party" ~ "People's Party",
                                                         cps19_vote_lean == "Liberal Party" ~ "Liberal Party",
                                                         cps19_vote_lean == "Conservative Party"  ~ "Conservative Party",
                                                         cps19_vote_lean == "ndp" ~ "NDP",
                                                         cps19_vote_lean == "Bloc Québécois" ~ "Bloc Québécois",
                                                         cps19_vote_lean == "Green Party" ~ "Green Party",
                                                         cps19_vote_lean == "People's Party" ~ "People's Party"))
                                                         
survey_data<- survey_data%>%filter(cps19_vote == "Liberal Party"|cps19_vote == "Conservative Party")
survey_data<-survey_data%>%mutate(vote_LP = ifelse(cps19_vote == "Liberal Party",1,0))

#removing all the missing value in cps19_vote since the answer "Don't know/Peter not to answer" is meaningless.


survey_data <- select(survey_data, c(cps19_gender, cps19_province, cps19_education , 
                                     cps19_income_cat,cps19_vote,vote_LP)) 
survey_data<-na.omit(survey_data)
survey_data<-rename(survey_data, c("cps19_province" = "province", "cps19_education"="education", 
                                   "cps19_income_cat" = "income","cps19_vote" = "vote","cps19_gender"= "gender"))

#gender
survey_data$gender<-revalue(survey_data$gender,c("A man" ="Male", "A woman" ="Female",
                                                 "Other (e.g. Trans, non-binary, two-spirit, gender-queer)" = "Other gender"))
#income 

survey_data$income <-revalue(survey_data$income,c("No income"="Low-income",
                                                  "$1 to $30,000"="Low-income",
                                                  "$30,001 to $60,000"="Middle-income",
                                                  "$60,001 to $90,000"="Middle-income",
                                                  "$90,001 to $110,000"="Middle-income",
                                                  "$110,001 to $150,000"="Middle-income",
                                                  "$150,001 to $200,000"="Upper-income",
                                                  "More than $200,000"="Upper-income"))

survey_data<-survey_data%>%filter(income!="Don't know/ Prefer not to answer")
#education
survey_data$education<-revalue(survey_data$education, c("No schooling"="Below Upper-Secondary",
                                              "Some elementary school"="Below Upper-Secondary",
                                              "Completed elementary school"="Below Upper-Secondary",
                                              "Some secondary/ high school"="Upper Secondary",
                                              "Completed secondary/ high school"="Upper Secondary",
                                              "Some technical, community college, CEGEP, College Classique"="Tertiary Education",
                                              "Completed technical, community college, CEGEP, College Classique"="Tertiary Education",
                                              "Some university"="Tertiary Education",
                                              "Bachelor's degree"="Tertiary Education",
                                              "Master's degree"="Tertiary Education",
                                              "Professional degree or doctorate"="Tertiary Education"))

survey_data<-filter(survey_data,education!="Don't know/ Prefer not to answer")

write_csv(survey_data, "survey_data.csv")
