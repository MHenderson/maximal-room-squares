plot_room_square <- function(R) {

  n <- max(R$col) + 1
  
  nf <- n_filled_cells(R)
  v <- volume(R)
  
  ggplot2::ggplot(data = R, ggplot2::aes(col, row)) +
    ggplot2::geom_tile(data = R %>% dplyr::filter(!is.na(first)), ggplot2::aes(fill = visit)) +
    ggplot2::geom_segment(data = grid_lines(n - 1, n - 1), ggplot2::aes(x = x, y = y, xend = xend, yend = yend), size = .1) +
    ggplot2::geom_text(data = R %>% dplyr::filter(!is.na(first)), ggplot2::aes(label = paste(first, second, sep = ","))) +
    ggplot2::geom_text(data = R %>% dplyr::filter(!is.na(first)), ggplot2::aes(label = paste(first, second, sep = ","))) +
    ggplot2::scale_y_reverse() +
    ggplot2::coord_fixed() + 
    ggplot2::theme_void() +
    ggplot2::theme(
      legend.position  = "none"
    ) +
    ggplot2::scale_fill_gradient(limits = c(0, choose(n, 2)), low = "white", high = "blue") +
    ggplot2::labs(
      title = glue::glue("A maximal partial Room square of order {n}"),
      subtitle = glue::glue("Number of filled cells: {nf}, Volume: {v}.")
    )

}