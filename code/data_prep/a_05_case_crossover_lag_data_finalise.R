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

# LOAD CASE CONTROL LAG HOSPITALIZATION FILES
dat=load_case_control_lag_data(cause)

# LOAD TEMPERATURE RECORDS (PRISM)
dat_tmean = data.frame()
for(year_selected in c(years_analysis[1]-1,years_analysis)){ # extra year for lags
  
  print(paste0('Loading temperature from ', year_selected))
  
  # Load temperature files by state
  dat_current = readRDS(paste0(zcta.temperature.folder,'tmean_national_zcta_',year_selected,'.rds')) %>%
    dplyr::mutate(date=dmy(date))
  dat_tmean = data.table::rbindlist(list(dat_tmean, dat_current))
}

# dat_tmean = dat_tmean %>%
#   dplyr::mutate(date=dmy(date))

# LOAD WBGT RECORDS (PRISM)
dat_wbgtmax = data.frame()
for(year_selected in c(years_analysis[1]-1,years_analysis)){ # extra year for lags
  
  print(paste0('Loading WBGTmax from ', year_selected))
  
  # Load temperature files by state
  dat_current = readRDS(paste0(zcta.wbgtmax.folder,'wbgtmax_national_zcta_',year_selected,'.rds')) %>%
    dplyr::mutate(date=dmy(date))
  dat_wbgtmax = data.table::rbindlist(list(dat_wbgtmax, dat_current))
}

# dat_wbgtmax = dat_wbgtmax %>%
#   dplyr::mutate(date=dmy(date))

# LOAD RH RECORDS (PRISM)
dat_rhmean = data.frame()
for(year_selected in c(years_analysis)){
  
  print(paste0('Loading relative humidity from ', year_selected))
  
  # Load temperature files by state
  dat_current = readRDS(paste0(zcta.rhmean.folder,'rhmean_national_zcta_',year_selected,'.rds')) %>%
    dplyr::mutate(date=dmy(date))
  dat_rhmean = data.table::rbindlist(list(dat_rhmean, dat_current))
}

# dat_rhmean = dat_rhmean %>%
#   dplyr::mutate(date=dmy(date))

# MERGE TO OBTAIN COMPLETE CASE-CROSSOVER DATA
dat = left_join(dat,dat_tmean,by=c('date_lag'='date','zcta'='zcta'))
dat = left_join(dat,dat_wbgtmax,by=c('date_lag'='date','zcta'='zcta'))
dat = left_join(dat,dat_rhmean,by=c('date_lag'='date','zcta'='zcta'))

# WHICH ZIPS ARE NOT MATCHING?
dat_missing_zcta = dat %>% dplyr::filter(is.na(tmean)==TRUE) %>% pull(zcta) %>% unique() %>% sort() %>% as.data.frame() %>% rename(zcta=1)

# SAVE
casecontrol.lag.temperature.cause.folder = paste0(casecontrol.lag.temperature.folder,cause,'/')
ifelse(!dir.exists(casecontrol.lag.temperature.cause.folder), dir.create(casecontrol.lag.temperature.cause.folder,recursive = TRUE), FALSE)
saveRDS(dat, paste0(casecontrol.lag.temperature.cause.folder,cause,'_case_control_lag_temperature_',years_analysis[1],'_',years_analysis[length(years_analysis)],'.rds'))
saveRDS(dat_missing_zcta, paste0(ziplookup.folder,'unmatched_exposure_zctas_',years_analysis[1],'_',years_analysis[length(years_analysis)],'.rds'))
