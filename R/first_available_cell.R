# try to find a home for pair in P
first_available_cell <- function(P, pair) {
  
  # which cells are still empty?
  E <- empty_cells(P)
  
  # iterate through the empty cells in a random order
  for(j in sample(1:length(E), length(E))) {
    
    # the candidate cell is actually a data frame
    # with two rows, on for the first symbol
    # and one row for the second symbol
    cell <- E[[j]]
    
    # if both the first and second symbols in the candidate pair
    # are missing from the row and column under consideration
    # the we update the Room square by putting the current
    # pair under consideration in the current cell under consideration
    # then we immediately exit the loop (do we?)
    if(avail(P, pair, cell)) {
      return(c(cell[1], cell[2]))
    }
    
  }
}