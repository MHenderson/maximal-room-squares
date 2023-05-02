plot_room_square <- function(R, n = 10) {

  nf <- n_filled_cells(R)
  v <- volume(R)
  
  ggplot2::ggplot(data = R %>% tidyr::pivot_wider(), ggplot2::aes(col, row)) +
    ggplot2::geom_segment(data = grid_lines(n - 1, n - 1), ggplot2::aes(x = x, y = y, xend = xend, yend = yend), size = .1) +
    ggplot2::geom_text(data = R %>% tidyr::pivot_wider() %>% dplyr::filter(!is.na(first)), ggplot2::aes(label = paste(first, second, sep = ","))) +
    ggplot2::scale_y_reverse() +
    ggplot2::coord_fixed() + 
    ggplot2::theme_void() +
    ggplot2::theme(
      legend.position  = "none"
    ) +
    ggplot2::labs(
      title = glue::glue("A maximal partial Room square of order {n}"),
      subtitle = glue::glue("Number of filled cells: {nf}, Volume: {v}.")
    )

}