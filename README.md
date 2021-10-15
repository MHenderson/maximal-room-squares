
<!-- README.md is generated from README.Rmd. Please edit that file -->

# maximal-room-squares

<!-- badges: start -->
<!-- badges: end -->

``` r
library(dplyr)
library(tictoc)

# the order of Room square we are looking for
n <- 10

# a data frame representing an empty Room square
# of the desired order
R <- expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
  mutate(first = as.integer(NA), second = as.integer(NA)) %>%
  pivot_longer(first:second)

# pairs to be used in order
P <- not_used_pairs(R)
P <- P[order(sapply(P, diff), decreasing = TRUE)]

# empty cells to be visited in order
E <- empty_cells(R)
E <- E[order(sapply(sapply(E, diff), abs), decreasing = TRUE)]

tic()
# iterate through un-used pairs in given order
for(p in P) {
  
  # iterate through empty cells in given order
  for(i in 1:length(E)) {
    
    # if empty cell E[[i]] is suitable for pair p
    # then:
    # assign p to cell E[[i]],
    # remove cell E[[i]] from the list of empty cells
    # and stop
    if(avail(R, p, E[[i]])) {
      R <- update_(R, E[[i]], p)
      E <- E[-i]
      break()
    }
    
  }
  
}
toc()
#> 0.133 sec elapsed
```

``` r
# is R a maximal partial Room square?
is_maximal_proom(R)
#> [1] TRUE
```

![](figure/plot-1.png)<!-- -->
