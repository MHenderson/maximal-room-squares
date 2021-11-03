# read in every partial room square from one run of greedy4
X <- map_dfr(list.files("log", full.names = TRUE), readr::read_rds)

f <- function(i) {
  
  l_order <- i
  
  X1 <- X %>%
    filter(t == i) %>%
    pivot_wider()
  
  X1 %>%
    ggplot(aes(col, row)) +
    geom_segment(data = grid_lines(n-1, n-1), aes(x = x, y = y, xend = xend, yend = yend), size = .1) +
    geom_text(data = . %>% filter(!is.na(first)), aes(label = paste(first, second, sep = ","))) +
    scale_y_reverse() +
    coord_fixed() + 
    theme_void() +
    theme(
      legend.position  = "none"
    ) +
    labs(title = paste("Step:", X1 %>% pull(t) %>% first() %>% as.character()))

  ggsave(file = paste0("frames/frame", i, ".png"), width = 4, height = 4, bg = "white")
  
}

steps <- seq(min(X$t), max(X$t), 1)

tic()
map(steps, f)
toc()
