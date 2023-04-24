plot_room_square <- function(R, n = 10) {

  nf <- n_filled_cells(R)
  v <- volume(R)
  
  ggplot(data = R %>% pivot_wider(), aes(col, row)) +
    geom_segment(data = grid_lines(n - 1, n - 1), aes(x = x, y = y, xend = xend, yend = yend), linewidth = .1) +
    geom_text(data = R %>% pivot_wider() %>% filter(!is.na(first)), aes(label = paste(first, second, sep = ","))) +
    scale_y_reverse() +
    coord_fixed() + 
    theme_void() +
    theme(
      legend.position  = "none"
    ) +
    labs(
      title = glue("A maximal partial Room square of order {n}"),
      subtitle = glue("Number of filled cells: {nf}, Volume: {v}.")
    )

}