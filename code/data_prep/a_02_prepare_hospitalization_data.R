# RUN ON HARVARD FASSE

# Load packages and file locations etc.
rm(list=ls())
project.folder = paste0(print(here::here()),'/')
source(paste0(project.folder,'create_folder_structure.R'))
source(paste0(functions.folder,'script_initiate.R'))

library(dplyr)
library(stringr)
library(readxl)
library(tibble)
library(tidyr)

# Load data preparation functions
source(paste0(functions.folder,'data_prep_functions.R'))

# ALL VIOLENCE SPECIFIC

# Select year to process and process then save results
dat_total = data.frame()
for(year_selected in years_analysis){
  
  print(paste0('Processing hospitalizations from ', year_selected))
  
  # Load hospitalization files
  dat_current = read.csv(paste0(raw_hosp_data,'hostile_diag_',year_selected,'.csv'))
  
  # Add to total
  dat_total = data.table::rbindlist(list(dat_total, dat_current))
  
}

# remove unnecessary columns
dat_total = dat_total %>%
  dplyr::select(-bene_id)

# save output
saveRDS(dat_total,paste0(allviolence.folder,'hostile_diag_',years_analysis[1],'_',years_analysis[length(years_analysis)],'.rds'))

# ASSAULT AND SUICIDE SPECIFIC

# load hospitalization look-up file
code_lookup = read_excel(paste0(causelookup.folder,'assault_suicide_lookup_forR.xlsx')) %>%
  select(ICD9,Grouping) 
code_lookup[1,1]='300.9' ; code_lookup[2,1]='307.9'
names(code_lookup) = c('ICD9','cause')

code_lookup = code_lookup %>% 
  mutate(ICD9 = gsub("\\.", "", ICD9)) 

# split up diagnosis into individual codes
dat_total = data.frame()
for(year_selected in years_analysis){
  
  print(paste0('Processing cause-specific hospitalizations from ', year_selected))
  
  # Load hospitalization files
  dat_current = read.csv(paste0(raw_hosp_data,'hostile_diag_',year_selected,'.csv'))
  
  # clean and parse out code column
  dat_current = dat_current %>% 
    mutate(diagnosis = gsub("\\[|\\]", "", diagnosis)) %>%
    mutate(diagnosis = gsub("'", "", diagnosis)) %>%
    mutate(diagnosis = gsub("", "", diagnosis)) %>%
    mutate(diagnosis=str_replace_all(diagnosis, " ", "")) %>%
    separate_wider_delim(diagnosis, ",", names = c(paste0("diag", c(1:9)))) %>%
    mutate(across(where(is.character), ~na_if(., "None")))
  
  # merge current file with suicide, assault classification
  for(i in c(1:9)){
    current = as.character(paste0("diag",i))
    current_col = as.data.frame(dat_current[,c(current)])
    names(current_col) = 'ICD9'
    dat_current = cbind(dat_current,current_col)
    dat_current = left_join(dat_current,code_lookup,by="ICD9")
    colnames(dat_current)[colnames(dat_current) == "cause"] = paste0('cause',i)
    dat_current$ICD9 = NULL
  }
  
  # find out how many causes per row in total and how many are mental health-related
  dat_current$no_causes = rowSums(is.na(dat_current[,paste0("diag", c(1:9))])!=TRUE)
  dat_current$no_violence_causes = rowSums(is.na(dat_current[,paste0("cause", c(1:9))])!=TRUE)
  
  # Add to total
  dat_total = data.table::rbindlist(list(dat_total, dat_current))
  
}

# split into suicide and violence datasets
causes = sort(unique(dat_total$cause1))

for(i in causes){
  
  # check if in primary, secondary, or both priary and secondary
  name = paste0(i,'_check')
  print(name)
  
  # check if in primary, secondary, or both primary and secondary
  dat_total[[name]] = ifelse(
    rowSums(dat_total[,c(paste0('cause',c(1)))] == i, na.rm=TRUE)>0 & rowSums(dat_total[,c(paste0('cause',c(2:9)))] == i, na.rm=TRUE)==0, 'primary',
                       ifelse(rowSums(dat_total[,c(paste0('cause',c(1)))] == i, na.rm=TRUE)==0 & rowSums(dat_total[,c(paste0('cause',c(2:9)))] == i, na.rm=TRUE)>0, 'secondary',      
                              ifelse(rowSums(dat_total[,c(paste0('cause',c(1)))] == i, na.rm=TRUE)>0 & rowSums(dat_total[,c(paste0('cause',c(2:9)))] == i, na.rm=TRUE)>0, 'both',
                                     'none')))
  
  # column to keep with records of whether cause of hospitalization appears
  column_to_keep=dat_total[[name]]
  
  # assign own dataset by cause only keeping where cause is in primary, secondary or both
  dat_to_save = dat_total %>%
    select(-contains(c('check'))) %>%
    add_column(where_in_record=column_to_keep) %>%
    filter(where_in_record%in%c('primary','secondary','both'))
  
  # remove unnecessary columns
  dat_to_save = dat_to_save %>%
    dplyr::select(-bene_id)
  
  print(dat_to_save %>%
          group_by(where_in_record) %>%
          tally())
  
  print(paste0('Total records = ', nrow(dat_to_save)))
  
  assign(paste0('dat_to_save_',i), dat_to_save)
}

# save output
saveRDS(dat_to_save_Assault,paste0(assault.folder,'hostile_diag_',years_analysis[1],'_',years_analysis[length(years_analysis)],'.rds'))
saveRDS(dat_to_save_Suicide,paste0(suicide.folder,'hostile_diag_',years_analysis[1],'_',years_analysis[length(years_analysis)],'.rds'))
