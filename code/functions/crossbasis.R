print('Forming crossbasis')

#### TEMPERATURE ####

# crossbasis for all data together
exp_matrix = dat.complete %>%
  select(contains("lag"))

cb.temp = crossbasis_form(exp_matrix,df_var_opt,df_lag_opt)

# crossbasis for females and males separately
exp_matrix.females = dat.complete.females %>%
  select(contains("lag"))
exp_matrix.males = dat.complete.males %>%
  select(contains("lag"))

cb.temp.females = crossbasis_form(exp_matrix.females,df_var_opt,df_lag_opt)
cb.temp.males = crossbasis_form(exp_matrix.males,df_var_opt,df_lag_opt)

# crossbasis for 0-64 years and 65+ years separately
exp_matrix.0 = dat.complete.0 %>%
  select(contains("lag"))
exp_matrix.65 = dat.complete.65 %>%
  select(contains("lag"))

cb.temp.0 = crossbasis_form(exp_matrix.0,df_var_opt,df_lag_opt)
cb.temp.65 = crossbasis_form(exp_matrix.65,df_var_opt,df_lag_opt)

# crossbasis for 0-24, 25-44, 45-64 years separately
exp_matrix.0.24 = dat.complete.0.24 %>%
  select(contains("lag"))
exp_matrix.25.44 = dat.complete.25.44 %>%
  select(contains("lag"))
exp_matrix.45.64 = dat.complete.45.64 %>%
  select(contains("lag"))

cb.temp.0.24 = crossbasis_form(exp_matrix.0.24,df_var_opt,df_lag_opt)
cb.temp.25.44 = crossbasis_form(exp_matrix.25.44,df_var_opt,df_lag_opt)
cb.temp.45.64 = crossbasis_form(exp_matrix.45.64,df_var_opt,df_lag_opt)

# crossbasis by sex AND age
exp_matrix.females.0 = dat.complete.females.0 %>%
  select(contains("lag"))
exp_matrix.males.0 = dat.complete.males.0 %>%
  select(contains("lag"))
exp_matrix.females.65 = dat.complete.females.65 %>%
  select(contains("lag"))
exp_matrix.males.65 = dat.complete.males.65 %>%
  select(contains("lag"))

cb.temp.females.0 = crossbasis_form(exp_matrix.females.0,df_var_opt,df_lag_opt)
cb.temp.males.0 = crossbasis_form(exp_matrix.males.0,df_var_opt,df_lag_opt)
cb.temp.females.65 = crossbasis_form(exp_matrix.females.65,df_var_opt,df_lag_opt)
cb.temp.males.65 = crossbasis_form(exp_matrix.males.65,df_var_opt,df_lag_opt)

# crossbasis by by climate region
exp_matrix.northeast = dat.complete.northeast %>%
  select(contains("lag"))
exp_matrix.northern.rockies.and.plains = dat.complete.northern.rockies.and.plains %>%
  select(contains("lag"))
exp_matrix.northwest = dat.complete.northwest %>%
  select(contains("lag"))
exp_matrix.ohio.valley = dat.complete.ohio.valley %>%
  select(contains("lag"))
exp_matrix.south = dat.complete.south %>%
  select(contains("lag"))
exp_matrix.southeast = dat.complete.southeast %>%
  select(contains("lag"))
exp_matrix.southwest = dat.complete.southwest %>%
  select(contains("lag"))
exp_matrix.upper.midwest = dat.complete.upper.midwest %>%
  select(contains("lag"))
exp_matrix.west = dat.complete.west %>%
  select(contains("lag"))

cb.temp.northeast = crossbasis_form(exp_matrix.northeast,df_var_opt,df_lag_opt)
cb.temp.northern.rockies.and.plains = crossbasis_form(exp_matrix.northern.rockies.and.plains,df_var_opt,df_lag_opt)
cb.temp.northwest = crossbasis_form(exp_matrix.northwest,df_var_opt,df_lag_opt)
cb.temp.ohio.valley = crossbasis_form(exp_matrix.ohio.valley,df_var_opt,df_lag_opt)
cb.temp.south = crossbasis_form(exp_matrix.south,df_var_opt,df_lag_opt)
cb.temp.southeast = crossbasis_form(exp_matrix.southeast,df_var_opt,df_lag_opt)
cb.temp.southwest = crossbasis_form(exp_matrix.southwest,df_var_opt,df_lag_opt)
cb.temp.upper.midwest = crossbasis_form(exp_matrix.upper.midwest,df_var_opt,df_lag_opt)
cb.temp.west = crossbasis_form(exp_matrix.west,df_var_opt,df_lag_opt)

# crossbasis by SES
exp_matrix.poverty.1 = dat.complete.poverty.1 %>%
  select(contains("lag"))
exp_matrix.poverty.2 = dat.complete.poverty.2 %>%
  select(contains("lag"))
exp_matrix.poverty.3 = dat.complete.poverty.3 %>%
  select(contains("lag"))
exp_matrix.poverty.4 = dat.complete.poverty.4 %>%
  select(contains("lag"))
exp_matrix.poverty.5 = dat.complete.poverty.5 %>%
  select(contains("lag"))

cb.temp.poverty.1 = crossbasis_form(exp_matrix.poverty.1,df_var_opt,df_lag_opt)
cb.temp.poverty.2 = crossbasis_form(exp_matrix.poverty.2,df_var_opt,df_lag_opt)
cb.temp.poverty.3 = crossbasis_form(exp_matrix.poverty.3,df_var_opt,df_lag_opt)
cb.temp.poverty.4 = crossbasis_form(exp_matrix.poverty.4,df_var_opt,df_lag_opt)
cb.temp.poverty.5 = crossbasis_form(exp_matrix.poverty.5,df_var_opt,df_lag_opt)

exp_matrix.education.1 = dat.complete.education.1 %>%
  select(contains("lag"))
exp_matrix.education.2 = dat.complete.education.2 %>%
  select(contains("lag"))
exp_matrix.education.3 = dat.complete.education.3 %>%
  select(contains("lag"))
exp_matrix.education.4 = dat.complete.education.4 %>%
  select(contains("lag"))
exp_matrix.education.5 = dat.complete.education.5 %>%
  select(contains("lag"))

cb.temp.education.1 = crossbasis_form(exp_matrix.education.1,df_var_opt,df_lag_opt)
cb.temp.education.2 = crossbasis_form(exp_matrix.education.2,df_var_opt,df_lag_opt)
cb.temp.education.3 = crossbasis_form(exp_matrix.education.3,df_var_opt,df_lag_opt)
cb.temp.education.4 = crossbasis_form(exp_matrix.education.4,df_var_opt,df_lag_opt)
cb.temp.education.5 = crossbasis_form(exp_matrix.education.5,df_var_opt,df_lag_opt)

exp_matrix.nonwhite.1 = dat.complete.nonwhite.1 %>%
  select(contains("lag"))
exp_matrix.nonwhite.2 = dat.complete.nonwhite.2 %>%
  select(contains("lag"))
exp_matrix.nonwhite.3 = dat.complete.nonwhite.3 %>%
  select(contains("lag"))
exp_matrix.nonwhite.4 = dat.complete.nonwhite.4 %>%
  select(contains("lag"))
exp_matrix.nonwhite.5 = dat.complete.nonwhite.5 %>%
  select(contains("lag"))

cb.temp.nonwhite.1 = crossbasis_form(exp_matrix.nonwhite.1,df_var_opt,df_lag_opt)
cb.temp.nonwhite.2 = crossbasis_form(exp_matrix.nonwhite.2,df_var_opt,df_lag_opt)
cb.temp.nonwhite.3 = crossbasis_form(exp_matrix.nonwhite.3,df_var_opt,df_lag_opt)
cb.temp.nonwhite.4 = crossbasis_form(exp_matrix.nonwhite.4,df_var_opt,df_lag_opt)
cb.temp.nonwhite.5 = crossbasis_form(exp_matrix.nonwhite.5,df_var_opt,df_lag_opt)

# crossbasis for interaction between non-white and poverty for most non-white and least non-white

exp_matrix.nonwhite.1.poverty.1 = dat.complete.nonwhite.1.poverty.1 %>%
  select(contains("lag"))
exp_matrix.nonwhite.1.poverty.2 = dat.complete.nonwhite.1.poverty.2 %>%
  select(contains("lag"))
exp_matrix.nonwhite.1.poverty.3 = dat.complete.nonwhite.1.poverty.3 %>%
  select(contains("lag"))
exp_matrix.nonwhite.1.poverty.4 = dat.complete.nonwhite.1.poverty.4 %>%
  select(contains("lag"))
exp_matrix.nonwhite.1.poverty.5 = dat.complete.nonwhite.1.poverty.5 %>%
  select(contains("lag"))

cb.temp.nonwhite.1.poverty.1 = crossbasis_form(exp_matrix.nonwhite.1.poverty.1,df_var_opt,df_lag_opt)
cb.temp.nonwhite.1.poverty.2 = crossbasis_form(exp_matrix.nonwhite.1.poverty.2,df_var_opt,df_lag_opt)
cb.temp.nonwhite.1.poverty.3 = crossbasis_form(exp_matrix.nonwhite.1.poverty.3,df_var_opt,df_lag_opt)
cb.temp.nonwhite.1.poverty.4 = crossbasis_form(exp_matrix.nonwhite.1.poverty.4,df_var_opt,df_lag_opt)
cb.temp.nonwhite.1.poverty.5 = crossbasis_form(exp_matrix.nonwhite.1.poverty.5,df_var_opt,df_lag_opt)

exp_matrix.nonwhite.5.poverty.1 = dat.complete.nonwhite.5.poverty.1 %>%
  select(contains("lag"))
exp_matrix.nonwhite.5.poverty.2 = dat.complete.nonwhite.5.poverty.2 %>%
  select(contains("lag"))
exp_matrix.nonwhite.5.poverty.3 = dat.complete.nonwhite.5.poverty.3 %>%
  select(contains("lag"))
exp_matrix.nonwhite.5.poverty.4 = dat.complete.nonwhite.5.poverty.4 %>%
  select(contains("lag"))
exp_matrix.nonwhite.5.poverty.5 = dat.complete.nonwhite.5.poverty.5 %>%
  select(contains("lag"))

cb.temp.nonwhite.5.poverty.1 = crossbasis_form(exp_matrix.nonwhite.5.poverty.1,df_var_opt,df_lag_opt)
cb.temp.nonwhite.5.poverty.2 = crossbasis_form(exp_matrix.nonwhite.5.poverty.2,df_var_opt,df_lag_opt)
cb.temp.nonwhite.5.poverty.3 = crossbasis_form(exp_matrix.nonwhite.5.poverty.3,df_var_opt,df_lag_opt)
cb.temp.nonwhite.5.poverty.4 = crossbasis_form(exp_matrix.nonwhite.5.poverty.4,df_var_opt,df_lag_opt)
cb.temp.nonwhite.5.poverty.5 = crossbasis_form(exp_matrix.nonwhite.5.poverty.5,df_var_opt,df_lag_opt)

#### RELATIVE HUMIDITY #### 

if(exposure=='tmean'){
  # crossbasis for all data together
  exp_matrix.rh = dat.complete.sensitivity %>%
    select(contains("RH"))

  cb.rh = crossbasis_form(exp_matrix.rh,df_var_opt,df_lag_opt)
}

