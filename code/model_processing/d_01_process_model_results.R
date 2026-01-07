# load packages and file locations etc.
rm(list=ls())
project.folder = paste0(print(here::here()),'/')
source(paste0(project.folder,'create_folder_structure.R'))
source(paste0(functions.folder,'script_initiate.R'))

# Load packages
library(dlnm)
library(dplyr)
library(lubridate)
library(splines)
library(stringr)
library(survival)
library(tidyr)

# load plotting function
source(paste0(functions.folder,'frequentist_processing_functions.R'))

# Temperature

exposure='tmean'

# process results for each type of analysis made
dat.results = data.frame()
for (analysis in analyses_made){
  print(analysis)
  dat.results = rbind(dat.results,invisible(process_results_linear(analysis,exposure)))
}

dat.results.tmean = dat.results

# WBGTmax

exposure='wbgtmax'

# process results for each type of analysis made
dat.results = data.frame()
for (analysis in analyses_made){
  print(analysis)
  dat.results = rbind(dat.results,invisible(process_results_linear(analysis,exposure)))
}

dat.results.wbgtmax = dat.results

# combine results from tmean and wbgtmax

dat.results = rbind(dat.results.tmean,dat.results.wbgtmax)

# create output folder
cause.model.exploration.folder = paste0(model.exploration.folder,'All_together/')
ifelse(!dir.exists(cause.model.exploration.folder), dir.create(cause.model.exploration.folder, recursive=TRUE), FALSE)

# Save and print results
dat.results %>%
  write.csv(paste0(cause.model.exploration.folder,'overall_dlnm_results_freq.csv'),row.names = FALSE)
