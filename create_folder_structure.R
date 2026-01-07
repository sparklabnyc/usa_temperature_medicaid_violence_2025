rm(list=ls())

# 0a Load Packages
library(here)

# 1a Declare directories (can add to over time)
project.folder = paste0(print(here::here()),'/')
  code.folder = paste0(project.folder, "code/")
    data.prep.code.folder = paste0(code.folder, "data_prep/")
    data.exploration.folder = paste0(code.folder, "data_exploration/")
    functions.folder = paste0(code.folder, "functions/")
    packages.folder = paste0(code.folder, "packages/")
    models.folder = paste0(code.folder, "models/")
    model.plotting.folder = paste0(code.folder, "model_plotting/")
    model.processing.folder = paste0(code.folder, "model_processing/")
  data.folder = paste0(project.folder, "data/")
   causelookup.folder = paste0(data.folder, "cause_lookup/")
    file.locations.folder = paste0(data.folder, "file_locations/")
    objects.folder = paste0(data.folder, "objects/")
    temperature.folder = paste0(data.folder, "tmean/")
      zcta.temperature.folder = paste0(temperature.folder, "zcta/")
    wbgtmax.folder = paste0(data.folder, "wbgtmax/")
      zcta.wbgtmax.folder = paste0(wbgtmax.folder, "zcta/")
    rhmean.folder = paste0(data.folder, "rhmean/")
      zcta.rhmean.folder = paste0(rhmean.folder, "zcta/")
    census.zcta.folder = paste0(data.folder, "census_zcta_ses/")
    ziplookup.folder = paste0(data.folder, "zip_lookup/")
    hospitalizations.folder = paste0(data.folder, "hospitalizations/")
      hospitalizations.na.folder = paste0(hospitalizations.folder, "na/")
        allviolence.folder = paste0(hospitalizations.folder, "processed_all_violence/")
        assault.folder = paste0(hospitalizations.folder, "processed_assault/")
        suicide.folder = paste0(hospitalizations.folder, "processed_suicide/")
        casecontrol.folder = paste0(hospitalizations.folder, "processed_case_control/")
        casecontrol.lag.folder = paste0(hospitalizations.folder, "processed_case_control_lag/")
        casecontrol.lag.temperature.folder = paste0(hospitalizations.folder, "processed_case_control_lag_temperature/")
    shapefiles.folder = paste0(data.folder, "shapefiles/")
      shapefiles.zcta.folder = paste0(shapefiles.folder, "zcta/")
  output.folder = paste0(project.folder, "output/")
    model.folder = paste0(output.folder, "model_output/")
  figures.folder = paste0(project.folder, "figures/")
    # figures.temperature.folder = paste0(figures.folder, "tmean/")
    # figures.hosps.folder = paste0(figures.folder, "hosps/")
      figure1.folder = paste0(figures.folder, "figure1/")
      figure2.folder = paste0(figures.folder, "figure2/")
      supplementaryfigure1.folder = paste0(figures.folder, "supplementaryfigure1/")
      supplementaryfigure2.folder = paste0(figures.folder, "supplementaryfigure2/")
      supplementaryfigure3.folder = paste0(figures.folder, "supplementaryfigure3/")
    model.exploration.folder = paste0(figures.folder,"model_figures/")
  tables.folder = paste0(project.folder, "tables/")
    # table0.folder = paste0(tables.folder, "table0/")
    table1.folder = paste0(tables.folder, "table1/")
  reports.folder = paste0(project.folder, "reports/")

# 1b Identify list of folder locations which have just been created above
folders.names = grep(".folder",names(.GlobalEnv),value=TRUE)

# 1c Create function to create list of folders
# note that the function will not create a folder if it already exists 
create_folders = function(name){
  ifelse(!dir.exists(get(name)), dir.create(get(name), recursive=TRUE), FALSE)
}

# 1d Create the folders named above
lapply(folders.names, create_folders)