greedy3 <- function(R, X) {
  
  P <- not_used_pairs(R)
  
  E <- empty_cells(R)
  
  for(e in E) {
    
    # these symbols are available
    available <- R[R$row == e[1] & R$col == e[2], "avail"]$avail[[1]]
    
    # if there are fewer than 2 available symbols then move to the next empty cell
    if(length(available) < 2) {
      X <- X %>% log_to_df(e[1], e[2], list(available),  NA, FALSE)
      next()
    }
    
    # this is an issue because it can change the ordering
    # of pairs being visited. Why?
    # a tiny optimisation is possible: if available is
    # the whole set then we can just choose the first element of P
    # because P is certain to be a subset of all pairs
    # from available elements
    Pe <- intersect_G(P, combn(available, 2, simplify = FALSE))
    
    # if there are none then move to the next empty cell
    if(length(Pe) < 1) {
      X <- X %>% log_to_df(e[1], e[2], list(available), NA, FALSE)
      next()
    }
    
    X <- X %>% log_to_df(e[1], e[2],  available,  Pe,  TRUE)
    
    # X <- X %>%
    #   bind_rows(
    #     tribble(  ~i,   ~j, ~available, ~Pe, ~fill,
    #             e[1], e[2],  available,  combn(available, 2, simplify = FALSE),  TRUE)
    #     )
    
    # choose the first suitable pair
    p <- Pe[[1]]
    
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
    
  }
  return(list(R, X))
}