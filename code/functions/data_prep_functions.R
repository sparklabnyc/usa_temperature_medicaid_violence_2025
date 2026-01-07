# DATA PREPARATION FUNCTIONS

####################################################################
# Functions for loading hospitalization data
####################################################################

# load cause of hospitalization
load_cause = function(cause){
  
  print(paste0('Loading ',cause, ' hospitalizations'))
  
  if(cause=="All_violence"){
    dat.all = readRDS(paste0(allviolence.folder,'hostile_diag_',years_analysis[1],'_',years_analysis[length(years_analysis)],'.rds'))
  }
  if(cause=="assault"){
    dat.all = readRDS(paste0(assault.folder,'hostile_diag_',years_analysis[1],'_',years_analysis[length(years_analysis)],'.rds'))
  }
  if(cause=="suicide"){
    dat.all = readRDS(paste0(suicide.folder,'hostile_diag_',years_analysis[1],'_',years_analysis[length(years_analysis)],'.rds'))
  }
  
  print(paste0('Total records: ', nrow(dat.all)))
  
  dat = dat.all %>%
    mutate(sex=case_when(
      sex =='F' ~ 'F',
      sex =='M' ~ 'M',
      sex =='F,U' ~ 'F',
      sex =='M,U' ~ 'M',
      TRUE ~ "U")) %>%
    dplyr::filter(sex%in%c('F','M')) %>% # remove unknown sex
    drop_na(age) %>% # remove unknown age
    dplyr::filter(age>=0) %>% # remove negative ages
    drop_na(admission_date) %>% # remove unknown date
    mutate(zip=as.integer(zip)) %>% # make zip code into numeric
    dplyr::mutate(diagnosis=cause) %>% # assign cause to be the chosen one
    dplyr::mutate(date=ymd(admission_date)) %>% # convert date to a date format
    dplyr::arrange(zip,date) %>%
    dplyr::mutate(nr=1:n()) %>% # number from 1 to n for case control later
    dplyr::select(nr,zip,year,date,sex,age,diagnosis) # select on certain columns
  
  return(dat)
}

# load zcta cross-walk
load_zip_crosswalk = function(){
  dat_zip_to_zcta = read.csv(paste0(ziplookup.folder,'Zip_to_ZCTA_crosswalk_2015_JSI.csv')) %>%
    dplyr::select(ZIP,ZCTA) %>%
    dplyr::rename(zip=ZIP,zcta=ZCTA)
  
  return(dat_zip_to_zcta)
}

# merge and process for model input
merge_hosp_crosswalk = function(){
  dat = left_join(dat,dat_zip_to_zcta,by='zip') %>%
    drop_na(zcta)
  
  print(paste0('Complete records: ', nrow(dat)))
  
  return(dat)
}

# load case control data
load_case_control_data = function(cause_selected){
  
  # loop through  all years
  print('Loading case control data')
  casecontrol.cause.folder = paste0(casecontrol.folder,cause,'/')
  dat = data.frame()
  
  # special case for suicides as no records in 1996, 1997 for some reason
  if(cause_selected=='Suicide and intentional self-inflicted injury'){years_analysis = c(1998:2014)}
  
  for(year_current in years_analysis){
    dat.temp = readRDS(paste0(casecontrol.cause.folder,cause,'_case_control_',year_current,'.rds'))
    dat = data.table::rbindlist(list(dat,dat.temp))
  }
  print('Loaded case control data')
  return(dat)
}

# load case control data with lagged dates
load_case_control_lag_data = function(cause_selected){
  
  # loop through  all years
  print('Loading case control lag data')
  casecontrol.cause.folder = paste0(casecontrol.lag.folder,cause,'/')
  dat = data.frame()
  
  # special case for suicides as no records in 1996, 1997 for some reason
  if(cause_selected=='Suicide and intentional self-inflicted injury'){years_analysis = c(1998:2014)}
  
  for(year_current in years_analysis){
    dat.temp = readRDS(paste0(casecontrol.cause.folder,cause,'_case_control_lag_',year_current,'.rds'))
    dat = data.table::rbindlist(list(dat,dat.temp))
  }
  print('Loaded case control lag data')
  return(dat)
}

# load case control temperature data and summarise by month
load_case_control_lag_temperature_data=function(cause){
  casecontrol.lag.temperature.cause.folder = paste0(casecontrol.lag.temperature.folder,cause,'/')
  
  dat.complete = readRDS(paste0(casecontrol.lag.temperature.cause.folder,cause,'_case_control_lag_temperature_',years_analysis[1],'_',years_analysis[length(years_analysis)],'.rds')) %>%
    mutate(lag=str_replace(lag, "-","lag")) %>%
    mutate(lag=str_replace(lag,"0","lag0")) %>%
    dplyr::filter(lag=='lag0',ck==1) %>% 
    mutate(month=as.Date(cut(date,breaks = "month"))) %>%
    mutate(agegroup = ifelse(agegroup<65,'0-64 years','65+ years')) %>%
    mutate(sex = ifelse(SEX=='M','Males','Females')) %>%
    mutate(nyc = ifelse(zcta%in%nyc.zctas,'NYC','Not NYC')) %>%
    group_by(agegroup, sex, month, nyc) %>% 
    tally() %>%
    mutate(cause=cause)
}

# load case control temperature data match to selected comorbidities data
load_case_control_lag_temperature_analyse_comorbidities_data=function(cause){
  casecontrol.lag.temperature.cause.folder = paste0(casecontrol.lag.temperature.folder,cause,'/')
  
  dat.complete = readRDS(paste0(casecontrol.lag.temperature.cause.folder,cause,'_case_control_lag_temperature_',years_analysis[1],'_',years_analysis[length(years_analysis)],'.rds')) %>%
    mutate(lag=str_replace(lag, "-","lag")) %>%
    mutate(lag=str_replace(lag,"0","lag0")) %>%
    dplyr::filter(lag=='lag0',ck==1)
  
  # merge file with cause of hospitalization for cardiovascular diseases
  for(i in c('01','02','03','04')){
    current = as.character(paste0("DX",i))
    current_col = dat.complete %>% select(current)
    names(current_col) = 'ICD9'
    dat.complete = cbind(dat.complete,current_col)
    dat.complete = left_join(dat.complete,subset(code_lookup,cause_overall=='Diseases of the circulatory system'), by="ICD9")
    colnames(dat.complete)[colnames(dat.complete) == "cause"] = paste0('cardio_cause',i)
    dat.complete$ICD9 = dat.complete$cause_overall = NULL
  }
  
  # merge file with cause of hospitalization for respiratory diseases
  for(i in c('01','02','03','04')){
    current = as.character(paste0("DX",i))
    current_col = dat.complete %>% select(current)
    names(current_col) = 'ICD9'
    dat.complete = cbind(dat.complete,current_col)
    dat.complete = left_join(dat.complete,subset(code_lookup,cause_overall=='Diseases of the respiratory system'), by="ICD9")
    colnames(dat.complete)[colnames(dat.complete) == "cause"] = paste0('resp_cause',i)
    dat.complete$ICD9 = dat.complete$cause_overall = NULL
  }
  
  # find out how many causes per row in total and how many are cardio- and resp-related
  dat.complete$no_cardio_causes = rowSums( !is.na( dat.complete [,c(paste0('cardio_cause',c('01','02','03','04')))]))
  dat.complete$no_resp_causes = rowSums( !is.na( dat.complete [,c(paste0('resp_cause',c('01','02','03','04')))]))
  
  # check whether selected specific sub-causes of cardio-related diseases are co-morbidities
  for(i in cardio_subcauses){
    # check if in primary, secondary, or both primary and secondary
    name = paste0(i,'_check')
    dat.complete[[name]] = ifelse(rowSums(dat.complete[,c(paste0('cardio_cause',c('01','02','03','04')))] == i, na.rm=TRUE)>0, 1,0)
  }
  
  # check whether selected specific sub-causes of resp-related diseases are co-morbidities
  for(i in resp_subcauses){
    # check if in primary, secondary, or both primary and secondary
    name = paste0(i,'_check')
    dat.complete[[name]] = ifelse(rowSums(dat.complete[,c(paste0('resp_cause',c('01','02','03','04')))] == i, na.rm=TRUE)>0, 1,0)
  }
  
  dat.complete = dat.complete %>%
    mutate(month=as.Date(cut(date,breaks = "month"))) %>%
    mutate(agegroup = ifelse(agegroup<65,'0-64 years','65+ years')) %>%
    mutate(sex = ifelse(SEX=='M','Males','Females')) %>%
    mutate(nyc = ifelse(zcta%in%nyc.zctas,'NYC','Not NYC')) %>%
    mutate(no_cardio_causes=ifelse(no_cardio_causes==0,'0','1 or more')) %>%
    mutate(no_resp_causes=ifelse(no_resp_causes==0,'0','1 or more')) %>%
    group_by(agegroup, sex, month, nyc, no_cardio_causes, no_resp_causes) %>% 
    tally() %>%
    mutate(cause=cause)
  
}

# load for table 1 processing
table_1_process = function(cause){
  casecontrol.lag.temperature.cause.folder = paste0(casecontrol.lag.temperature.folder,cause,'/')
  dat.complete = readRDS(paste0(casecontrol.lag.temperature.cause.folder,cause,'_case_control_lag_temperature_',years_analysis[1],'_',years_analysis[length(years_analysis)],'.rds')) %>%
    mutate(lag=str_replace(lag, "-","lag")) %>%
    mutate(lag=str_replace(lag,"0","lag0")) %>%
    dplyr::filter(lag=='lag0',ck==1) %>%
    # mutate(agegroup = ifelse(agegroup<65,'0-64 years','65+ years')) %>%
    mutate(agegroup = ifelse(agegroup<25,'0-24 years',
                             ifelse(agegroup<45,'25-44 years',
                                    ifelse(agegroup<65,'45-64 years',
                                           '65+ years')))) %>%
    mutate(sex = ifelse(SEX=='M','Males','Females')) %>%
    mutate(nyc = ifelse(zcta%in%nyc.zctas,'NYC','Not NYC')) %>%
    mutate(cause = cause)
  
  return(dat.complete)
}

# load for table 1 processing
figure_1_process = function(cause){
  casecontrol.lag.temperature.cause.folder = paste0(casecontrol.lag.temperature.folder,cause,'/')
  dat.complete = readRDS(paste0(casecontrol.lag.temperature.cause.folder,cause,'_case_control_lag_temperature_',years_analysis[1],'_',years_analysis[length(years_analysis)],'.rds')) %>%
    mutate(lag=str_replace(lag, "-","lag")) %>%
    mutate(lag=str_replace(lag,"0","lag0")) %>%
    dplyr::filter(lag=='lag0',ck==1) %>%
    group_by(zcta) %>%
    tally() %>%
    mutate(cause = cause)
  
  return(dat.complete)
}
####################################################################
# Functions for creating control days
####################################################################

# function create control days from case day
make_control_day = function(data, BeforeAfter, WK){ 
  
  # The name of the day; accounts for if control or case
  VarName = paste0(BeforeAfter, '_', str_trunc(WK, 1, 'left', ''))
  
  # adds WKs number of weeks
  data = data %>% mutate(!!VarName := date + as.period(7 * WK, 'day'))  
}

# function to create control days
create_control_days_by_year = function(df.year){
  
  year_current = unique(df.year$year)
  print(paste0('processing case control for ', year_current))
  print(paste0('Total records: ', nrow(df.year)))
  
  # use function above to create bidirectionally symmetric dates 
  days1 = df.year
  days1 = make_control_day(days1, 'Before', -4)
  days1 = make_control_day(days1, 'Before', -3)
  days1 = make_control_day(days1, 'Before', -2)
  days1 = make_control_day(days1, 'Before', -1)
  days1 = make_control_day(days1, 'CaseDay', 0)
  days1 = make_control_day(days1, 'After', 1)
  days1 = make_control_day(days1, 'After', 2)
  days1 = make_control_day(days1, 'After', 3)
  days1 = make_control_day(days1, 'After', 4)
  
  # put in long format by Day
  days2 = days1 %>% 
    gather('DayName', 'date_control', contains('CaseDay_'),
           contains('Before_'), contains('After_') ) 
  
  # stratify by month of event 
  days3 = days2 %>% filter(month(date) == month(date_control))
  
  # case/control marker
  days3 = days3 %>%
    mutate(ck = if_else(DayName=='CaseDay_0', 1, 0))
  
  print(paste0('Processed records: ', nrow(days3 %>% dplyr::filter(ck==1))))
  
  # output results
  casecontrol.cause.folder = paste0(casecontrol.folder,cause,'/')
  ifelse(!dir.exists(casecontrol.cause.folder), dir.create(casecontrol.cause.folder), FALSE)
  saveRDS(days3, paste0(casecontrol.cause.folder,cause,'_case_control_',year_current,'.rds'))
}

####################################################################
# Functions for creating lag days 
####################################################################

# create lag days from case/control day
make_lag_day = function(data, lag){
  
  # adds lag to date of interest
  data = data %>% mutate(!!lag := date_control + as.period(as.numeric(lag), 'day'))  
}

# function to create lag days
create_lag_days_by_year = function(df.year){
  
  year_current = unique(df.year$year)
  print(paste0('processing lag days for ', year_current))
  
  # use function above to create bidirectionally symmetric dates 
  days1 = df.year
  days1 = make_lag_day(days1, '-6')
  days1 = make_lag_day(days1, '-5')
  days1 = make_lag_day(days1, '-4')
  days1 = make_lag_day(days1, '-3')
  days1 = make_lag_day(days1, '-2')
  days1 = make_lag_day(days1, '-1')
  days1 = make_lag_day(days1, '0')
  
  # put in long format by Day
  days2 = days1 %>% 
    gather('lag', 'date_lag', c(`-6`,`-5`,`-4`,`-3`,`-2`,`-1`,`0`)) %>%
    mutate(lag=as.numeric(lag)) %>%
    arrange(nr,desc(ck),DayName,desc(lag))
  
  # output results
  casecontrol.cause.lag.folder = paste0(casecontrol.lag.folder,cause,'/')
  ifelse(!dir.exists(casecontrol.cause.lag.folder), dir.create(casecontrol.cause.lag.folder,recursive=TRUE), FALSE)
  saveRDS(days2, paste0(casecontrol.cause.lag.folder,cause,'_case_control_lag_',year_current,'.rds'))
}

####################################################################
# Functions for creating colors for plotting
####################################################################

# useful general color scheme
f = function(pal) brewer.pal(brewer.pal.info[pal, "maxcolors"], pal)
mycols = c(f("Dark2"), f("Set1")[1:8], f("Set2"),
            f("Set3"),"#89C5DA", "#DA5724", "#74D944", "#CE50CA", "#3F4921",
            "#C0717C", "#CBD588", "#5F7FC7", "#673770", "#D3D93E",
            "#38333E", "#508578", "#D7C1B1", "#689030", "#AD6F3B",
            "#CD9BCD", "#D14285", "#6DDE88", "#652926", "#7FDCC0",
            "#C84248", "#8569D5", "#5E738F", "#D1A33D", "#8A7C64",
            "#599861" )
            #to make picking the number of the colour you want easier:
# plot(1:length(mycols),col=mycols[1:length(mycols)],cex=4,pch=20); abline(v=c(10,20,30,40,50,60))

# colors for CCS Level 1 causes of death
color.lags = mycols[c( 62,  # Lag 0
                        48,  # Lag 1
                        57,  # Lag 2
                        40,  # Lag 3
                        12,  # Lag 4
                        30,  # Lag 5
                        1)]  # Lag 6

####################################################################
# DLNM-SPECIFIC FUNCTIONS
####################################################################

crossbasis_form = function(exp,df_var,df_lag){
  cb.temp = crossbasis(exp,
                        lag=c(0,6),
                        argvar=list(fun = "ns", df = df_var),
                        arglag=list(fun = "ns", df = df_lag))
}

#### FREQUENTIST PROCESSING AND PLOTTING DLNM ####

plot_dlnm_master = function(cb,mod){
  pred =  pred_nonlin(cb,mod)
  plot_3d_dlnm(pred)
  plot_lags_dlnm(pred,0,1)
  plot_lags_dlnm(pred,2,3)
  plot_lags_dlnm(pred,4,6)
  plot_cumulative_dlnm(pred)
}

# predict from dnlm model
pred_nonlin = function(cb, mod,temp=temp_mean){
  result = crosspred(cb,mod,cen=temp,by=1) 
}

# 3-D plot of dlnm
plot_3d_dlnm = function(pred){
  plot(pred, zlab="OR", xlab="Temperature (C)", ylab="Lag (days)",
       main=expression("3D graph of temperature association"),
       theta=40, phi=30, lphi=30)
}

# Plot exposure-response for all lags
plot_lags_dlnm = function(pred,lag_start,lag_end){
  plot(pred, "slices", lag=c(lag_start:lag_end), col=2, ci.arg=list(density=40,col=grey(0.7)))
}

# Plot cumulative association
plot_cumulative_dlnm = function(pred){
  name = deparse(substitute(pred))
  plot(pred, "overall", col=2, xlab = "Temperature (C)", ylab="Cumulative OR",
       main=paste0("Overall cumulative association: ",name))
}

# Plot cumulative association as part of several to compare
plot_cumulative_dlnm_multi = function(cb,mod,temp=temp_mean,xlab="Temperature (C)",add=0,col_sel=1){
  pred =  pred_nonlin(cb,mod,temp)
  name = deparse(substitute(mod))
  if(add==0){
    plot(pred, "overall", col=2, xlab = xlab, ylab="Cumulative OR",
         main=name)
  }
  if(add==1){
    lines(pred, "overall", col=col_sel)
  }
  
}

#### BAYESIAN PROCESSING AND PLOTTING DLNM ####

pred_nonlin_bayesian =function(cb, model){
  
  # extract full coef and vcov and create indicators for each term
  coef = model$summary.fixed$mean
  vcov = model$misc$lincomb.derived.covariance.matrix
  
  # find position of the terms associated with temperature crossbasis
  indt = grep("v", model$names.fixed)
  
  # extract predictions from the DLNM centred on temp_mean
  result = crosspred(cb,
                     coef = coef[indt], vcov=vcov[indt,indt], cumul=TRUE,
                     model.link = "logit", bylag = 0.25, cen = temp_mean) 
}

# function to process Bayesian results
# Plot cumulative association as part of several to compare
plot_cumulative_dlnm_multi_bayesian = function(cb,mod){
  pred =  pred_nonlin_bayesian(cb,mod)
  name = deparse(substitute(mod))
  plot(pred, "overall", col=2, xlab = "Temperature (C)", ylab="Cumulative OR",
       main=name)
}

####################################################################
# Functions for processing results
####################################################################

# process model results using variance-covariance matrices and obtain results at important temperature intervals
process_results_percentiles = function(analysis,cause_set=0){
  
  # dummy data frame to load results that we loop through into
  dat.results = data.frame()
  # go through each included cause and process
  if(cause_set==0){causes_selected = c(causes,subcauses)}
  if(cause_set==1){causes_selected = causes_excluded}
  for(cause in causes_selected){
    print(cause)
    cause.model.folder = paste0(model.folder,cause,'/')
    mod.freq.dnlm = readRDS(paste0(cause.model.folder,cause,'_dlnm_results_',analysis,'_freq.rds'))
    if(!(analysis%in%c('main','rh_sensitivity'))){ cb.temp = readRDS(paste0(cause.model.folder,cause,'_dlnm_cb_',analysis,'_freq.rds'))}
    if(analysis%in%c('main','rh_sensitivity')){ cb.temp = readRDS(paste0(cause.model.folder,cause,'_dlnm_cb_temp_freq.rds'))}
    coeffs = coef(mod.freq.dnlm)
    vcovmatrix = Epi::ci.lin(mod.freq.dnlm, vcov=TRUE)$vcov
    indt = grep("temp", names(coeffs))
    result.temp = crosspred(cb.temp, coef=coeffs[indt], vcov=vcovmatrix[indt,indt],cen=temp_mean,at=temp_vals,cumul=TRUE)
    
    # estimate each of central and lower and upper bounds of effect estimates
    central.est = as.data.frame(result.temp$cumfit) %>%
      rownames_to_column("MeanT") %>%
      select(MeanT,lag6) %>%
      mutate(MeanT=as.numeric(MeanT)) %>%
      rename(central.est=lag6) %>%
      left_join(.,percentiles)
    
    ll.est = as.data.frame(result.temp$cumlow) %>%
      rownames_to_column("MeanT") %>%
      select(MeanT,lag6) %>%
      mutate(MeanT=as.numeric(MeanT)) %>%
      rename(ll.est=lag6) %>%
      left_join(.,percentiles)
    
    ul.est = as.data.frame(result.temp$cumhigh) %>%
      rownames_to_column("MeanT") %>%
      select(MeanT,lag6) %>%
      mutate(MeanT=as.numeric(MeanT)) %>%
      rename(ul.est=lag6) %>%
      left_join(.,percentiles)
    
    dat.results.temp = left_join(central.est,ll.est) %>%
      left_join(.,ul.est) %>%
      mutate(cause=cause) %>%
      select(cause,MeanT,Percentile,central.est,ll.est,ul.est)
    
    dat.results = rbind(dat.results,dat.results.temp)
  }
  
  dat.results = dat.results %>% mutate(analysis=analysis)
  
  return(dat.results)
}

# process model results using variance-covariance matrices and obtain results at important temperature intervals
process_results_percentiles_lag01 = function(analysis){
  
  # dummy data frame to load results that we loop through into
  dat.results = data.frame()
  # go through each included cause and process
  for(cause in c(causes,subcauses)){
    print(cause)
    cause.model.folder = paste0(model.folder,cause,'/')
    mod.freq.dnlm = readRDS(paste0(cause.model.folder,cause,'_dlnm_results_',analysis,'_freq.rds'))
    if(!(analysis%in%c('main','rh_sensitivity'))){ cb.temp = readRDS(paste0(cause.model.folder,cause,'_dlnm_cb_',analysis,'_freq.rds'))}
    if(analysis%in%c('main','rh_sensitivity')){ cb.temp = readRDS(paste0(cause.model.folder,cause,'_dlnm_cb_temp_freq.rds'))}
    coeffs = coef(mod.freq.dnlm)
    vcovmatrix = Epi::ci.lin(mod.freq.dnlm, vcov=TRUE)$vcov
    indt = grep("temp", names(coeffs))
    result.temp = crosspred(cb.temp, coef=coeffs[indt], vcov=vcovmatrix[indt,indt],cen=temp_mean,at=temp_vals,cumul=TRUE)
    
    # estimate each of central and lower and upper bounds of effect estimates
    central.est = as.data.frame(result.temp$cumfit) %>%
      rownames_to_column("MeanT") %>%
      select(MeanT,lag0) %>%
      mutate(MeanT=as.numeric(MeanT)) %>%
      rename(central.est=lag0) %>%
      left_join(.,percentiles)
    
    ll.est = as.data.frame(result.temp$cumlow) %>%
      rownames_to_column("MeanT") %>%
      select(MeanT,lag0) %>%
      mutate(MeanT=as.numeric(MeanT)) %>%
      rename(ll.est=lag0) %>%
      left_join(.,percentiles)
    
    ul.est = as.data.frame(result.temp$cumhigh) %>%
      rownames_to_column("MeanT") %>%
      select(MeanT,lag0) %>%
      mutate(MeanT=as.numeric(MeanT)) %>%
      rename(ul.est=lag0) %>%
      left_join(.,percentiles)
    
    dat.results.temp = left_join(central.est,ll.est) %>%
      left_join(.,ul.est) %>%
      mutate(cause=cause) %>%
      select(cause,MeanT,Percentile,central.est,ll.est,ul.est)
    
    dat.results = rbind(dat.results,dat.results.temp)
  }
  
  dat.results = dat.results %>% mutate(analysis=analysis)
  
  return(dat.results)
}

####################################################################
# ggplot plotting themes
####################################################################

# prepare map structure for plotting temperature
theme_map = function(base_size=15, base_family=""){
  require(grid)
  theme_bw(base_size=base_size,base_family=base_family) %+replace%
    theme(axis.line=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank(),
          axis.title=element_blank(),
          panel.background=element_blank(),
          panel.border=element_blank(),
          panel.grid=element_blank(),
          panel.margin=unit(0,"lines"),
          plot.background=element_blank(),
          # legend.justification = c(0,0),
          legend.position = 'bottom'
    )
}

####################################################################
# ggplot plotting functions
####################################################################

# Function to plot maps of NYS and NYC
plot_map_ny = function(data,nyc,fill,title,values=NULL,colors,breaks,limits,guide){
  # choose to focus on NYC only or not
  if(nyc==1){
    data = subset(data,ZCTA5CE10%in%nyc.zctas)
  }
  
  p = ggplot() +
    geom_polygon(data=data,aes(x=long,y=lat,group=group,fill=get(fill)),color='black',size=0.000001) +
    coord_fixed() + xlab('') + ylab('') +
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          axis.text.x = element_text(angle=90), axis.ticks.x=element_blank(),
          legend.text=element_text(size=20),panel.grid.minor = element_blank(), 
          axis.line = element_line(colour = "black"),panel.border = element_rect(colour = "white"),
          strip.background = element_blank(),legend.justification='center',
          legend.position = 'top', legend.background = element_rect(fill="white", size=.5, linetype="dotted")) +
    theme_map()
  
  # whether to use values or not
  if(is.null(values)==0){
    p = p +
      scale_fill_gradientn(values=values,colors=colors,breaks=breaks,limits=limits,guide = guide_legend(nrow = 1),labels=scales::comma)
  }
  if(is.null(values)==1){
    p = p +
      scale_fill_gradientn(colors=colors,breaks=breaks,limits=limits,guide = guide_legend(nrow = 1),labels=scales::comma)
  }
  
  # whether or not there's a color bar
  if(guide==0){
    p = p + guides(fill = FALSE)
  }
  if(guide==1){
    p = p +     guides(fill = guide_colorbar(direction = "horizontal", title.position="left",
                                             barwidth = 12, barheight = 1,title.vjust = 0.8,
                                             title =title,legend.text=element_text(size=8),
                                             labels=scales::comma))
  }
  
  return(p)
}
