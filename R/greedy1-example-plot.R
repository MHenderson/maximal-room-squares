library(dplyr)
library(ggplot2)
library(glue)
library(here)
library(wallis)

source(here("R", "greedy1.R"))

n <- 6

R <- greedy1(n) |>
  mutate(fill = visit)

nf <- n_filled_cells(R)
v <- volume(R)

plot_room_square(R) +
  labs(
    caption = glue("Order: {n}\nFilled cells: {nf}\nVolume: {v}")
  ) +
  theme(plot.caption = element_text(hjust = 0)) 

ggsave(here("plots", "greedy1-example-plot.png"), width = 3, height = 3, bg = "white")
