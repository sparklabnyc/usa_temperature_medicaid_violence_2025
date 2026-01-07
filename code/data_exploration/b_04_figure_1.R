# RUN ON HARVARD FASSE

# Load packages and file locations etc.
rm(list=ls())
project.folder = paste0(print(here::here()),'/')
source(paste0(project.folder,'create_folder_structure.R'))
source(paste0(functions.folder,'script_initiate.R'))

# Load data preparation functions
source(paste0(functions.folder,'data_prep_functions.R'))

# Load packages
library(dlnm)
library(dplyr)
library(ggplot2)
library(lubridate)
library(splines)
library(stringr)
library(survival)
library(tidyr)

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
  filter(lag=='lag0')

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
  filter(lag=='lag0')

# total data
dat_total = rbind(dat.assault,dat.suicide)

# tidy data for plotting
dat_total = dat_total %>%  
  dplyr::select(year, date, sex, age, diagnosis) %>%
  dplyr::mutate(agegroup = ifelse(age<0,'<0 years (?)',
                                  ifelse(age<25,'0-24 years',
                                         ifelse(age<45,'25-44 years',
                                                ifelse(age<65,'45-64 years',
                                                       '65+ years'))))) %>%
  rename(Year=year,Sex=sex,'Age group'=agegroup) %>%
  mutate(Sex=recode_factor(Sex, 
                           'F'='Female',
                           'M'='Male')) %>%
  mutate('Age group'=recode_factor(`Age group`, 
                                   `<0 years (?)`='<0 years (?)',
                                   `0-24 years`='0-24 years',
                                   `25-44 years`='25-44 years',
                                   `45-64 years`='45-64 years',
                                   `65+ years`='65+ years')) %>%
  mutate(diagnosis=case_when(
    diagnosis == "assault" ~ "Interpersonal",
    diagnosis == "suicide" ~ "Self-inflicted",
    TRUE ~ NA_character_
  ))

# summarise data
dat_total_summarised = dat_total %>%
  group_by(diagnosis,Year,Sex,`Age group`) %>%
  tally()

# Plot by year, age group, and sex
p = ggplot(data=dat_total_summarised) +
  geom_bar(aes(x=Year, y=n,fill=Sex),position="stack", stat="identity") + 
  xlab('Year') + ylab('Hospitalizations') +
  scale_fill_manual(values=colors.sex, guide = guide_legend(nrow = 1,title = paste0(""))) +
  facet_grid(diagnosis~`Age group`,scales="free") +
  theme_bw() + theme(text = element_text(size = 18),legend.text=element_text(size=12),
                     panel.grid.major = element_blank(),axis.text.x = element_text(angle=0), axis.text.y = element_text(size=10),
                     plot.margin=grid::unit(c(0,0,0,0), "mm"),
                     plot.title = element_text(hjust = 0.5), panel.background = element_blank(),
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
                     panel.border = element_rect(colour = "black"),strip.background = element_blank(),
                     legend.position = 'bottom',legend.justification='center',
                     legend.background = element_rect(fill="white", size=.5, linetype="dotted"))

pdf(paste0(figure1.folder,'figure1.pdf'),paper='a4r',height=0,width=0)
print(p)
dev.off()