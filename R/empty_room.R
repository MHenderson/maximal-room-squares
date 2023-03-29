empty_room <- function(n = 5) {
  expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
    mutate(first = as.numeric(NA), second = as.numeric(NA))
}
