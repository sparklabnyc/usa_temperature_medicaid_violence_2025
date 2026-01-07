# RUN ON HARVARD FASSE

# Load packages and file locations etc.
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

# Load case crossover lagged data
cause="All_violence"
cause.model.exploration.folder = paste0(model.exploration.folder,cause,'/')
ifelse(!dir.exists(cause.model.exploration.folder), dir.create(cause.model.exploration.folder, recursive=TRUE), FALSE)
casecontrol.lag.temperature.cause.folder = paste0(casecontrol.lag.temperature.folder,cause,'/')
dat.complete = readRDS(paste0(casecontrol.lag.temperature.cause.folder,cause,'_case_control_lag_temperature_',years_analysis[1],'_',years_analysis[length(years_analysis)],'.rds')) %>%
  mutate(lag=str_replace(lag, "-","lag")) %>%
  mutate(lag=str_replace(lag,"0","lag0")) %>%
  drop_na() %>% # rows disappear from non-CONUS ZIP Codes
  select(-wbgtmax) #%>%
  #dplyr::filter(sex=='M') %>%
  #dplyr::filter(age<=64)

# Make into wide table with lags wide
dat.complete = dat.complete %>%
  select(-date_lag) %>%
  spread(lag, tmean)

# Find temperature stats for use later
temp_mean = dat.complete %>%
  summarise(mean(lag0)) %>%
  as.numeric

temp_min = dat.complete %>%
  summarise(min(lag0)) %>%
  as.numeric

temp_max = dat.complete %>%
  summarise(max(lag0)) %>%
  as.numeric

temp_seq=seq(from=temp_min, to=temp_max,length.out = 200)
temp_data = data.frame(`lag0`=temp_seq, nr=1)

# Form cross-basis for dnlm from lag and var values
source(paste0(functions.folder,'frequentist_models_and_functions.R'))

exp_matrix = dat.complete %>%
  select(contains("lag"))

cb.temp.var1.lag2 = crossbasis_form(exp_matrix,1,2)
cb.temp.var1.lag3 = crossbasis_form(exp_matrix,1,3)
cb.temp.var1.lag4 = crossbasis_form(exp_matrix,1,4)
cb.temp.var1.lag5 = crossbasis_form(exp_matrix,1,5)
cb.temp.var1.lag6 = crossbasis_form(exp_matrix,1,6)

cb.temp.var2.lag2 = crossbasis_form(exp_matrix,2,2)
cb.temp.var2.lag3 = crossbasis_form(exp_matrix,2,3)
cb.temp.var2.lag4 = crossbasis_form(exp_matrix,2,4)
cb.temp.var2.lag5 = crossbasis_form(exp_matrix,2,5)
cb.temp.var2.lag6 = crossbasis_form(exp_matrix,2,6)

cb.temp.var3.lag2 = crossbasis_form(exp_matrix,3,2)
cb.temp.var3.lag3 = crossbasis_form(exp_matrix,3,3)
cb.temp.var3.lag4 = crossbasis_form(exp_matrix,3,4)
cb.temp.var3.lag5 = crossbasis_form(exp_matrix,3,5)
cb.temp.var3.lag6 = crossbasis_form(exp_matrix,3,6)

cb.temp.var4.lag2 = crossbasis_form(exp_matrix,4,2)
cb.temp.var4.lag3 = crossbasis_form(exp_matrix,4,3)
cb.temp.var4.lag4 = crossbasis_form(exp_matrix,4,4)
cb.temp.var4.lag5 = crossbasis_form(exp_matrix,4,5)
cb.temp.var4.lag6 = crossbasis_form(exp_matrix,4,6)

# CLOGISTIC MODEL (FREQUENTIST)
print(paste0('running Frequentist models for ', cause))

# run frequentist models
mod.freq.linear.temp        = clogit_run_alt(dat.complete,fml.linear.temp.alt)
mod.freq.spline.3deg        = clogit_run_alt(dat.complete,fml.spline.3deg.alt)
mod.freq.spline.4deg        = clogit_run_alt(dat.complete,fml.spline.4deg.alt)

mod.freq.dnlm.var1.lag2     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var1.lag2'))
mod.freq.dnlm.var1.lag3     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var1.lag3'))
mod.freq.dnlm.var1.lag4     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var1.lag4'))
mod.freq.dnlm.var1.lag5     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var1.lag5'))
mod.freq.dnlm.var1.lag6     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var1.lag6'))

mod.freq.dnlm.var2.lag2     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var2.lag2'))
mod.freq.dnlm.var2.lag3     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var2.lag3'))
mod.freq.dnlm.var2.lag4     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var2.lag4'))
mod.freq.dnlm.var2.lag5     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var2.lag5'))
mod.freq.dnlm.var2.lag6     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var2.lag6'))

mod.freq.dnlm.var3.lag2     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var3.lag2'))
mod.freq.dnlm.var3.lag3     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var3.lag3'))
mod.freq.dnlm.var3.lag4     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var3.lag4'))
mod.freq.dnlm.var3.lag5     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var3.lag5'))
mod.freq.dnlm.var3.lag6     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var3.lag6'))

mod.freq.dnlm.var4.lag2     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var4.lag2'))
mod.freq.dnlm.var4.lag3     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var4.lag3'))
mod.freq.dnlm.var4.lag4     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var4.lag4'))
mod.freq.dnlm.var4.lag5     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var4.lag5'))
mod.freq.dnlm.var4.lag6     = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp.var4.lag6'))

calculate_AIC = function(model){
  value = 2*length(model$coefficients)-2*(model$loglik[2])
}

# Compare AIC values for each of the models
aic.mod.freq.linear.temp        = calculate_AIC(mod.freq.linear.temp)
aic.mod.freq.spline.3deg        = calculate_AIC(mod.freq.spline.3deg)
aic.mod.freq.spline.4deg        = calculate_AIC(mod.freq.spline.4deg)

aic.mod.freq.dnlm.var1.lag2     = calculate_AIC(mod.freq.dnlm.var1.lag2)
aic.mod.freq.dnlm.var1.lag3     = calculate_AIC(mod.freq.dnlm.var1.lag3)
aic.mod.freq.dnlm.var1.lag4     = calculate_AIC(mod.freq.dnlm.var1.lag4)
aic.mod.freq.dnlm.var1.lag5     = calculate_AIC(mod.freq.dnlm.var1.lag5)
aic.mod.freq.dnlm.var1.lag6     = calculate_AIC(mod.freq.dnlm.var1.lag6)

aic.mod.freq.dnlm.var2.lag2     = calculate_AIC(mod.freq.dnlm.var2.lag2)
aic.mod.freq.dnlm.var2.lag3     = calculate_AIC(mod.freq.dnlm.var2.lag3)
aic.mod.freq.dnlm.var2.lag4     = calculate_AIC(mod.freq.dnlm.var2.lag4)
aic.mod.freq.dnlm.var2.lag5     = calculate_AIC(mod.freq.dnlm.var2.lag5)
aic.mod.freq.dnlm.var2.lag6     = calculate_AIC(mod.freq.dnlm.var2.lag6)

aic.mod.freq.dnlm.var3.lag2     = calculate_AIC(mod.freq.dnlm.var3.lag2)
aic.mod.freq.dnlm.var3.lag3     = calculate_AIC(mod.freq.dnlm.var3.lag3)
aic.mod.freq.dnlm.var3.lag4     = calculate_AIC(mod.freq.dnlm.var3.lag4)
aic.mod.freq.dnlm.var3.lag5     = calculate_AIC(mod.freq.dnlm.var3.lag5)
aic.mod.freq.dnlm.var3.lag6     = calculate_AIC(mod.freq.dnlm.var3.lag6)

aic.mod.freq.dnlm.var4.lag2     = calculate_AIC(mod.freq.dnlm.var4.lag2)
aic.mod.freq.dnlm.var4.lag3     = calculate_AIC(mod.freq.dnlm.var4.lag3)
aic.mod.freq.dnlm.var4.lag4     = calculate_AIC(mod.freq.dnlm.var4.lag4)
aic.mod.freq.dnlm.var4.lag5     = calculate_AIC(mod.freq.dnlm.var4.lag5)
aic.mod.freq.dnlm.var4.lag6     = calculate_AIC(mod.freq.dnlm.var4.lag6)

aics = rbind(aic.mod.freq.linear.temp,
             aic.mod.freq.spline.3deg,aic.mod.freq.spline.4deg,
             aic.mod.freq.dnlm.var1.lag2,aic.mod.freq.dnlm.var1.lag3,
             aic.mod.freq.dnlm.var1.lag4,aic.mod.freq.dnlm.var1.lag5,
             aic.mod.freq.dnlm.var1.lag6,
             aic.mod.freq.dnlm.var2.lag2,aic.mod.freq.dnlm.var2.lag3,
             aic.mod.freq.dnlm.var2.lag4,aic.mod.freq.dnlm.var2.lag5,
             aic.mod.freq.dnlm.var2.lag6,
             aic.mod.freq.dnlm.var3.lag2,aic.mod.freq.dnlm.var3.lag3,
             aic.mod.freq.dnlm.var3.lag4,aic.mod.freq.dnlm.var3.lag5,
             aic.mod.freq.dnlm.var3.lag6,
             aic.mod.freq.dnlm.var4.lag2,aic.mod.freq.dnlm.var4.lag3,
             aic.mod.freq.dnlm.var4.lag4,aic.mod.freq.dnlm.var4.lag5,
             aic.mod.freq.dnlm.var4.lag6
             )

aics = as.data.frame(aics) %>%
  tibble::rownames_to_column()
names(aics) = c('model','AIC')

aics = aics %>%
  mutate(variable='tmean')

# # Save results as csv
readr::write_csv(aics,paste0(cause.model.exploration.folder,cause,'_aic_values_tmean.csv'))

# plotting functions
source(paste0(functions.folder,'plotting_functions.R'))

# Plot full lag results of optimal version
pdf(paste0(cause.model.exploration.folder,cause,'_tmean_var1.lag6.pdf'),paper='a4r',height=0,width=0)
plot_dlnm_master(cb.temp.var1.lag6,mod.freq.dnlm.var1.lag6)
dev.off()
