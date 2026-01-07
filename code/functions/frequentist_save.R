print('Saving models')

# all together
saveRDS(mod.freq.dnlm, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_main_freq',save_suffix))
saveRDS(cb.temp, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_temp_freq',save_suffix))

# females and males separately
saveRDS(mod.freq.dnlm.females, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_females_freq',save_suffix))
saveRDS(cb.temp.females, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_females_freq',save_suffix))

saveRDS(mod.freq.dnlm.males, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_males_freq',save_suffix))
saveRDS(cb.temp.males, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_males_freq',save_suffix))

# 0-64 years and 65+ years separately
saveRDS(mod.freq.dnlm.0, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_0_freq',save_suffix))
saveRDS(cb.temp.0, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_0_freq',save_suffix))

saveRDS(mod.freq.dnlm.65, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_65_freq',save_suffix))
saveRDS(cb.temp.65, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_65_freq',save_suffix))

# 0-24, 25-44, 45-64 years separately
saveRDS(mod.freq.dnlm.0.24, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_0_24_freq',save_suffix))
saveRDS(cb.temp.0.24, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_0_24_freq',save_suffix))

saveRDS(mod.freq.dnlm.25.44, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_25_44_freq',save_suffix))
saveRDS(cb.temp.25.44, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_25_44_freq',save_suffix))

saveRDS(mod.freq.dnlm.45.64, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_45_64_freq',save_suffix))
saveRDS(cb.temp.45.64, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_45_64_freq',save_suffix))

# by sex and age separately
saveRDS(mod.freq.dnlm.females.0, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_females_0_freq',save_suffix))
saveRDS(cb.temp.females.0, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_females_0_freq',save_suffix))

saveRDS(mod.freq.dnlm.males.0, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_males_0_freq',save_suffix))
saveRDS(cb.temp.males.0, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_males_0_freq',save_suffix))

saveRDS(mod.freq.dnlm.females.65, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_females_65_freq',save_suffix))
saveRDS(cb.temp.females.65, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_females_65_freq',save_suffix))

saveRDS(mod.freq.dnlm.males.65, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_males_65_freq',save_suffix))
saveRDS(cb.temp.males.65, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_males_65_freq',save_suffix))

# by climate region
saveRDS(mod.freq.dnlm.northeast, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_northeast_freq',save_suffix))
saveRDS(cb.temp.northeast, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_northeast_freq',save_suffix))

saveRDS(mod.freq.dnlm.northern.rockies.and.plains, 
        paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_northern_rockies_and_plains_freq',save_suffix))
saveRDS(cb.temp.northern.rockies.and.plains, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_northern_rockies_and_plains_freq',save_suffix))

saveRDS(mod.freq.dnlm.northwest, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_northwest_freq',save_suffix))
saveRDS(cb.temp.northwest, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_northwest_freq',save_suffix))

saveRDS(mod.freq.dnlm.ohio.valley, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_ohio_valley_freq',save_suffix))
saveRDS(cb.temp.ohio.valley, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_ohio_valley_freq',save_suffix))

saveRDS(mod.freq.dnlm.south, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_south_freq',save_suffix))
saveRDS(cb.temp.south, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_south_freq',save_suffix))

saveRDS(mod.freq.dnlm.southeast, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_southeast_freq',save_suffix))
saveRDS(cb.temp.southeast, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_southeast_freq',save_suffix))

saveRDS(mod.freq.dnlm.southwest, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_southwest_freq',save_suffix))
saveRDS(cb.temp.southwest, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_southwest_freq',save_suffix))

saveRDS(mod.freq.dnlm.upper.midwest, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_upper_midwest_freq',save_suffix))
saveRDS(cb.temp.upper.midwest, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_upper_midwest_freq',save_suffix))

saveRDS(mod.freq.dnlm.west, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_west_freq',save_suffix))
saveRDS(cb.temp.west, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_west_freq',save_suffix))

# by SES 
saveRDS(mod.freq.dnlm.poverty.1, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_poverty1_freq',save_suffix))
saveRDS(cb.temp.poverty.1, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_poverty1_freq',save_suffix))
saveRDS(mod.freq.dnlm.poverty.2, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_poverty2_freq',save_suffix))
saveRDS(cb.temp.poverty.2, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_poverty2_freq',save_suffix))
saveRDS(mod.freq.dnlm.poverty.3, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_poverty3_freq',save_suffix))
saveRDS(cb.temp.poverty.3, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_poverty3_freq',save_suffix))
saveRDS(mod.freq.dnlm.poverty.4, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_poverty4_freq',save_suffix))
saveRDS(cb.temp.poverty.4, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_poverty4_freq',save_suffix))
saveRDS(mod.freq.dnlm.poverty.5, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_poverty5_freq',save_suffix))
saveRDS(cb.temp.poverty.5, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_poverty5_freq',save_suffix))

saveRDS(mod.freq.dnlm.education.1, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_education1_freq',save_suffix))
saveRDS(cb.temp.education.1, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_education1_freq',save_suffix))
saveRDS(mod.freq.dnlm.education.2, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_education2_freq',save_suffix))
saveRDS(cb.temp.education.2, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_education2_freq',save_suffix))
saveRDS(mod.freq.dnlm.education.3, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_education3_freq',save_suffix))
saveRDS(cb.temp.education.3, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_education3_freq',save_suffix))
saveRDS(mod.freq.dnlm.education.4, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_education4_freq',save_suffix))
saveRDS(cb.temp.education.4, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_education4_freq',save_suffix))
saveRDS(mod.freq.dnlm.education.5, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_education5_freq',save_suffix))
saveRDS(cb.temp.education.5, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_education5_freq',save_suffix))

saveRDS(mod.freq.dnlm.nonwhite.1, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_nonwhite1_freq',save_suffix))
saveRDS(cb.temp.nonwhite.1, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_nonwhite1_freq',save_suffix))
saveRDS(mod.freq.dnlm.nonwhite.2, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_nonwhite2_freq',save_suffix))
saveRDS(cb.temp.nonwhite.2, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_nonwhite2_freq',save_suffix))
saveRDS(mod.freq.dnlm.nonwhite.3, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_nonwhite3_freq',save_suffix))
saveRDS(cb.temp.nonwhite.3, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_nonwhite3_freq',save_suffix))
saveRDS(mod.freq.dnlm.nonwhite.4, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_nonwhite4_freq',save_suffix))
saveRDS(cb.temp.nonwhite.4, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_nonwhite4_freq',save_suffix))
saveRDS(mod.freq.dnlm.nonwhite.5, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_nonwhite5_freq',save_suffix))
saveRDS(cb.temp.nonwhite.5, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_nonwhite5_freq',save_suffix))

saveRDS(mod.freq.dnlm.nonwhite.1.poverty.1, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_nonwhite1_poverty1_freq',save_suffix))
saveRDS(cb.temp.nonwhite.1.poverty.1, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_nonwhite1_poverty1_freq',save_suffix))
saveRDS(mod.freq.dnlm.nonwhite.1.poverty.2, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_nonwhite1_poverty2_freq',save_suffix))
saveRDS(cb.temp.nonwhite.1.poverty.2, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_nonwhite1_poverty2_freq',save_suffix))
saveRDS(mod.freq.dnlm.nonwhite.1.poverty.3, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_nonwhite1_poverty3_freq',save_suffix))
saveRDS(cb.temp.nonwhite.1.poverty.3, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_nonwhite1_poverty3_freq',save_suffix))
saveRDS(mod.freq.dnlm.nonwhite.1.poverty.4, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_nonwhite1_poverty4_freq',save_suffix))
saveRDS(cb.temp.nonwhite.1.poverty.4, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_nonwhite1_poverty4_freq',save_suffix))
saveRDS(mod.freq.dnlm.nonwhite.1.poverty.5, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_nonwhite1_poverty5_freq',save_suffix))
saveRDS(cb.temp.nonwhite.1.poverty.5, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_nonwhite1_poverty5_freq',save_suffix))

saveRDS(mod.freq.dnlm.nonwhite.5.poverty.1, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_nonwhite5_poverty1_freq',save_suffix))
saveRDS(cb.temp.nonwhite.5.poverty.1, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_nonwhite5_poverty1_freq',save_suffix))
saveRDS(mod.freq.dnlm.nonwhite.5.poverty.2, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_nonwhite5_poverty2_freq',save_suffix))
saveRDS(cb.temp.nonwhite.5.poverty.2, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_nonwhite5_poverty2_freq',save_suffix))
saveRDS(mod.freq.dnlm.nonwhite.5.poverty.3, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_nonwhite5_poverty3_freq',save_suffix))
saveRDS(cb.temp.nonwhite.5.poverty.3, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_nonwhite5_poverty3_freq',save_suffix))
saveRDS(mod.freq.dnlm.nonwhite.5.poverty.4, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_nonwhite5_poverty4_freq',save_suffix))
saveRDS(cb.temp.nonwhite.5.poverty.4, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_nonwhite5_poverty4_freq',save_suffix))
saveRDS(mod.freq.dnlm.nonwhite.5.poverty.5, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_nonwhite5_poverty5_freq',save_suffix))
saveRDS(cb.temp.nonwhite.5.poverty.5, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_nonwhite5_poverty5_freq',save_suffix))

# # sensitivity with relative humidity
if(exposure=='tmean'){
  saveRDS(mod.freq.dnlm.rh, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_rh_sensitivity_freq',save_suffix))
  saveRDS(cb.rh, paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_rh_freq',save_suffix))
}