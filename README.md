# **Higher temperatures are associated with increased interpersonal and self inflicted violence-related Medicaid hospital visits in the United States**

Robbie M Parks, Lauren Flynn, Zifan Gu, Danielle Braun, Ilan Cerna-Turoff, Cascade Tuholske, Francesca Dominici, Jutta Lindert, Marianthi-Anna Kioumourtzoglou. Communications Sustainability. 2026

## Project description

This dataset and code is used for the paper

LINK

## 1. Data

Folder containing data used in analysis

## 2. Code

note: please run create_folder_structure.R first to create folders which may not be there when first loaded

### Data preparation (data_prep) list:

a_00_process_data_for_model_by_cause - Runs bash file for processing data by cause (run on Harvard system)

a_01_prepare_temperature_data - Prepare ZCTA-level daily temperature data

a_02_prepare_hospitalization_data - Prepare ZCTA-level daily Medicaid violence hospitalization data 

a_03_control_days_process - Process control days using day of week matching for weeks before and after hospitalization date

a_04_lag_days_process - Add lag days to each case and control\
\
a_05_case_crossover_lag_data_finalise - Finalise data for model input based on temperature, control and lag days pre-processing

### Data exploration (data_exploration) list:

b_00_plot_data_exploration_tables_figures - Runs bash file for processing data exploration tables and figures (run on Harvard system)

b_01_explore_missing_zctas - See which ZCTAs are not matched and why

b_02_table_1 - Table 1 create

b_03_table_1_sensitivity - Table 1 create for sensitivity of pre-2010 analysis

b_04_figure_1 - Plot over time of Medicaid hospital visits

### Model running (models) list:

c_00_model_main_freq - Runs bash file for running models (run on Harvard system)

c_00_model_main_freq_sensitivity - Runs bash file for running models of pre-2010 analysis (run on Harvard system)

c_00_model_violence_all_find_optimal - Runs bash file for running candidate models to find optimal fit (run on Harvard system)

c_01_model_violence_all_find_optimal_tmean - Testing linear, spline, dlnm with lag and var knots to find minimum AIC

c_02_model_violence_all_find_optimal_wbgtmax - Testing linear, spline, dlnm with lag and var knots to find minimum AIC

c_03_model_main_freq - Main model code

c_04_model_sensitivity_freq - Sensitivity model code

### Model processing (model_processing) list:

d_00_process_model_results - Runs bash file for d_01 (run on Harvard system)

d_00_process_model_results_lag01 - Runs bash file for d_02 (run on Harvard system)

d_00_process_model_results_sensitivity - Runs bash file for d_03 (run on Harvard system)

d_00_process_model_results_lag01_sensitivity - Runs bash file for d_04 (run on Harvard system)

d_01_process_model_results - Process results from c_03

d_02_process_model_results_lag01 - Process results from c_03 but only for lags 0 and 1

d_03_process_model_results_sensitivity - Process results from c_04

d_04_process_model_results_lag01_sensitivity - Process results from c_04 but only for lags 0 and 1

### Model plotting (model_plotting) list:

e_01_figure_2 - Plot main model output results (lag days 0-1)

e_02_supplementary_figure_1 - Plot main model output results (lag days 0-6)

e_03_supplementary_figure_2 - Plot main model output results (lag days 0-1)

e_04_supplementary_figure_3 - Plot main model output results but only for lags 0 and 1 for pre-Medicaid expansion (pre-2010)

### Functions

Folder containing functions

## 3. Output

models - Saved model output

model_output - csv of model results

## 4. Tables

Tables and supplementary tables

## 5. Figures

All figures for manuscript and supplement

## Directory structure

``` md
.
├── code
│   ├── data_exploration
│   ├── data_prep
│   ├── functions
│   ├── model_plotting
│   ├── model_processing
│   ├── models
│   └── packages
├── create_folder_structure.R
├── data
│   ├── cause_lookup
│   ├── census_zcta_ses
│   ├── file_locations
│   ├── hospitalizations
│   ├── login and load R
│   ├── mortality
│   ├── mortality_fake
│   ├── objects
│   ├── rhmean
│   ├── shapefiles
│   ├── tmean
│   ├── wbgtmax
│   └── zip_lookup
├── figures
│   ├── figure1
│   ├── figure2
│   ├── model_figures
│   ├── supplementaryfigure1
│   ├── supplementaryfigure2
│   ├── supplementaryfigure3
│   └── zz_legacy
├── output
│   ├── model_output
│   └── models
├── README.md
├── tables
│   └── table1
```

## Data Availability

Daily 4-km PRISM data during 1999-2012 are freely available at <https://prism.oregonstate.edu/recent/>.

WBGTmax data is available via <https://github.com/sparklabnyc/PRISM-grids-into-FIPS-ZIP-censustract-USA>.

Medicaid enrollees dynamic cohort data are publicly available, upon purchase and after an application process, from the Centers for Medicare & Medicaid Services (CMS) at <https://www.cms.gov/Research-Statistics-Data-and-Systems/CMS-Information-Technology/AccesstoDataApplication/index>.

Census data are freely available from the American Community Survey (ACS) (<https://www.census.gov/programs-surveys/acs>).
