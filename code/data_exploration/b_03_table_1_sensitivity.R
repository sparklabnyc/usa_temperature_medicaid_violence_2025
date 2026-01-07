# RUN ON HARVARD FASSE

# Load packages and file locations etc.
rm(list=ls())
project.folder = paste0(print(here::here()),'/')
source(paste0(project.folder,'create_folder_structure.R'))
source(paste0(functions.folder,'script_initiate.R'))

# Load data preparation functions
source(paste0(functions.folder,'data_prep_functions.R'))

library(dplyr)
library(flextable)
library(gt)
library(gtsummary)
library(stringr)

# Load all violence data
cause = 'All_violence'
casecontrol.lag.temperature.cause.folder = paste0(casecontrol.lag.temperature.folder,cause,'/')
dat.all.violence = readRDS(paste0(casecontrol.lag.temperature.cause.folder,cause,
                             '_case_control_lag_temperature_',years_analysis[1],
                             '_',years_analysis[length(years_analysis)],'.rds')) %>%
  mutate(lag=str_replace(lag, "-","lag")) %>%
  mutate(lag=str_replace(lag,"0","lag0")) %>%
  filter(ck==1) %>%
  filter(DayName=='CaseDay_0') %>%
  filter(lag=='lag0') %>%
  filter(year%in%years_analysis_sensitivity)

# Load assault data
cause = 'assault'
casecontrol.lag.temperature.cause.folder = paste0(casecontrol.lag.temperature.folder,cause,'/')
dat.assault = readRDS(paste0(casecontrol.lag.temperature.cause.folder,cause,
                             '_case_control_lag_temperature_',years_analysis[1],
                             '_',years_analysis[length(years_analysis)],'.rds')) %>%
  mutate(lag=str_replace(lag, "-","lag")) %>%
  mutate(lag=str_replace(lag,"0","lag0")) %>%
  filter(ck==1) %>%
  filter(DayName=='CaseDay_0') %>%
  filter(lag=='lag0') %>%
  filter(year%in%years_analysis_sensitivity)

# Load suicide data
cause = 'suicide'
casecontrol.lag.temperature.cause.folder = paste0(casecontrol.lag.temperature.folder,cause,'/')
dat.suicide = readRDS(paste0(casecontrol.lag.temperature.cause.folder,cause,
                             '_case_control_lag_temperature_',years_analysis[1],
                             '_',years_analysis[length(years_analysis)],'.rds')) %>%
  mutate(lag=str_replace(lag, "-","lag")) %>%
  mutate(lag=str_replace(lag,"0","lag0")) %>%
  filter(ck==1) %>%
  filter(DayName=='CaseDay_0') %>%
  filter(lag=='lag0') %>%
  filter(year%in%years_analysis_sensitivity)

# total data
dat_total = rbind(dat.all.violence,dat.assault,dat.suicide) %>%
  filter(is.na(tmean)==FALSE)

# add information on climate region
dat_climate_region = read.csv(paste0(ziplookup.folder,'name_fips_lookup.csv')) %>%
  rename(STATE=code_name)
dat_zcta_to_state = read.csv(paste0(ziplookup.folder,'Zip_to_ZCTA_crosswalk_2015_JSI.csv')) %>%
  distinct(STATE, ZCTA) %>%
  left_join(.,dat_climate_region) %>%
  select(ZCTA,climate_region) %>%
  rename(zcta=ZCTA)

dat_total = dat_total %>%
  left_join(.,dat_zcta_to_state)

# which zctas are in study?
zctas_included = dat_total %>% pull(zcta) %>% unique()

# add data by SES
dat.ses = read.csv(paste0(census.zcta.folder,'census_interpolated_zips.csv')) %>%
  filter(year==year_analysis_end) %>%
  filter(zcta%in%zctas_included) %>%
  group_by(zcta) %>%
  summarise(pct_white=mean(pct_white), 
            poverty=mean(poverty), education=mean(education)) %>%
  ungroup() %>%
  mutate(pct_nonwhite=1-pct_white) %>%
  mutate(nonwhite_quintile=ntile(pct_nonwhite,5)) %>%
  mutate(poverty_quintile=ntile(poverty,5)) %>%
  mutate(education_quintile=ntile(education,5)) %>%
  select(zcta,poverty_quintile,education_quintile,nonwhite_quintile)

dat_total = dat_total %>%
  left_join(.,dat.ses) %>%
  filter(is.na(poverty_quintile)==FALSE)

# Table 1 prepare
# This link is super useful 
# http://www.danieldsjoberg.com/gtsummary/articles/tbl_summary.html
table_1 = dat_total %>%  
  dplyr::select(diagnosis, sex, age, climate_region, 
                poverty_quintile,education_quintile,nonwhite_quintile) %>%
  dplyr::mutate(agegroup = ifelse(age<0,'<0 years (?)',
                           ifelse(age<25,'0-24 years',
                           ifelse(age<45,'25-44 years',
                           ifelse(age<65,'45-64 years',
                                         '65+ years'))))) %>%
  rename(Sex=sex,'Age group'=agegroup,Cause=diagnosis,
         `Climate region`=climate_region,`Poverty quintiles`=poverty_quintile,
         `Education quintiles`=education_quintile,`Non-white quintiles`=nonwhite_quintile,
         ) %>%
  mutate(Sex=recode_factor(Sex, 
                           'F'='Female',
                           'M'='Male')) %>%
  mutate('Age group'=recode_factor(`Age group`, 
                                   `<0 years (?)`='<0 years (?)',
                                   `0-24 years`='0-24 years',
                                   `25-44 years`='25-44 years',
                                   `45-64 years`='45-64 years',
                                   `65+ years`='65+ years')) %>% 
  mutate(Cause=case_when(
    Cause == "All_violence" ~ "All violence",
    Cause == "assault" ~ "Assaults",
    Cause == "suicide" ~ "Suicide attempts",
    TRUE ~ NA_character_
  )) %>% 
  select(Cause,Sex,`Age group`,`Climate region`, 
         `Poverty quintiles`, `Education quintiles`,`Non-white quintiles`) %>%
  tbl_summary(missing = "no",
              label = list(`Age group` ~ "Age group",
                           Sex ~ "Sex"),
              by = Cause,
              statistic = list(all_continuous() ~ "{mean} ({sd})")) %>% 
  bold_labels()

# Table 1 main causes save as Word output
table_1 %>%
  as_flex_table() %>%
  flextable::save_as_docx(path = paste0(table1.folder,'table1 main causes sensitivity.docx'))