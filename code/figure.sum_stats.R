################################################################################
# COAL DEBT SECURITIZATION
# Purpose: Summary Statistics graphs
# Precedent: data.sum_stats.R
################################################################################
# Plot number of states with securitization policy
gov = sec %>%
  ggplot() + 
  geom_bar(position='stack', stat='identity', 
           aes(fill=governor_party, 
               y=num, 
               x=reorder(securitization_policy, securitization_policy, function(x)-length(x)))) + 
  scale_fill_manual('Party', values=c(color_blind_palette[5], color_blind_palette[1])) + 
  labs(x = "Securitization Policy", y = "No. of states",
       title = "Governor party in states with securitization policy") +
  coord_flip()
leg = sec %>% 
  ggplot() + 
  geom_bar(position='stack', stat='identity', 
           aes(fill=legislation_majority_party, 
               y=num, 
               x=reorder(securitization_policy, securitization_policy, function(x)-length(x)))) +
  scale_fill_manual('Party', values=c(color_blind_palette[5], color_blind_palette[4], color_blind_palette[1])) + 
  labs(x = "Securitization Policy", y = "No. of states",
       title = "Legislative majority party in states with securitization policy") +
  coord_flip()
p = grid.arrange(gov,leg, nrow = 2)
ggsave(file.path(my_dir,coal_debt,fig_path,paste0("policy.png")),p,"png")

# Plot Saber Bonds
s = ggplot(saber_bonds) + 
  geom_point(aes(x = year_group, y = state, size = size_mm, color = use_of_proceeds),alpha = 0.8) +
  labs(x = "Grouped Year", y = "State", title = "Use of Bond Proceeds", 
       caption = "Source: Saber Partners, LLC, Updated Nov. 2021") +
  scale_y_discrete(limits=rev)
ggsave(file.path(my_dir,coal_debt,fig_path,paste0("saber.png")),s,"png")

# Tree Plot of Saber Bonds
(t = ggplot(saber_tree, aes(area=size_mm,
                       fill=use,
                       group=use,
                       subgroup=state,
                       label=rating)) +
  geom_treemap() + 
  labs(title = "Energy Bond Securitization in the U.S., 1997 to 2021",
       subtitle = "Size of box corresponds to size of bond ($ millions). Top left corner is the bond rating (or pending).",
       fill = "Use of Bond Proceeds",
       caption = "Source: Saber Partners, LLC, Updated Nov. 2021") +   
  geom_treemap_subgroup_border() +
  geom_treemap_subgroup_text(place = "centre", grow = T, alpha = 0.6, color =
                               "black", fontface = "bold", min.size = 0) +
  geom_treemap_text(color = "darkgrey", place = "topleft", reflow = T,size=15) +
  scale_fill_paletteer_d("colorBlindness::Blue2Orange10Steps")
  )
ggsave(file.path(my_dir,coal_debt,fig_path,paste0("saber_tree.png")),t,"png")

# Clean up
rm(gov,leg,p,s,t)
