empty_cells <- function(R) {
  E <- R[is.na(R$first), ]
  E <- mapply(c, E$row, E$col, SIMPLIFY = FALSE)
  return(E)
}
