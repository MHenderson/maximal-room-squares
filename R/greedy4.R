# this works by tracking available pairs
greedy4 <- function(R, E = empty_cells(R)) {

  for(e in E) {
    
    # these pairs are available
    Pe <- R[R$row == e[1] & R$col == e[2], "Pe"]$Pe[[1]]
    
    # if there are none then move to the next empty cell
    if(length(Pe) < 1) {
      next()
    }
    
    # choose the first suitable pair
    p <- Pe[[1]]
    
    # assign p to cell e,
    R[R$row == e[1] & R$col == e[2], "first"] <- p[1]
    R[R$row == e[1] & R$col == e[2], "second"] <- p[2]
    
    # remove cell e from the list of empty cells
    E <- E[-match(list(e), E)]
    
    # remove every pair containing elements of p from cells
    # in the same row or column as e
    R <- R %>%
      mutate(
        Pe = case_when(
          row == e[1] | col == e[2] ~ map(Pe, remove_all_if_exist_G, p),
          TRUE ~ Pe
        )
      )
   
    # remove p from the list of available pairs for every remaining cell
    R <- R %>%
      mutate(
        Pe = map(Pe, remove_if_exists, p)
      )
    
    # our implementation of is_maximal_proom currently depends upon the
    # lists of available symbols being accurate
    # remove both elements of p from lists of available symbols in row e[1]
    R[R$row == e[1], "avail"]$avail <- lapply(R[R$row == e[1], "avail"]$avail, remove_both, p)
    # remove both elements of p from lists of available symbols in col e[2]
    R[R$col == e[2], "avail"]$avail <- lapply(R[R$col == e[2], "avail"]$avail, remove_both, p)
    
  }

  return(R)
}