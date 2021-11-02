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
    
    # the available pairs in the same row or column as e 
    R_e <- R[R$row == e[1] | R$col == e[2], "Pe"]
    
    # remove every pair containing either element of p from all lists
    # of available pairs in the same row or column as e
    R[R$row == e[1] | R$col == e[2], "Pe"] <- list(map(R_e$Pe, remove_all_if_exist_G, p))
    
    # remove p from the list of available pairs for every remaining cell
    R <- R %>%
      mutate(
        Pe = map(Pe, remove_if_exists, p)
      )
    
  }

  return(R)
}