# https://github.com/EmilHvitfeldt/r-color-palettes
library(ggplot2)
library(ggthemes)
library(ggsci)
library(pals)
library(Polychrome)

source("grid_functions.r")

n <- 50

ggplot(data = P %>% pivot_wider(), aes(col, row)) +
  geom_tile(aes(fill = first)) +
  geom_tile(aes(fill = second), height = .5, width = .5) +
  geom_segment(data = grid_lines(n - 1, n - 1), aes(x = x, y = y, xend = xend, yend = yend), size = .1) +
  #scale_fill_tableau(palette = "Classic Green-Orange 12") +
  scale_fill_gradient(na.value = "white") +
  scale_y_reverse() +
  coord_fixed() + 
  theme_void() +
  theme(
    legend.position  = "none"
  )


n <- 8

P36 <- palette36.colors()
names(P36) <- NULL

ggplot(data = P %>% pivot_wider(), aes(col, row)) +
  geom_tile(aes(fill = as.factor(first))) +
  geom_tile(aes(fill = as.factor(second)), height = .5, width = .5) +
  geom_segment(data = grid_lines(n - 1, n - 1), aes(x = x, y = y, xend = xend, yend = yend), size = .1) +
  #scale_fill_tableau(palette = "Classic Green-Orange 12") +
  #scale_fill_igv() +
  #scale_fill_stata() +
  #scale_fill_manual(values = glasbey(), na.value = "white") +
  scale_fill_manual(values = P36, na.value = "white") +
  scale_y_reverse() +
  coord_fixed() + 
  theme_void() +
  theme(
    legend.position  = "none",
    panel.background = element_rect(fill = "white", colour = "white", size = 0.5, linetype = "solid")
  )

ggsave("maximal.png", width = 3, height = 3)

P_w <- P %>% pivot_wider()

ggplot(data = P_w, aes(col, row)) +
  geom_text(data = P_w %>% filter(!is.na(first)), aes(label = paste(first, second))) +
  geom_segment(data = grid_lines(n - 1, n - 1), aes(x = x, y = y, xend = xend, yend = yend), size = .1) +
  scale_y_reverse() +
  coord_fixed() + 
  theme_void() +
  theme(
    legend.position  = "none",
    panel.background = element_rect(fill = "white", colour = "white", size = 0.5, linetype = "solid")
  )



