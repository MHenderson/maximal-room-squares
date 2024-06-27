library(dplyr)
library(ggplot2)
library(glue)
library(here)
library(patchwork)
library(wallis)

source(here("R", "greedy2.R"))

n1 <- 8

R1 <- greedy2(n1) |>
  mutate(fill = visit)

nf1 <- n_filled_cells(R1)
v1 <- volume(R1)

n2 <- 10

R2 <- greedy2(n2) |>
  mutate(fill = visit)

nf2 <- n_filled_cells(R2)
v2 <- volume(R2)

P1 <- plot_room_square(R1) +
  labs(
    caption = glue("Order: {n1}\nFilled cells: {nf1}\nVolume: {v1}")
  ) +
  theme(plot.caption = element_text(hjust = 0)) 

P2 <- plot_room_square(R2) +
  labs(
    caption = glue("Order: {n2}\nFilled cells: {nf2}\nVolume: {v2}")
  ) +
  theme(plot.caption = element_text(hjust = 0))

ggsave(plot = P1 + P2, filename = here("plots", "greedy2-examples1-plot.png"), width = 9, height = 4, bg = "white")