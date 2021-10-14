is_maximal_room <- function(R) {
 
  result <- TRUE
  
  # iterate through the set of unusued pairs trying to place them
  # return true if and only if no pairs can be placed
  for(p in not_used_pairs(R)) {
    
    # try to find a hole
    x <- first_available_cell(R, p)
    
    # if we were successful then fill that hole
    if(!is.null(x))  {
      result <- FALSE
      break()
    }
    
  }
  
  return(result && is_partial_room(R))
}