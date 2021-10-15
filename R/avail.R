# is cell available for pair
avail <- function(P, pair, cell) {
  
  # a vector of all symbols used in the row under consideration
  row_used <- P[P$row == cell[1], ]$value
  row_used <- row_used[!is.na(row_used)]
  
  if((pair[1] %in% row_used) || (pair[2] %in% row_used)) {
    return(FALSE)
  } else {
    # a vector of all symbols used in the column under consideration
    col_used <- P[P$col == cell[2], ]$value
    col_used <- col_used[!is.na(col_used)]
    return(!(pair[1] %in% col_used) && !(pair[2] %in% col_used))
  }
  
}