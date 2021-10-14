
<!-- README.md is generated from README.Rmd. Please edit that file -->

# maximal-room-squares

<!-- badges: start -->
<!-- badges: end -->

``` r
library(dplyr)
library(tictoc)

set.seed(55)

n <- 16

R <- expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
  mutate(first = as.integer(NA), second = as.integer(NA)) %>%
  pivot_longer(first:second)

tic()

while(!is_maximal_room(R)) {
  for(p in not_used_pairs(R)) {
  
  x <- first_available_cell(R, p)
  
  if(!is.null(x))  {
    R <- update_(R, x, p)
  }
  
  }
}

toc()
#> 2.093 sec elapsed
```

``` r
is_partial_room(R)
#> [1] TRUE
```

``` r
is_maximal_room(R)
#> [1] TRUE
```

![](figure/plot-1.png)<!-- -->
