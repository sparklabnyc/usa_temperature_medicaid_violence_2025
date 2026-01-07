####  DLNM-SPECIFIC FUNCTIONS #### 

crossbasis_form = function(exp,df_var,df_lag){
  cb.temp <- crossbasis(exp,
                        lag=c(0,6),
                        argvar=list(fun = "ns", df = df_var),
                        arglag=list(fun = "ns", df = df_lag))
}

#### MODELS ####

# Frequentist conditional logistic with linear temperature on day of hospitalization     
fml.linear.temp = ck ~
  lag0 +
  strata(nr)

fml.linear.temp.alt = ck ~
  lag0

# Conditional logistic with temperature spline with three degrees of freedom with temperature on day of hospitalization 
fml.spline.3deg  = ck ~
  ns(lag0,df=3) +
  strata(nr)

fml.spline.3deg.alt  = ck ~
  ns(lag0,df=3)

# Conditional logistic with temperature spline with four degrees of freedom with temperature of day of hospitalization   
fml.spline.4deg = ck ~
  ns(lag0,df=4) +
  strata(nr)

fml.spline.4deg.alt = ck ~
  ns(lag0,df=4) 

# Conditional logistic with constrained dlnm temperature term of day of and up to 6 days prior
fml.freq.dnlm = function(cb){
  cb = toString(cb)
  fml.freq.dnlm = as.formula(paste('ck~survival::strata(nr) + ', cb))
}

fml.freq.dnlm.alt = function(cb,cb2=""){
  cb = toString(cb)
  cb2 = toString(cb2)
  if(cb2==""){fml.freq.dnlm = as.formula(paste('ck~', cb))}
  if(cb2!=""){fml.freq.dnlm = as.formula(paste('ck~', cb,'+',cb2))}
  
  return(fml.freq.dnlm)
}

# function to run frequentist conditional logistic
clogit_run = function(data, formula){
  mod = survival::clogit(formula, data = data)
  return(mod)
}

clogit_run_alt = function(data, formula){
  mod = Epi::clogistic(formula, strata = nr, data = data)
  return(mod)
}