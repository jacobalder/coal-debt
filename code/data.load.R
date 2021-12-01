################################################################################
# COAL DEBT SECURITIZATION
# Purpose: Load data sources
# Dependencies: data.sum_stats.R
# Data Sources: RMI Utility Transition Hub, Last Updated Nov. 20, 2021
#               https://utilitytransitionhub.rmi.org/data-download/
#               
################################################################################
rmi_path = file.path(my_dir,coal_debt,data_path,paste0("RMI/data_download_all"))

# Make a vector of .csv files in the folder
contents = list.files(rmi_path, pattern = "csv", full.names = F)

# Assign vector to data.tables
for(i in contents) {
  assign(gsub('.csv','', i), 
         fread(file.path(rmi_path,i))) # Read in the downloaded files
}

# Clean up
rm(i, contents, rmi_path)
