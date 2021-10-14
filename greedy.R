library(dplyr)
library(tictoc)

source("verify.R")

set.seed(55)

tic()

n <- 20

# the empty grid in tidy format
P <- expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
  mutate(cell_id = 1:((n - 1)^2)) %>%
  mutate(first = as.integer(NA), second = as.integer(NA)) %>%
  pivot_longer(first:second)

# all unordered pairs, in a random order
X <- sample_frac(all_pairs(n - 1), 1)
X <- map2(X$first, X$second, c)

# is cell available for pair
avail <- function(P, pair, cell) {
  
  # look in the first row of the candidate cell
  # data frame for the row index
  cell_row <- cell[1]
  # look in the first row of the candidate cell
  # data frame for the col index
  cell_col <- cell[2]
  
  # a vector of all symbols used in the row under consideration
  row_used <- P[P$row == cell_row, ]$value
  row_used <- row_used[!is.na(row_used)]
  # a vector of all symbols used in the column under consideration
  col_used <- P[P$col == cell_col, ]$value
  col_used <- col_used[!is.na(col_used)]
  
  # a vector of all symbols used in either the row or
  # column under consideration
  used <- c(row_used, col_used)
  
  #return(!(pair[["first"]] %in% used) && !(pair[["second"]] %in% used))
  return(!(pair[1] %in% used) && !(pair[2] %in% used))
}

# try to find a home for pair in P
first_available_cell <- function(P, pair) {
  
  # which cells are still empty?
  E <- empty_cells(P)
  E <- map2(E$row, E$col, c)
  
  # the ids of empty cells
  #cell_ids <- unique(E$cell_id)
  
  # iterate through the empty cells in a random order
  for(j in sample(1:length(E), length(E))) {
    
    # the candidate cell is actually a data frame
    # with two rows, on for the first symbol
    # and one row for the second symbol
    cell <- E[[j]]
    
    # if both the first and second symbols in the candidate pair
    # are missing from the row and column under consideration
    # the we update the Room square by putting the current
    # pair under consideration in the current cell under consideration
    # then we immediately exit the loop (do we?)
    if(avail(P, pair, cell)) {
      return(c(cell[1], cell[2]))
    }
    
  }
}

# given a partial room square P
# and a pair
# try to find a hole for that pair and fill it
update_first_available <- function(P, pair) {
  
  # try to find a hole
  x <- first_available_cell(P, pair)
  
  # if we were successful then fill that hole
  if(!is.null(x))  {
    P <- update(P, x[1], x[2], pair[1], pair[2])
  }
  
  print(paste("Symbol: ", i, "Volume: ", round(n_filled_cells(P)/choose(max(P$col) + 1, 2), 6)))
  
  return(P)
}

# go through each symbol and try to place it in a cell
#
# we would like to update P in place but I don't think
# that's possible?
for(i in 1:length(X)) {
  
  # candidate pair
  candidate_pair <- X[[i]]
  
  P <- update_first_available(P, candidate_pair)

}

toc()
