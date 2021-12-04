################################################################################
# COAL DEBT SECURITIZATION
# Purpose: Load data sources
# Dependencies: data.sum_stats.R
# Data Sources: RMI Utility Transition Hub, Last Updated Nov. 20, 2021
#               https://utilitytransitionhub.rmi.org/data-download/
#               NCSL, Last Updated Nov 16, 2021
#               https://www.ncsl.org/research/energy/energy-legislation-tracking-database.aspx
################################################################################
rmi.files = file.path(my_dir,coal_debt,data_path,paste0("RMI/data_download_all"))
ncsl.files = file.path(my_dir,coal_debt,data_path,paste0("NCSL"))

# Make a vector of .csv files in the folder
contents.rmi = list.files(rmi.files, pattern = "csv", full.names = F)
contents.ncsl = list.files(ncsl.files, pattern = "csv", full.names = F)

# Assign rmi vector to data.table
for(i in contents.rmi) {
  assign(gsub('.csv','', i),
         fread(file.path(rmi.files,i))) # Read in the downloaded files
}

# Assign ncsl vector to data.table
for(i in contents.ncsl) {
  assign(gsub('.csv','', i),
         fread(file.path(ncsl.files,i))) # Read in the downloaded files
}

# Clean up
rm(i)
rm(list=ls(pattern = ".files"))
rm(list=ls(pattern = "contents."))
