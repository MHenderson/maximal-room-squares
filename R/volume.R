volume <- function(R) {
  round(n_filled_cells(R)/choose(max(R$col) + 1, 2), 6)
}