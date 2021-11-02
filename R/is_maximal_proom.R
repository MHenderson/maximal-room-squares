is_maximal_proom <- function(R) {
 
  result <- is_partial_room(R)
  
  R <- R %>%
    mutate(
      see = map2(row, col, see2, R = R)
    ) %>%
    mutate(
      avail = map(see, setdiff, x = 0:9)
    )
  
  # iterate through the set of unusued pairs trying to place them
  # return true if and only if no pairs can be placed
  for(p in not_used_pairs(R)) {
   
    E <- empty_cells(R) 
    # try to find a hole
    x <- NULL
    
    # iterate through empty cells in given order
    for(cell in E) {
      
      if(avail(R, p, cell)) {
        x <- cell
      }
      
    }
    
    # if we were successful then this is not a maximal proom
    if(!is.null(x))  {
      result <- FALSE
      break()
    }
    
  }
  
  return(result)
}