print('Running models')

# all together
mod.freq.dnlm             = clogit_run_alt(dat.complete,fml.freq.dnlm.alt('cb.temp'))

# females and males separately
mod.freq.dnlm.females     = clogit_run_alt(dat.complete.females,fml.freq.dnlm.alt('cb.temp.females'))
mod.freq.dnlm.males       = clogit_run_alt(dat.complete.males,fml.freq.dnlm.alt('cb.temp.males'))

# 0-64 years and 65+ years separately
mod.freq.dnlm.0           = clogit_run_alt(dat.complete.0,fml.freq.dnlm.alt('cb.temp.0'))
mod.freq.dnlm.65          = clogit_run_alt(dat.complete.65,fml.freq.dnlm.alt('cb.temp.65'))

# 0-24, 25-44, 45-64 years separately
mod.freq.dnlm.0.24           = clogit_run_alt(dat.complete.0.24,fml.freq.dnlm.alt('cb.temp.0.24'))
mod.freq.dnlm.25.44           = clogit_run_alt(dat.complete.25.44,fml.freq.dnlm.alt('cb.temp.25.44'))
mod.freq.dnlm.45.64           = clogit_run_alt(dat.complete.45.64,fml.freq.dnlm.alt('cb.temp.45.64'))

# by sex and age separately
mod.freq.dnlm.females.0   = clogit_run_alt(dat.complete.females.0,fml.freq.dnlm.alt('cb.temp.females.0'))
mod.freq.dnlm.males.0     = clogit_run_alt(dat.complete.males.0,fml.freq.dnlm.alt('cb.temp.males.0'))
mod.freq.dnlm.females.65  = clogit_run_alt(dat.complete.females.65,fml.freq.dnlm.alt('cb.temp.females.65'))
mod.freq.dnlm.males.65    = clogit_run_alt(dat.complete.males.65,fml.freq.dnlm.alt('cb.temp.males.65'))

# by climate region 
mod.freq.dnlm.northeast   = clogit_run_alt(dat.complete.northeast,fml.freq.dnlm.alt('cb.temp.northeast'))
mod.freq.dnlm.northern.rockies.and.plains  = clogit_run_alt(dat.complete.northern.rockies.and.plains,fml.freq.dnlm.alt('cb.temp.northern.rockies.and.plains'))
mod.freq.dnlm.northwest   = clogit_run_alt(dat.complete.northwest,fml.freq.dnlm.alt('cb.temp.northwest'))
mod.freq.dnlm.ohio.valley   = clogit_run_alt(dat.complete.ohio.valley,fml.freq.dnlm.alt('cb.temp.ohio.valley'))
mod.freq.dnlm.south   = clogit_run_alt(dat.complete.south,fml.freq.dnlm.alt('cb.temp.south'))
mod.freq.dnlm.southeast   = clogit_run_alt(dat.complete.southeast,fml.freq.dnlm.alt('cb.temp.southeast'))
mod.freq.dnlm.southwest   = clogit_run_alt(dat.complete.southwest,fml.freq.dnlm.alt('cb.temp.southwest'))
mod.freq.dnlm.upper.midwest  = clogit_run_alt(dat.complete.upper.midwest,fml.freq.dnlm.alt('cb.temp.upper.midwest'))
mod.freq.dnlm.west   = clogit_run_alt(dat.complete.west,fml.freq.dnlm.alt('cb.temp.west'))

# by SES 
mod.freq.dnlm.poverty.1   = clogit_run_alt(dat.complete.poverty.1,fml.freq.dnlm.alt('cb.temp.poverty.1'))
mod.freq.dnlm.poverty.2   = clogit_run_alt(dat.complete.poverty.2,fml.freq.dnlm.alt('cb.temp.poverty.2'))
mod.freq.dnlm.poverty.3   = clogit_run_alt(dat.complete.poverty.3,fml.freq.dnlm.alt('cb.temp.poverty.3'))
mod.freq.dnlm.poverty.4   = clogit_run_alt(dat.complete.poverty.4,fml.freq.dnlm.alt('cb.temp.poverty.4'))
mod.freq.dnlm.poverty.5   = clogit_run_alt(dat.complete.poverty.5,fml.freq.dnlm.alt('cb.temp.poverty.5'))

mod.freq.dnlm.education.1   = clogit_run_alt(dat.complete.education.1,fml.freq.dnlm.alt('cb.temp.education.1'))
mod.freq.dnlm.education.2   = clogit_run_alt(dat.complete.education.2,fml.freq.dnlm.alt('cb.temp.education.2'))
mod.freq.dnlm.education.3   = clogit_run_alt(dat.complete.education.3,fml.freq.dnlm.alt('cb.temp.education.3'))
mod.freq.dnlm.education.4   = clogit_run_alt(dat.complete.education.4,fml.freq.dnlm.alt('cb.temp.education.4'))
mod.freq.dnlm.education.5   = clogit_run_alt(dat.complete.education.5,fml.freq.dnlm.alt('cb.temp.education.5'))

mod.freq.dnlm.nonwhite.1   = clogit_run_alt(dat.complete.nonwhite.1,fml.freq.dnlm.alt('cb.temp.nonwhite.1'))
mod.freq.dnlm.nonwhite.2   = clogit_run_alt(dat.complete.nonwhite.2,fml.freq.dnlm.alt('cb.temp.nonwhite.2'))
mod.freq.dnlm.nonwhite.3   = clogit_run_alt(dat.complete.nonwhite.3,fml.freq.dnlm.alt('cb.temp.nonwhite.3'))
mod.freq.dnlm.nonwhite.4   = clogit_run_alt(dat.complete.nonwhite.4,fml.freq.dnlm.alt('cb.temp.nonwhite.4'))
mod.freq.dnlm.nonwhite.5   = clogit_run_alt(dat.complete.nonwhite.5,fml.freq.dnlm.alt('cb.temp.nonwhite.5'))

# by interaction between non-white and poverty for most non-white and least non-white
mod.freq.dnlm.nonwhite.1.poverty.1   = clogit_run_alt(dat.complete.nonwhite.1.poverty.1,fml.freq.dnlm.alt('cb.temp.nonwhite.1.poverty.1'))
mod.freq.dnlm.nonwhite.1.poverty.2   = clogit_run_alt(dat.complete.nonwhite.1.poverty.2,fml.freq.dnlm.alt('cb.temp.nonwhite.1.poverty.2'))
mod.freq.dnlm.nonwhite.1.poverty.3   = clogit_run_alt(dat.complete.nonwhite.1.poverty.3,fml.freq.dnlm.alt('cb.temp.nonwhite.1.poverty.3'))
mod.freq.dnlm.nonwhite.1.poverty.4   = clogit_run_alt(dat.complete.nonwhite.1.poverty.4,fml.freq.dnlm.alt('cb.temp.nonwhite.1.poverty.4'))
mod.freq.dnlm.nonwhite.1.poverty.5   = clogit_run_alt(dat.complete.nonwhite.1.poverty.5,fml.freq.dnlm.alt('cb.temp.nonwhite.1.poverty.5'))

mod.freq.dnlm.nonwhite.5.poverty.1   = clogit_run_alt(dat.complete.nonwhite.5.poverty.1,fml.freq.dnlm.alt('cb.temp.nonwhite.5.poverty.1'))
mod.freq.dnlm.nonwhite.5.poverty.2   = clogit_run_alt(dat.complete.nonwhite.5.poverty.2,fml.freq.dnlm.alt('cb.temp.nonwhite.5.poverty.2'))
mod.freq.dnlm.nonwhite.5.poverty.3   = clogit_run_alt(dat.complete.nonwhite.5.poverty.3,fml.freq.dnlm.alt('cb.temp.nonwhite.5.poverty.3'))
mod.freq.dnlm.nonwhite.5.poverty.4   = clogit_run_alt(dat.complete.nonwhite.5.poverty.4,fml.freq.dnlm.alt('cb.temp.nonwhite.5.poverty.4'))
mod.freq.dnlm.nonwhite.5.poverty.5   = clogit_run_alt(dat.complete.nonwhite.5.poverty.5,fml.freq.dnlm.alt('cb.temp.nonwhite.5.poverty.5'))

# sensitivity with relative humidity
if(exposure=='tmean'){
  mod.freq.dnlm.rh          = clogit_run_alt(dat.complete.sensitivity,fml.freq.dnlm.alt('cb.temp','cb.rh'))
}