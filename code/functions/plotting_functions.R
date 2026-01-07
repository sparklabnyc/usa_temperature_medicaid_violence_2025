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
