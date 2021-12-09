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
saber.files = file.path(my_dir,coal_debt,data_path,paste0("SABER"))
map.files = file.path(my_dir,coal_debt,data_path,paste0("bills"))
eia.files = file.path(my_dir,coal_debt,data_path,paste0("EIA"))

# Make a vector of .csv files in the folder
contents.rmi = list.files(rmi.files, pattern = "csv", full.names = F)
contents.ncsl = list.files(ncsl.files, pattern = "csv", full.names = F)
contents.saber = list.files(saber.files, pattern = "csv", full.names = F)
contents.map = list.files(map.files, pattern = "csv", full.names = F)
contents.eia = list.files(eia.files, pattern = "csv", full.names = F)
  
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

# Assign saber vector to data.table
for(i in contents.saber) {
  assign(gsub('.csv','', i),
         fread(file.path(saber.files,i))) # Read in the downloaded files
}

# Assign map vector to data.table
for(i in contents.map) {
  assign(gsub('.csv','', i),
         fread(file.path(map.files,i))) # Read in the downloaded files
}

# Assign EIA vector to data.table
for(i in contents.eia) {
  assign(gsub('.csv','', i),
         fread(file.path(eia.files,i),)) # Read in the downloaded files
}


# Clean up
rm(i)
rm(list=ls(pattern = ".files"))
rm(list=ls(pattern = "contents."))
