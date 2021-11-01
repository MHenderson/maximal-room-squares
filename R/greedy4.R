# this works by tracking available pairs
greedy4 <- function(R, P = not_used_pairs(R), E = empty_cells(R)) {

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
    # remove cell p from the list of pairs
    P <- P[-match(list(p), P)]
    
    # remove every pair sharing a common symbol with p from the same row as e
    # remove every pair sharing a common symbol with p from the same column as e
    R <- R %>%
      mutate(
        Pe_p1 = map(Pe, pairs_containing, p[1]),
        Pe_p2 = map(Pe, pairs_containing, p[2])
      ) %>%
      mutate(
        Pe = case_when(
          row == e[1] | col == e[2] ~ map2(Pe, Pe_p1, remove_all_if_exist),
          TRUE ~ Pe
        )
      ) %>%
      mutate(
        Pe = case_when(
          row == e[1] | col == e[2] ~ map2(Pe, Pe_p2, remove_all_if_exist),
          TRUE ~ Pe
        )
      )
   
    # remove p from the list of available pairs for every remaining cell
    R <- R %>%
      mutate(
        Pe = map(Pe, remove_if_exists, p)
      )
    
  }
  return(R)
}