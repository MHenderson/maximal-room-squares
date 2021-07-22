library(dplyr)
library(tictoc)

source("verify.R")

tic()

n <- 30

P <- expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
  mutate(cell_id = 1:((n - 1)^2)) %>%
  mutate(first = as.integer(NA), second = as.integer(NA)) %>%
  pivot_longer(first:second)

# for 1 .. 15
# choose pair in row i of X
# place it in the first available square (meaning no Room squares are violated)
#  i.e. place it in the next unfilled position, check the Room condition, if
#  violated then try next unfilled position
# if no square available, move onto next pair
X <- all_pairs(n - 1)

for(i in 1:nrow(X)) {
  
  print(i)
  print(paste("Volume: ", round(n_filled_cells(P)/choose(max(P$col) + 1, 2), 6)))
  
  E <- empty_cells(P)
  
  # candidate pair
  candidate_pair <- X[i, ]
  
  first_symbol <- candidate_pair[["first"]]
  second_symbol <- candidate_pair[["second"]]
    
  for(j in unique(E$cell_id)) {
    
    candidate_cell <- E[E$cell_id == j, ]
    
    cell_row <- candidate_cell[[1, "row"]]
    cell_col <- candidate_cell[[1, "col"]]
    
    row_used <- P[P$row == cell_row, ]$value
    col_used <- P[P$col == cell_col, ]$value
    
    used <- c(row_used, col_used)
    
    if(!(first_symbol %in% used) && !(second_symbol %in% used)) {
      P <- P %>%
        update(cell_row, cell_col, first_symbol, second_symbol)
      break()
    }
    
  }
}

toc()

paste("Volume: ", round(n_filled_cells(P)/choose(max(P$col) + 1, 2), 6))

