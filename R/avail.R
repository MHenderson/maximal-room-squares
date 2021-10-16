avail <- function(R, p, e) {
  available <- R[R$row == e[1] & R$col == e[2], "avail"]$avail[[1]]
  p[1] %in% available && p[2] %in% available
}
