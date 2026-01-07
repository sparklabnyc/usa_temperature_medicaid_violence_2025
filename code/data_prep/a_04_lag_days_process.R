# RUN ON HARVARD FASSE

# Load packages and file locations etc.
rm(list=ls())
project.folder = paste0(print(here::here()),'/')
source(paste0(project.folder,'create_folder_structure.R'))
source(paste0(functions.folder,'script_initiate.R'))

# Load packages
library(dplyr)
library(lubridate)
library(tidyr)

# Load data preparation functions
source(paste0(functions.folder,'data_prep_functions.R'))

# arguments from Rscript
source(paste0(functions.folder,'arguments.R'))

# LOAD CASE CONTROL HOSPITALIZATION FILES
dat=load_case_control_data(cause)

# SPLIT DATA BY YEARS
years.list = dat %>% split(dat$year)

# CREATE CONTROL DAYS SAVING OUTPUT
lapply(years.list,create_lag_days_by_year)