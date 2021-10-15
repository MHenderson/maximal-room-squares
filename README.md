
<!-- README.md is generated from README.Rmd. Please edit that file -->

# maximal-room-squares

<!-- badges: start -->
<!-- badges: end -->

``` r
library(dplyr)
library(tictoc)

set.seed(55)

# the order of Room square we are looking for
n <- 16

# a data frame representing an empty Room square
# of the desired order
R <- expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
  mutate(first = as.integer(NA), second = as.integer(NA)) %>%
  pivot_longer(first:second)

# go through all of the pairs that haven't yet been
# used in R (all of them, in this case) and try to
# place them in an empty cell x. if a suitable x is
# found then update R.
tic()
for(p in not_used_pairs(R)) {
  
  # find an available cell x for p
  x <- first_available_cell(R, p)
  
  # if one exists then update R by placing p in x
  if(!is.null(x))  {
    R <- update_(R, x, p)
  }
  
}
toc()
#> 0.568 sec elapsed
```

``` r
# is R a maximal partial Room square?
is_maximal_proom(R)
#> [1] TRUE
```

![](figure/plot-1.png)<!-- -->
