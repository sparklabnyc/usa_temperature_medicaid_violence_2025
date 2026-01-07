# RUN ON LOCALLY OR ON HARVARD FASSE

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

# Load missing ZIPS
dat_missing_zcta = readRDS(paste0(ziplookup.folder,'unmatched_exposure_zctas_',years_analysis[1],'_',years_analysis[length(years_analysis)],'.rds')) %>%
  mutate(missing=1)

# Load ZCTA info
dat_zip_to_zcta_full = read.csv(paste0(ziplookup.folder,'Zip_to_ZCTA_crosswalk_2015_JSI.csv')) %>%
  dplyr::rename(zip=ZIP,zcta=ZCTA)

# Merge to find full details of missing temperature zctas
dat_merged = left_join(dat_missing_zcta,dat_zip_to_zcta_full)

# Which states contain the missing zctas? ("PR" "VI" "HI" "GU" "AK" i.e., none in CONUS)
dat_missing_states = dat_merged %>% pull(STATE) %>% unique()