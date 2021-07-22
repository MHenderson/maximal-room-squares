library(dplyr)
library(tictoc)

source("verify.R")

tic()

n <- 10

P <- expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
  mutate(cell_id = 1:((n - 1)^2)) %>%
  mutate(first = as.integer(NA), second = as.integer(NA)) %>%
  pivot_longer(first:second)

X <- all_pairs(n - 1)

for(i in 1:nrow(X)) {
  
  E <- empty_cells(P)
  
  # candidate pair
  candidate_pair <- X[i, ]
  
  first_symbol <- candidate_pair[["first"]]
  second_symbol <- candidate_pair[["second"]]
  
  cell_ids <- unique(E$cell_id)
    
  for(j in sample(cell_ids, length(cell_ids))) {
    
    #print(paste("Cell: ", j))
    
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
  print(paste("Symbol: ", i, "Volume: ", round(n_filled_cells(P)/choose(max(P$col) + 1, 2), 6)))
}

toc()

paste("Volume: ", round(n_filled_cells(P)/choose(max(P$col) + 1, 2), 6))

