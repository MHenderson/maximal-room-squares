avail <- function(R, p, e) {
  p[1] %in% R[R$row == e[1] & R$col == e[2], "missing_row"]$missing_row[[1]] &&
    p[1] %in% R[R$row == e[1] & R$col == e[2], "missing_col"]$missing_col[[1]] &&
    p[2] %in% R[R$row == e[1] & R$col == e[2], "missing_row"]$missing_row[[1]] &&
    p[2] %in% R[R$row == e[1] & R$col == e[2], "missing_col"]$missing_col[[1]]
}
