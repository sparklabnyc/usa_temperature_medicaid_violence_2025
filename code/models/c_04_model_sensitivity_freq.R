rm(list=ls())

# 1a Declare root directory, folder locations and load essential stuff
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

# arguments from Rscript
source(paste0(functions.folder,'arguments.R'))
print(paste0('running Frequentist main model for ', cause,' and ', exposure))

source(paste0(functions.folder,'frequentist_models_and_functions.R'))

# load hospitalization data
years_analysis = years_analysis_sensitivity
source(paste0(functions.folder,'load_data.R'))

# Form cross-basis for dlnm from optimal lag and var values
source(paste0(functions.folder,'crossbasis.R'))

# CLOGISTIC MODEL (FREQUENTIST)
pdf_suffix = '_sensitivity.pdf'
save_suffix = '_sensitivity.rds'
source(paste0(functions.folder,'frequentist_run.R'))
source(paste0(functions.folder,'frequentist_plot.R'))
source(paste0(functions.folder,'frequentist_save.R'))
