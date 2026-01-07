# list of objects used across different scripts

########################################## 
# MODEL DETAILS
########################################## 

# optimal var and lag dfs for crossbasis in model based on model testing from c_01
df_var_opt = 1
df_lag_opt = 6

########################################## 
# SPACE AND TIME OF STUDY
########################################## 

year_analysis_start = 1999
year_analysis_end = 2012
years_analysis = c(year_analysis_start:year_analysis_end)

years_analysis_end_sensitivity = 2009
years_analysis_sensitivity = c(year_analysis_start:years_analysis_end_sensitivity)

# state FIPS codes of continental United States
states_included = c("01", "04", "05", "06", 
                    "08", "09", "10", "11", "12",
                    "13", "16", "17", "18",
                    "19", "20", "21", "22", "23",
                    "24", "25", "26", "27", "28",
                    "29", "30", "31", "32", "33",
                    "34", "35", "36", "37", "38",
                    "39", "40", "41", "42", "44",
                    "45", "46", "47", "48", "49",
                    "50", "51", "53", "54", "55",
                    "56")

########################################## 
# CAUSES, EXPOSURES AND ANALYSES INCLUDED
########################################## 

causes_included = c('All_violence','assault','suicide')
exposures_included = c('tmean','wbgtmax')
exposure_change_chosen = 5

# analysis processed for results
analyses_made = c('main',
                  'females','males',
                  '0','65',
                  '0_24','25_44', '45_64',
                  'females_0','females_65','males_0','males_65',
                  'northeast','northern_rockies_and_plains','northwest',
                  'ohio_valley','south','southeast',
                  'southwest','upper_midwest','west',
                  'poverty1', 'poverty2', 'poverty3','poverty4','poverty5',
                  'education1', 'education2', 'education3','education4','education5',
                  'nonwhite1', 'nonwhite2', 'nonwhite3','nonwhite4','nonwhite5',
                  'nonwhite1_poverty1','nonwhite1_poverty5','nonwhite5_poverty1','nonwhite5_poverty5'
                  )

########################################## 
# COLOR SCHEMES
########################################## 

# useful general color scheme
library(RColorBrewer)
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

# ages
age.colours = c("blue",brewer.pal(9,"BrBG")[c(9:6,4:1)],"grey")[c(4,8)]
age.colours.10 = c("blue",brewer.pal(9,"BrBG")[c(9:6,4:1)],"grey")
age.colours.4 = age.colours.10[c(1,3,9,10)]

# sexes
colors.sex = c(mycols[c(44,28)])

# nyc/not-nyc
# from https://www.schemecolor.com/new-york-flag-usa.php
colors.nyc = c('#FFD200','#0178C9')

colors.cardio = mycols[c(
  22,  # Not cardiovascular diseases
  62)] # Cardiovascular diseases
# colors for broad causes of death

colors.respiratory= mycols[c(
  22,  # Not respiratory diseases
  48)] # Respiratory diseases

# color palette for temperature map
color.temp = c('dark blue',"blue","light blue","red", mycols[c(9)])

# color palette for alcohol and substance
# https://rdrr.io/cran/RColorBrewer/man/ColorBrewer.html useful!
color.sd = colorRampPalette(c(brewer.pal(9 , "YlOrBr")))(15)

# colors for different types of exposures
library(MetBrewer)
colors.exposures = met.brewer("VanGogh1", 5)[c(1,5)]

# colors for different temperature scales
colors.tmean.mean = rev(met.brewer(name='Cassatt1'))
colors.wbgtmax.mean = rev(met.brewer(name='Tam'))

