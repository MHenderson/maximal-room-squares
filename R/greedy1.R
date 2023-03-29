greedy1 <- function(n) {
  
  R <- empty_room(n) %>% mutate(avail = list(0:(n - 1)))
  
  # pairs to be used in order
  P <- not_used_pairs(R)
  # empty cells to be visited in order
  E <- empty_cells(R)

  for(e in E) {
    
    # these symbols are available
    available <- R[R$row == e[1] & R$col == e[2], "avail"]$avail[[1]]
    
    # iterate through un-used pairs in given order
    for(p in P) {
      
      # if empty cell e is suitable for pair p
      # then:
      # 1. assign p to cell e
      # 2. remove e from the list of empty cells
      # 3. remove p from the list of pairs
      # 4. remove both elements of p from lists of symbols missing in row e[1]
      # 5. remove both elements of p from lists of symbols missing in col e[2]
      # 6. stop
      if(p[1] %in% available && p[2] %in% available) {
        
        # 1. assign p to cell e,
        R[R$row == e[1] & R$col == e[2], "first"] <- p[1]
        R[R$row == e[1] & R$col == e[2], "second"] <- p[2]
        
        # 2. remove cell e from the list of empty cells
        E <- E[-match(list(e), E)]
        # 3. remove cell p from the list of pairs
        P <- P[-match(list(p), P)]
        
        # 4. remove both elements of p from lists of available symbols in row e[1]
        R[R$row == e[1], "avail"]$avail <- lapply(R[R$row == e[1], "avail"]$avail, remove_both, p)
        # 5. remove both elements of p from lists of available symbols in col e[2]
        R[R$col == e[2], "avail"]$avail <- lapply(R[R$col == e[2], "avail"]$avail, remove_both, p)
        
        # 6. stop
        break()
      }
      
    }
    
  }
  
  return(R %>% select(-avail))
}