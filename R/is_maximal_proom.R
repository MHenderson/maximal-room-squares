is_maximal_proom <- function(R) {
 
  result <- is_partial_room(R)
  
  # iterate through the set of unusued pairs trying to place them
  # return true if and only if no pairs can be placed
  for(p in not_used_pairs(R)) {
    
    # try to find a hole
    x <- first_available_cell(R, p)
    
    # if we were successful then this is not a maximal proom
    if(!is.null(x))  {
      result <- FALSE
      break()
    }
    
  }
  
  return(result)
}