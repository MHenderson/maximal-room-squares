library(ggplot2)
library(ggthemes)

source("grid_functions.r")

ggplot(data = P %>% pivot_wider(), aes(col, row)) +
  geom_tile(aes(fill = first)) +
  geom_tile(aes(fill = second), height = .5, width = .5) +
  geom_segment(data = grid_lines(49, 49), aes(x = x, y = y, xend = xend, yend = yend), size = .1) +
  #scale_fill_tableau(palette = "Classic Green-Orange 12") +
  scale_y_reverse() +
  coord_fixed() + 
  theme_void() +
  theme(
    legend.position  = "none"
  )
