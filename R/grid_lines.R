horiz_lines <- function(n_rows, n_cols) {
  tibble::tibble(
       x = rep(0, n_rows + 1)  + .5,
       y = 0:n_rows + .5,
    xend = rep(n_cols, n_rows + 1) + .5,
    yend = 0:n_rows + .5
  )
}

vertical_lines <- function(n_rows, n_cols) {
  tibble::tibble(
       x = 0:n_cols + .5,
       y = rep(0, n_cols + 1) + .5,
    xend = 0:n_cols + .5,
    yend = rep(n_rows, n_cols + 1) + .5
  )
}

grid_lines <- function(n_rows, n_cols) {
  dplyr::bind_rows(
    horiz_lines(n_rows, n_cols),
    vertical_lines(n_rows, n_cols)
  )
}
