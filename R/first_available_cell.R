# try to find a home for pair in P
first_available_cell <- function(P, pair) {
  
  E <- empty_cells(P)
  
  # iterate through the empty cells in a random order
  for(cell in sample(E, length(E))) {
    
    if(avail(P, pair, cell)) {
      return(c(cell[1], cell[2]))
    }
    
  }
}