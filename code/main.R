################################################################################
# COAL DEBT SECURITIZATION
# Copyright: Jacob Alder, Indiana University
# E-mail: alderjc@iu.edu
# Dependencies:
# Outputs: using PUDL database
# Purpose: Main working directory
################################################################################
## LOAD PACKAGES
if(!require("pacman")) install.packages("pacman")
pacman::p_load(arm,car,data.table,DataCombine,dplyr,estimatr,fixest,ggplot2,gridExtra,
               gtsummary,haven,here,lmtest,mediation,modelsummary,parallel,plm,psych,
               rdrobust,rio,sandwich,stargazer,SnowballC,survival,survminer,tictoc,
               tidyverse,tm)

## SET WORKING DIRECTORY
# Set working directory (where you cloned the repo)
my_dir = "~/OneDrive - Indiana University/research/COAL/GitHub"
coal_debt = "coal-debt"
data_path = "data"
code_path = "code" 
fig_path = "figures" 
if(!getwd() == file.path(my_dir,coal_debt)){setwd(file.path(my_dir,coal_debt))}
getwd()
set.seed(101)

## LOAD FILES
source(file.path(my_dir,coal_debt,code_path,"data.load.R"))

## CLEAN FILES
source(file.path(my_dir,coal_debt,code_path,"data.clean.R"))

## SUMMARY STATISTICS
source(file.path(my_dir,coal_debt,code_path,"replication.sum_stats.R"))
