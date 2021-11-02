see <- function(R, e) {
  first <- R[R$row == e[1] | R$col == e[2], "first"]$first
  first_non_na <- first[!is.na(first)]
  second <- R[R$row == e[1] | R$col == e[2], "second"]$second
  second_non_na <- second[!is.na(second)]
  sort(unique(c(first_non_na, second_non_na)))
}

see2 <- function(R, row, col) {
  first <- R[R$row == row | R$col == col, "first"]$first
  first_non_na <- first[!is.na(first)]
  second <- R[R$row == row | R$col == col, "second"]$second
  second_non_na <- second[!is.na(second)]
  sort(unique(c(first_non_na, second_non_na)))
}
