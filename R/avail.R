# is cell available for pair
avail <- function(P, pair, cell) {
  
  # a vector of all symbols used in the row under consideration
  row_used <- P[P$row == cell[1], ]$value
  row_used <- row_used[!is.na(row_used)]
  # a vector of all symbols used in the column under consideration
  col_used <- P[P$col == cell[2], ]$value
  col_used <- col_used[!is.na(col_used)]
  
  # a vector of all symbols used in either the row or
  # column under consideration
  used <- c(row_used, col_used)
  
  # return value is true if and only if both symbols
  # are not in the symbols used
  return(!(pair[1] %in% used) && !(pair[2] %in% used))
}