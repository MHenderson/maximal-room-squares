update_ <- function(R, i, j, first_, second_) {
  R[R$row == i & R$col == j & R$name == "first", "value"] <- first_
  R[R$row == i & R$col == j & R$name == "second", "value"] <- second_
  return(R)
}