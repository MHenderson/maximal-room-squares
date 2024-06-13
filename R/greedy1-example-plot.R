library(ggplot2)
library(here)

source(here("R", "empty_cells.R"))
source(here("R", "empty_room.R"))
source(here("R", "greedy1.R"))
source(here("R", "grid_lines.R"))
source(here("R", "n-filled-cells.R"))
source(here("R", "not_used_pairs.R"))
source(here("R", "plot_room_square.R"))
source(here("R", "volume.R"))

R <- greedy1(6)

plot_room_square_labs(R)

ggsave(here("plots", "greedy1-example-plot.png"), width = 3, height = 3, bg = "white")
