greedy3 <- function(R, P = not_used_pairs(R), E = empty_cells(R)) {
  
  # log the available elements and pairs at each step
  # init_basic_log
  X <- tribble(~row, ~col, ~available, ~Pe, ~first, ~second, ~fill, ~iter, ~branch)
  
  i <- 0
  
  for(e in E) {
    
    # these symbols are available
    available <- R[R$row == e[1] & R$col == e[2], "avail"]$avail[[1]]
    
    # if there are fewer than 2 available symbols then move to the next empty cell
    # branch "fewer than 2 available symbols"
    if(length(available) < 2) {
      # update_basic_log
      X <- X %>% log_to_df(e[1], e[2], list(available),  NA, NA, NA, FALSE, i, "less than 2 available symbols")
      # update_full_log
      next()
    }
    
    # if every symbol is available then the list of pairs available
    # for this cell is the same as the list of globally avaiable pairs
    # otherwise we only consider those pairs made from subsets of
    # available symbols.
    # this is a tiny optimisation and might not even be worth bothering with
    if(length(available)==max(R$row) + 1) {
      Pe <- P
    } else {
      Pe <- intersect_G(P, combn(available, 2, simplify = FALSE))
    }
    
    # if there are none then move to the next empty cell
    # branch "only available pairs already used"
    if(length(Pe) < 1) {
      # update_basic_log
      X <- X %>% log_to_df(e[1], e[2], list(available), NA, NA, NA, FALSE, i, "only available pairs already used")
      # update_full_log
      next()
    }
    
    # choose the first suitable pair
    p <- Pe[[1]]
    
    # branch "assign"
    X <- X %>% log_to_df(e[1], e[2],  available,  Pe, p[1], p[2],  TRUE, i, "assign")
    
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
    
    i <- i + 1
    
  }
  return(list(R, X))
}