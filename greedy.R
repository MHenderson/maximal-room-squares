library(dplyr)
library(tictoc)

source("verify.R")
source("R/all_pairs.R")
source("R/avail.R")
source("R/empty_cells.R")
source("R/update.R")
source("R/first_available_cell.R")
source("R/update_first_available.R")

set.seed(55)

tic()

n <- 10

# the empty grid in tidy format
P <- expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
  mutate(first = as.integer(NA), second = as.integer(NA)) %>%
  pivot_longer(first:second)

# all unordered pairs, in a random order
X <- sample_frac(all_pairs(n - 1), 1)
X <- map2(X$first, X$second, c)

# go through each symbol and try to place it in a cell
#
# we would like to update P in place but I don't think
# that's possible?
for(x in X) {
  
  P <- update_first_available(P, x)

}

is_partial_room(P)

toc()
