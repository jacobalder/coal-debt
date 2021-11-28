################################################################################
# COAL DEBT SECURITIZATION
# Purpose: Main working directory
# Load data sources
################################################################################
rmi_path = file.path(my_dir,coal_debt,data_path,paste0("RMI/data_download_all"))
contents = list.files(rmi_path)
contents = contents[grep(".csv",contents)]
for(i in contents) {
  assign(gsub('.csv','', i),
         fread(file.path(rmi_path,i))) # Read in the downloaded files
}
rm(i, rmi_path)
