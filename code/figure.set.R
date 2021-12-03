################################################################################
# COAL DEBT SECURITIZATION
# Purpose: Setup the figures
################################################################################
theme_set(theme_classic(base_size=12))

# Color blind safe palette ROYGBIV
color_blind_palette = c("#D55E00", # 1 - Red
                        "#E69F00", # 2 - Orange
                        "#F0E442", # 3 - Yellow
                        "#009E73", # 4 - Green
                        "#0072B2", # 5 - Blue
                        "#56B4E9", # 6 - Light blue
                        "#CC79A7", # 7 - Pink
                        "#000000", # 8 - Black
                        "#A8A8A8", # 9 - Gray
                        "#EDEDED" # 10 - Light Gray
                        )

## Toy graph of the colors
# dt <- data.table(A = letters[1:8], X = 1:8, key = "A")
# ggplot(dt) + 
#   geom_col(aes(x = X, y = A), fill = color_blind_palette)