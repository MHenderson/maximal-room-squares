library(dplyr)

source("verify.R")

n <- 12

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
  E <- empty_cells(P)
  for(j in unique(E$cell_id)) {
    
    # candidate cell
    c1 <- E %>% filter(cell_id == j)
    # candidate pair
    p1 <- X[i, ]
    
    # provisionally update
    PP <- P %>%
      update(c1[[1, "row"]], c1[[1, "col"]], p1[["first"]], p1[["second"]])
    
    # if room conditions hold then really update
    if(is_row_latin_i(PP, c1[["row"]]) && is_col_latin_i(PP, c1[["col"]])) {
      P <- PP
      break()
    }

  }
}

paste("Volume: ", round(n_filled_cells(P)/choose(max(P$col) + 1, 2), 6))

