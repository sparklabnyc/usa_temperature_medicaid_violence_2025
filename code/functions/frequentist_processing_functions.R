####################################################################
# Functions for processing results
####################################################################

# process model results using variance-covariance matrices and obtain results assuming linear model
process_results_linear = function(analysis,exposure,lag_chosen=6,save_suffix='.rds'){
  
  # dummy data frame to load results that we loop through into
  dat.results = data.frame()
  # go through each included cause and process
  for(cause in causes_included){
    print(cause)
    cause.model.folder = paste0(model.folder,cause,'/')
    if(!(file.exists(paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_',analysis,'_freq',save_suffix)))){
      print(paste0(cause,'_dlnm_results_',analysis,'_freq',save_suffix,' not found'))  
    }
    if(file.exists(paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_',analysis,'_freq',save_suffix))){
      mod.freq.dnlm = readRDS(paste0(cause.model.folder,cause,'_',exposure,'_dlnm_results_',analysis,'_freq',save_suffix))
      cb.temp = readRDS(paste0(cause.model.folder,cause,'_',exposure,'_dlnm_cb_temp_freq',save_suffix))
      coeffs = coef(mod.freq.dnlm)
      vcovmatrix = Epi::ci.lin(mod.freq.dnlm, vcov=TRUE)$vcov
      indt = grep("temp", names(coeffs))
      result.temp = crosspred(cb.temp, coef=coeffs[indt], vcov=vcovmatrix[indt,indt],cen=0,at=c(0,1,5,10),cumul=TRUE)
      
      # estimate each of central and lower and upper bounds of effect estimates
      central.est = as.data.frame(result.temp$cumfit) %>%
        tibble::rownames_to_column("exposure_change") %>%
        select(exposure_change,paste0('lag',lag_chosen)) %>%
        mutate(exposure_change=as.numeric(exposure_change)) %>%
        rename(central.est=paste0('lag',lag_chosen))
      
      ll.est = as.data.frame(result.temp$cumlow) %>%
        tibble::rownames_to_column("exposure_change") %>%
        select(exposure_change,paste0('lag',lag_chosen)) %>%
        mutate(exposure_change=as.numeric(exposure_change)) %>%
        rename(ll.est=paste0('lag',lag_chosen))
      
      ul.est = as.data.frame(result.temp$cumhigh) %>%
        tibble::rownames_to_column("exposure_change") %>%
        select(exposure_change,paste0('lag',lag_chosen)) %>%
        mutate(exposure_change=as.numeric(exposure_change)) %>%
        rename(ul.est=paste0('lag',lag_chosen))
      
      dat.results.temp = left_join(central.est,ll.est) %>%
        left_join(.,ul.est) %>%
        mutate(cause=cause) %>%
        select(cause,exposure_change,central.est,ll.est,ul.est)
      
      dat.results = rbind(dat.results,dat.results.temp)
      }
  }
  
  dat.results = dat.results %>% 
    mutate(analysis=analysis) %>%
    mutate(exposure=exposure) %>%
    mutate(lag=lag_chosen) %>%
    select(lag,cause,exposure,analysis,everything())
  
  return(dat.results)
}