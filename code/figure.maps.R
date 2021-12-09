################################################################################
# COAL DEBT SECURITIZATION
# Purpose: Map Statistics
# Precedent: data.load.R
# Data Sources: RMI Utility Transition Hub, Last Updated Nov. 20, 2021
#               https://utilitytransitionhub.rmi.org/data-download/
#               
################################################################################
# Use cool package from https://github.com/pdil/usmap
plot_usmap(data = state_utility_policies, 
           values = "securitization_policy") + 
  ## Currently not working, come back to this
  # scale_color_discrete(name = "Securitization Policy" 
                       # values = c(color_blind_palette[6], color_blind_palette[9],
                                # color_blind_palette[4], color_blind_palette[10])
                       # )+
  labs(title = "Securitization Policy by State", color = "Securitization Policy as of November 2021",
         caption = "Source: RMI Utility Transition Hub") +
  theme(legend.position = "right") + 
  theme(panel.background = element_rect(color = "black"))

# Map update
(map = plot_usmap(data = securitization_status, 
           values = "status_for_retirements") + 
  ## Currently not working, come back to this
  # scale_color_discrete(name = "Securitization Policy" 
  # values = c(color_blind_palette[6], color_blind_palette[9],
  # color_blind_palette[4], color_blind_palette[10])
  # )+
  labs(title = "Securitization Policy by State", values = "Securitization Policy as of November 2021",
       caption = "Source: State Legislation Bill Tracker") +
  theme(legend.position = "right") + 
  theme(panel.background = element_rect(color = "black")) +
  scale_color_paletteer_d("nord::aurora")
)
ggsave(file.path(my_dir,coal_debt,fig_path,paste0("map")),map,"png")
