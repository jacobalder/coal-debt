################################################################################
# COAL DEBT SECURITIZATION
# Purpose: Summary Statistics
# Precedent: data.load.R
# Data Sources: RMI Utility Transition Hub, Last Updated Nov. 20, 2021
#               https://utilitytransitionhub.rmi.org/data-download/
#               
################################################################################
describeBy(state_utility_policies, group=state_utility_policies$securitization_policy)

# RMI TRANSITION HUB ------------------------------------------------------

# List of states that have introduced or passed securitization, with Leg Party
sec = state_utility_policies[,.N, by = .(state,securitization_policy,
                                         legislation_majority_party,governor_party)
                             ][order(state)][,num := N/N]
sec.pass.l_repub = sec[securitization_policy=="Passed" & legislation_majority_party=="Republican"]
sec.pass.l_dem = sec[securitization_policy=="Passed" & !legislation_majority_party=="Republican"]
sec.intr.l_repub = sec[securitization_policy=="Introduced" & legislation_majority_party=="Republican"]
sec.intr.l_dem = sec[securitization_policy=="Introduced" & !legislation_majority_party=="Republican"]

# List of states that introduced or passed securitization
sec.pass_intr = sec[securitization_policy=="Passed"|securitization_policy=="Introduced"
                    ][order(-securitization_policy,state)]
write.csv(sec.pass_intr,"figures/sec.pass_intr.csv")
sec.none = sec[!securitization_policy=="Passed"&!securitization_policy=="Introduced"]

# Print states
sec.pass = sec[securitization_policy=="Passed"]
sec.intr = sec[securitization_policy=="Introduced"]


# SABER BONDS -------------------------------------------------------------
saber_bonds = saber_bonds[,`:=`(date=as.Date(date,"%m/%d/%y"),
                                year=format(as.Date(date,"%m/%d/%y"),"%Y"))
                          ][,.SD[!all(is.na(date))],by=date
                            ][,`:=`(year_group = cut(as.numeric(year),
                                                     seq(1997,2022,5),include.lowest = T))]
total_bonds = saber_bonds[,as.list(summary(size_mm,use_of_proceeds)),by=use_of_proceeds]
total_bonds
date_bonds = saber_bonds[,.N,by=.(use_of_proceeds,year)]
date_bonds[year>2011&year<2017][order(year)]

# For Tree map
saber_tree = saber_bonds[,use := fifelse(use_of_proceeds=="Wildfire","Wildfire Costs",
                          fifelse(use_of_proceeds=="Wildfire Damages","Wildfire Costs",
                          fifelse(use_of_proceeds=="Wildfire Mitigation","Wildfire Costs",
                          fifelse(use_of_proceeds=="Environmental","Environmental Costs",
                          fifelse(use_of_proceeds=="Environmental Facilities","Environmental Costs",
                          fifelse(use_of_proceeds=="Recovery","Storm Recovery",use_of_proceeds))))))]
head(saber_tree)

# EIA MONTHLY -------------------------------------------------------------
ann_MER_T06_01[,`:=`(year_mon = as.yearmon(as.character(YYYYMM),"%Y%M"))][,year := as.year(year_mon)]
head(ann_MER_T06_01)
ann_MER_T06_01[, lapply(.SD, sum), .SDcols=c("Value"),by=.(year,Description)]
# EIA ANNUAL --------------------------------------------------------------

# MAKE GRAPHS -------------------------------------------------------------
# Easy graphs (comes at end!)
source(file.path(my_dir,coal_debt,code_path,"data.sum_stats.figs.R"))
