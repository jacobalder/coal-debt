################################################################################
# COAL DEBT SECURITIZATION
# Purpose: Summary Statistics
# Precedent: data.load.R
# Data Sources: RMI Utility Transition Hub, Last Updated Nov. 20, 2021
#               https://utilitytransitionhub.rmi.org/data-download/
#               
################################################################################
describeBy(state_utility_policies, group=state_utility_policies$securitization_policy)

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

# SABER BONDS
saber_bonds = saber_bonds[,`:=`(date=as.Date(date,"%m/%d/%y"),
                                year=format(as.Date(date,"%m/%d/%y"),"%Y"))
                          ][,.SD[!all(is.na(date))],by=date
                            ][,`:=`(year_group = cut(as.numeric(year),
                                                     seq(1997,2022,5),include.lowest = T))]
total_bonds = saber_bonds[,as.list(summary(size_mm,use_of_proceeds)),by=use_of_proceeds]
total_bonds
date_bonds = saber_bonds[,.N,by=.(use_of_proceeds,year)]
date_bonds[year>2011&year<2017][order(year)]


# Easy graphs (comes at end!)
source(file.path(my_dir,coal_debt,code_path,"data.sum_stats.figs.R"))
