empty_room <- function(n = 5) {
  tidyr::expand_grid(row = 1:(n - 1), col = 1:(n - 1)) |>
    dplyr::mutate(first = as.numeric(NA), second = as.numeric(NA))
}
