# given a partial room square P
# and a pair
# try to find a hole for that pair and fill it
update_first_available <- function(P, pair) {
  
  # try to find a hole
  x <- first_available_cell(P, pair)
  
  # if we were successful then fill that hole
  if(!is.null(x))  {
    P <- update_(P, x[1], x[2], pair[1], pair[2])
  }
  
  print(paste0("Pair: ", "(", x[1], x[2], ")", " Volume: ", round(n_filled_cells(P)/choose(max(P$col) + 1, 2), 6)))
  
  return(P)
}