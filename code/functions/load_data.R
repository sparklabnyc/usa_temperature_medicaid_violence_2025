print('Loading data')

# create output folders
cause.model.exploration.folder = paste0(model.exploration.folder,cause,'/')
ifelse(!dir.exists(cause.model.exploration.folder), dir.create(cause.model.exploration.folder, recursive=TRUE), FALSE)
cause.model.folder = paste0(model.folder,cause,'/')
ifelse(!dir.exists(cause.model.folder), dir.create(cause.model.folder, recursive=TRUE), FALSE)

# Load case crossover lagged data
casecontrol.lag.temperature.cause.folder = paste0(casecontrol.lag.temperature.folder,cause,'/')
dat.complete = readRDS(paste0(casecontrol.lag.temperature.cause.folder,cause,
                              '_case_control_lag_temperature_',years_analysis[1],
                              '_',year_analysis_end,'.rds')) %>%
  mutate(lag=str_replace(lag, "-","lag")) %>%
  mutate(lag=str_replace(lag,"0","lag0"))

dat.complete = dat.complete %>%
  filter(year%in%years_analysis)

# Relative Humidity data for making wide for tmean sensitivity
if(exposure=='tmean'){
  dat.rh = dat.complete %>%
    select(-date_lag, -tmean, -wbgtmax) %>%
    spread(lag, rhmean) %>%
    select(contains("lag"))
  
  names(dat.rh) = paste0('RH',names(dat.rh))
  names(dat.rh) = gsub("lag","",names(dat.rh))
}

# Make chosen exposure into wide table with lags wide
if(exposure=='tmean'){
dat.complete = dat.complete %>%
  select(-date_lag, -wbgtmax, -rhmean) %>%
  spread(lag, tmean) 
}
if(exposure=='wbgtmax'){
  dat.complete = dat.complete %>%
    select(-date_lag, -tmean, -rhmean) %>%
    spread(lag, wbgtmax) 
}

# re-combine relative humidity data for tmean sensitivity
if(exposure=='tmean'){
  dat.complete.sensitivity = cbind(dat.complete,dat.rh)
}

# Subset data by females and males
dat.complete.females = dat.complete %>%
  dplyr::filter(sex=='F')

dat.complete.males = dat.complete %>%
  dplyr::filter(sex=='M')

# Subset data by under 65s and over 65s
dat.complete.0 = dat.complete %>%
  dplyr::filter(age<=64)

dat.complete.65 = dat.complete %>%
  dplyr::filter(age>=65)

# Also subset data by 0-24, 25-44, 45-64 years
dat.complete.0.24 = dat.complete %>%
  dplyr::filter(age<=24)

dat.complete.25.44 = dat.complete %>%
  dplyr::filter(age>=25&age<=44)

dat.complete.45.64 = dat.complete %>%
  dplyr::filter(age>=45&age<=64)

# Subset data by sex AND age
dat.complete.females.0 = dat.complete %>%
  dplyr::filter(sex=='F') %>%
  dplyr::filter(age<=64)

dat.complete.males.0 = dat.complete %>%
  dplyr::filter(sex=='M') %>%
  dplyr::filter(age<=64)

dat.complete.females.65 = dat.complete %>%
  dplyr::filter(sex=='F') %>%
  dplyr::filter(age>=65)

dat.complete.males.65 = dat.complete %>%
  dplyr::filter(sex=='M') %>%
  dplyr::filter(age>=65)

# Subset data by climate region
dat_climate_region = read.csv(paste0(ziplookup.folder,'name_fips_lookup.csv')) %>%
  rename(STATE=code_name)
dat_zcta_to_state = read.csv(paste0(ziplookup.folder,'Zip_to_ZCTA_crosswalk_2015_JSI.csv')) %>%
  distinct(STATE, ZCTA) %>%
  left_join(.,dat_climate_region) %>%
  select(ZCTA,climate_region) %>%
  rename(zcta=ZCTA)

dat.complete.climate.region = dat.complete %>%
  left_join(.,dat_zcta_to_state)

dat.complete.northeast = dat.complete.climate.region %>%
  dplyr::filter(climate_region=="Northeast")

dat.complete.northern.rockies.and.plains = dat.complete.climate.region %>%
  dplyr::filter(climate_region=="Northern Rockies and Plains")

dat.complete.northwest = dat.complete.climate.region %>%
  dplyr::filter(climate_region=="Northwest")

dat.complete.ohio.valley = dat.complete.climate.region %>%
  dplyr::filter(climate_region=="Ohio Valley")

dat.complete.south = dat.complete.climate.region %>%
  dplyr::filter(climate_region=="South")

dat.complete.southeast = dat.complete.climate.region %>%
  dplyr::filter(climate_region=="Southeast")

dat.complete.southwest = dat.complete.climate.region %>%
  dplyr::filter(climate_region=="Southwest")

dat.complete.upper.midwest = dat.complete.climate.region %>%
  dplyr::filter(climate_region=="Upper Midwest")

dat.complete.west = dat.complete.climate.region %>%
  dplyr::filter(climate_region=="West")

# which zctas are in study?
zctas_included = dat.complete %>% pull(zcta) %>% unique()

# Subset data by SES
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

dat.complete.ses = dat.complete %>%
  left_join(.,dat.ses) %>%
  filter(is.na(poverty_quintile)==FALSE)

dat.complete.poverty = dat.complete.ses %>%
  split(.,dat.complete.ses$poverty_quintile)

dat.complete.poverty.1 = dat.complete.poverty[[1]]
dat.complete.poverty.2 = dat.complete.poverty[[2]]
dat.complete.poverty.3 = dat.complete.poverty[[3]]
dat.complete.poverty.4 = dat.complete.poverty[[4]]
dat.complete.poverty.5 = dat.complete.poverty[[5]]

dat.complete.education = dat.complete.ses %>%
  split(.,dat.complete.ses$education_quintile)

dat.complete.education.1 = dat.complete.education[[1]]
dat.complete.education.2 = dat.complete.education[[2]]
dat.complete.education.3 = dat.complete.education[[3]]
dat.complete.education.4 = dat.complete.education[[4]]
dat.complete.education.5 = dat.complete.education[[5]]

dat.complete.nonwhite = dat.complete.ses %>%
  split(.,dat.complete.ses$nonwhite_quintile)

dat.complete.nonwhite.1 = dat.complete.nonwhite[[1]]
dat.complete.nonwhite.2 = dat.complete.nonwhite[[2]]
dat.complete.nonwhite.3 = dat.complete.nonwhite[[3]]
dat.complete.nonwhite.4 = dat.complete.nonwhite[[4]]
dat.complete.nonwhite.5 = dat.complete.nonwhite[[5]]

# interaction between non-white and poverty for most non-white and least non-white

dat.complete.nonwhite.1.poverty = dat.complete.nonwhite.1 %>%
  split(.,dat.complete.nonwhite.1$poverty_quintile)

dat.complete.nonwhite.1.poverty.1 = dat.complete.nonwhite.1.poverty[[1]]
dat.complete.nonwhite.1.poverty.2 = dat.complete.nonwhite.1.poverty[[2]]
dat.complete.nonwhite.1.poverty.3 = dat.complete.nonwhite.1.poverty[[3]]
dat.complete.nonwhite.1.poverty.4 = dat.complete.nonwhite.1.poverty[[4]]
dat.complete.nonwhite.1.poverty.5 = dat.complete.nonwhite.1.poverty[[5]]

dat.complete.nonwhite.5.poverty = dat.complete.nonwhite.5 %>%
  split(.,dat.complete.nonwhite.5$poverty_quintile)

dat.complete.nonwhite.5.poverty.1 = dat.complete.nonwhite.5.poverty[[1]]
dat.complete.nonwhite.5.poverty.2 = dat.complete.nonwhite.5.poverty[[2]]
dat.complete.nonwhite.5.poverty.3 = dat.complete.nonwhite.5.poverty[[3]]
dat.complete.nonwhite.5.poverty.4 = dat.complete.nonwhite.5.poverty[[4]]
dat.complete.nonwhite.5.poverty.5 = dat.complete.nonwhite.5.poverty[[5]]

# Temperature summaries
temp_mean = dat.complete %>%
  filter(is.na(lag0)==FALSE) %>%
  summarise(mean(lag0)) %>%
  as.numeric

temp_min = dat.complete %>%
  filter(is.na(lag0)==FALSE) %>%
  summarise(min(lag0)) %>%
  as.numeric

temp_max = dat.complete %>%
  filter(is.na(lag0)==FALSE) %>%
  summarise(max(lag0)) %>%
  as.numeric

temp_seq=seq(from=temp_min, to=temp_max,length.out = 200)
temp_data = data.frame(`lag0`=temp_seq, nr=1)