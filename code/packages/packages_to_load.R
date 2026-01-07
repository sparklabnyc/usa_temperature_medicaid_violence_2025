############ 1. Packages on CRAN ############

# list of packages to use (in alphabetical order and 5 per row)
list.of.packages = c(
  # 'data.table',
  'dlnm',
  'dplyr',
  'Epi',
  'fst',
  'ggplot2',
  # 'graticule',
  'gtsummary',
  'lubridate',
  # 'maptools',
  # 'mapproj',
  'MetBrewer',
  # 'plyr',
  'purrr',
  # 'raster',
  'RColorBrewer',
  'readr',
  'rgeos',
  'rgdal',
  # 'rstan',
  'sp',
  'splines'
 # 'stringr'
  # 'tidyr'
  # 'zoo'
)

# load packages
lapply(list.of.packages, require, character.only = TRUE)

############ 2. Packages on not on CRAN and to download from source ############

# list of packages not on CRAN (INLA only in this case)
#list.of.packages.not.on.cran <- c('INLA')
#new.packages.not.on.cran <- list.of.packages[!(list.of.packages.not.on.cran %in% installed.packages()[,"Package"])]
#if(length(new.packages.not.on.cran)) {
  # install.packages("INLA",repos=c(getOption("repos"),INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)
#  remotes::install_version("INLA", version = "20.03.29",
#                           repos = c(getOption("repos"),
#                                     INLA = "https://inla.r-inla-download.org/R/testing"),
#                           dep = TRUE)
#}
#invisible(lapply(list.of.packages.not.on.cran, require, character.only = TRUE, quietly=TRUE))
