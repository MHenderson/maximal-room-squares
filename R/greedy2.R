greedy2 <- function(R) {
  # pairs to be used in order
  P <- not_used_pairs(R)
  # empty cells to be visited in order
  E <- empty_cells(R)
  for(p in P) {
    
    # iterate through empty cells in given order
    for(e in E) {
      
      # these symbols are available
      available <- R[R$row == e[1] & R$col == e[2], "avail"]$avail[[1]]
      
      # if empty cell e is suitable for pair p
      # then:
      # assign p to cell e,
      # remove cell e from the list of empty cells
      # remove cell p from the list of pairs
      # remove both elements of p from lists of symbols missing in row e[1]
      # remove both elements of p from lists of symbols missing in col e[2]
      # and stop
      if(p[1] %in% available && p[2] %in% available) {
        
        # assign p to cell e,
        R[R$row == e[1] & R$col == e[2], "first"] <- p[1]
        R[R$row == e[1] & R$col == e[2], "second"] <- p[2]
        
        # remove cell e from the list of empty cells
        E <- E[-match(list(e), E)]
        # remove cell p from the list of pairs
        P <- P[-match(list(p), P)]
        
        # remove both elements of p from lists of available symbols in row e[1]
        R[R$row == e[1], "avail"]$avail <- lapply(R[R$row == e[1], "avail"]$avail, remove_both, p)
        # remove both elements of p from lists of available symbols in col e[2]
        R[R$col == e[2], "avail"]$avail <- lapply(R[R$col == e[2], "avail"]$avail, remove_both, p)
        
        break()
      }
      
    }
    
  }
  return(R)
}