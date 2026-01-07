#!/bin/bash
#SBATCH -c 1                # Number of cores (-c)
#SBATCH -t 0-01:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p serial_requeue   # Partition to submit to
#SBATCH --mem=50000          # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o myoutput_%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e myerrors_%j.err  # File to which STDERR will be written, %j inserts jobid
#SBATCH --mail-type=END     # Send an email when the job ends.
#SBATCH --mail-user=robbie.parks@columbia.edu

# this script
# runs all the data prep for each of the causes 

clear

#################################################
# MODULE LOADING
#################################################

module load R/4.4.3-fasrc01
export R_LIBS_USER=$HOME/apps/R_4.4.3:$R_LIBS_USER
module load R/4.4.3-fasrc01
module load gcc/9.5.0-fasrc01 
unset R_LIBS_SITE
mkdir -p $HOME/apps/R/4.4.3
export R_LIBS_USER=$HOME/apps/R/4.4.3:$R_LIBS_USER

# module load R/4.1.0-fasrc01
# export R_LIBS_USER=$HOME/apps/R_4.1.0:$R_LIBS_USER
# module load R/4.1.0-fasrc01
# module load gdal/2.3.0-fasrc01
# module load geos/3.6.2-fasrc01
# module load proj/5.0.1-fasrc01
# module load gcc/9.3.0-fasrc01 udunits/2.2.26-fasrc01
# unset R_LIBS_SITE
# mkdir -p $HOME/apps/R/4.1.0
# export R_LIBS_USER=$HOME/apps/R/4.1.0:$R_LIBS_USER

#################################################
# PROCESS MODEL RESULTS
#################################################

Rscript ~/git/temperature_violence_medicaid_2022/code/model_processing/d_04_process_model_results_lag01_sensitivity.R;

# to run use
# sbatch d_00_process_model_results_lag01_sensitivity.sh

# to check run use
# squeue -j BATCH_JOB_NUMBER
