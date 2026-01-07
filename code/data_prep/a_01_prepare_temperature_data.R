# RUN AT LOCATION WITH PRISM GITHUB PROJECT ALSO LOCALLY (https://github.com/rmp15/PRISM-grids-into-FIPS-ZIP-censustract-USA)

# Load packages and file locations etc.
rm(list=ls())
project.folder = paste0(print(here::here()),'/')
source(paste0(project.folder,'create_folder_structure.R'))
source(paste0(functions.folder,'script_initiate.R'))

# Load data preparation functions
source(paste0(functions.folder,'data_prep_functions.R'))

library(dplyr)

## Temperature

# Select year to process and process then save results
for(year_selected in c(years_analysis[1]-1,years_analysis)){ # extra year for lags
  
  print(paste0('Processing temperature from ', year_selected))
  
  # Load temperature files by state
  dat_total = data.frame()
  for(state_selected in states_included){
    dat_current = readRDS(paste0(prism_temperature_data,'output/zip/',state_selected,'/tmean/weighted_area_raster_zip_',state_selected,'_tmean_daily_',year_selected,'.rds')) %>%
      dplyr::select(-day,-month,-year) %>% 
      mutate(state=state_selected) %>%
      mutate(zcta=as.numeric(as.character(zcta)))
    
    dat_total = data.table::rbindlist(list(dat_total, dat_current))
  }
  
  # take mean of zctas which cross state lines
  dat_total = dat_total %>%
    group_by(zcta,date) %>%
    summarise(tmean=mean(tmean))
  
  # save file
  saveRDS(dat_total,paste0(zcta.temperature.folder,'tmean_national_zcta_',year_selected,'.rds'))
  
}

## WBGT

# Select year to process and process then save results
for(year_selected in c(years_analysis[1]-1,years_analysis)){ # extra year for lags
  
  print(paste0('Processing WBGTmax from ', year_selected))
  
  # Load temperature files by state
  dat_total = data.frame()
  for(state_selected in states_included){
    dat_current = readRDS(paste0(prism_temperature_data,'output/zip/',state_selected,'/wbgtmax/weighted_area_raster_zip_',state_selected,'_wbgtmax_daily_',year_selected,'.rds')) %>%
      dplyr::select(-day,-month,-year) %>% 
      mutate(state=state_selected) %>%
      mutate(zcta=as.numeric(as.character(zcta)))
    
    dat_total = data.table::rbindlist(list(dat_total, dat_current))
  }
  
  # take mean of zctas which cross state lines
  dat_total = dat_total %>%
    group_by(zcta,date) %>%
    summarise(wbgtmax=mean(wbgtmax))
  
  # save file
  saveRDS(dat_total,paste0(zcta.wbgtmax.folder,'wbgtmax_national_zcta_',year_selected,'.rds'))
  
}

## RH

# Select year to process and process then save results
for(year_selected in c(years_analysis)){ # extra year for lags
  
  print(paste0('Processing RH from ', year_selected))
  
  # Load temperature files by state
  dat_total = data.frame()
  for(state_selected in states_included){
    dat_current = readRDS(paste0(prism_temperature_data,'output/zip/',state_selected,'/rhmean/weighted_area_raster_zip_',state_selected,'_rhmean_daily_',year_selected,'.rds')) %>%
      dplyr::select(-day,-month,-year) %>% 
      mutate(state=state_selected) %>%
      mutate(zcta=as.numeric(as.character(zcta)))
    
    dat_total = data.table::rbindlist(list(dat_total, dat_current))
  }
  
  # take mean of zctas which cross state lines
  dat_total = dat_total %>%
    group_by(zcta,date) %>%
    summarise(rhmean=mean(rhmean))
  
  # save file
  saveRDS(dat_total,paste0(zcta.rhmean.folder,'rhmean_national_zcta_',year_selected,'.rds'))
  
}
