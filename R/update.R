update_ <- function(R, cell, pair) {
  R[R$row == cell[1] & R$col == cell[2] & R$name == "first", "value"] <- pair[1]
  R[R$row == cell[1] & R$col == cell[2] & R$name == "second", "value"] <- pair[2]
  return(R)
}