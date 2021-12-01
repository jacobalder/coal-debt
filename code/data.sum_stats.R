################################################################################
# COAL DEBT SECURITIZATION
# Purpose: Summary Statistics
# Precedent: data.load.R
# Data Sources: RMI Utility Transition Hub, Last Updated Nov. 20, 2021
#               https://utilitytransitionhub.rmi.org/data-download/
#               
################################################################################

# List of states that have introduced or passed securitization, with Leg Party
sec = state_utility_policies[,.N, by = .(state,securitization_policy,
                                         legislation_majority_party,governor_party)
                             ][order(state)][,num := N/N]
sec.pass.l_repub = sec[securitization_policy=="Passed" & legislation_majority_party=="Republican"]
sec.pass.l_dem = sec[securitization_policy=="Passed" & !legislation_majority_party=="Republican"]
sec.intr.l_repub = sec[securitization_policy=="Introduced" & legislation_majority_party=="Republican"]
sec.intr.l_dem = sec[securitization_policy=="Introduced" & !legislation_majority_party=="Republican"]
sec.pass_intr = sec[securitization_policy=="Passed"|securitization_policy=="Introduced"
                    ][order(-securitization_policy,state)]
sec.none = sec[!securitization_policy=="Passed"&!securitization_policy=="Introduced"]

# Plot number of states with securitization policy
gov = sec %>%
  ggplot() + 
  geom_bar(position='stack', stat='identity', 
           aes(fill=governor_party, 
               y=num, 
               x=reorder(securitization_policy, securitization_policy, function(x)-length(x)))) + 
  scale_fill_manual('Party', values=c('steelblue', 'coral2')) + 
  labs(x = "Securitization Policy", y = "No. of states",
       title = "Governor party in states with securitization policy") +
  # theme(axis.title.x = element_blank()) +
  coord_flip()
leg = sec %>% 
  ggplot() + 
  geom_bar(position='stack', stat='identity', 
           aes(fill=legislation_majority_party, 
             y=num, 
             x=reorder(securitization_policy, securitization_policy, function(x)-length(x)))) +
  scale_fill_manual('Party', values=c('steelblue', 'darkgreen', 'coral2')) + 
  labs(x = "Securitization Policy", y = "No. of states",
       title = "Legislative majority party in states with securitization policy") +
  # theme(axis.title.x = element_blank()) +
  coord_flip()
p = grid.arrange(gov,leg, nrow = 2)
ggsave(file.path(my_dir,coal_debt,fig_path,paste0("p")),p,"png")
