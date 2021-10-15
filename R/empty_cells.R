empty_cells <- function(R) {
  E <- R[R$name=="first", ]
  E <- E[is.na(E$value), ]
  E <- mapply(c, E$row, E$col, SIMPLIFY = FALSE)
  return(E)
}