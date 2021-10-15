
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
# i'd like to visit them in order 1,2 3,4 5,6 7,8 etc ...
# so we see every symbol as quickly as possible
# probably easier to work with the data frame representation
P <- not_used_pairs(R)
P <- P[order(sapply(P, diff), decreasing = TRUE)]

# go through all of the pairs that haven't yet been
# used in R (all of them, in this case) and try to
# place them in an empty cell x. if a suitable x is
# found then update R.
tic()
for(p in P) {
  
  # cells to be visited in order
  E <- empty_cells(R)
  
  # an example of a different ordering,
  # based on distance from main diagonal
  # visiting those cells closest to the
  # main diagonal first
  E <- E[order(sapply(sapply(E, diff), abs), decreasing = TRUE)]

  # provisional available cell
  x <- NULL
  
  # iterate through empty cells in given order
  for(cell in E) {
    
    if(avail(R, p, cell)) {
      x <- cell
      break()
    }
    
  }
  
  # if an available cell x is found then update R by placing p in x
  if(!is.null(x))  {
    R <- update_(R, x, p)
  }
  
}
toc()
#> 0.191 sec elapsed
```

``` r
# is R a maximal partial Room square?
is_maximal_proom(R)
#> [1] TRUE
```

![](figure/plot-1.png)<!-- -->
