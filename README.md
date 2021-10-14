
<!-- README.md is generated from README.Rmd. Please edit that file -->

# maximal-room-squares

<!-- badges: start -->
<!-- badges: end -->

``` r
library(dplyr)

set.seed(55)

n <- 10

# the empty grid in tidy format
R <- expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
  mutate(first = as.integer(NA), second = as.integer(NA)) %>%
  pivot_longer(first:second)
```

``` r
P <- all_pairs(n - 1) %>%
  sample_frac(1) %>%
  mutate(
    pairs = map2(first, second, c)
  ) %>%
  pull(pairs)
```

``` r
library(tictoc)

tic()
# go through each symbol and try to place it in a cell
# this can be the basis of is_maximal
# i.e. run through this loop once and return true iff
# no more cells are filled during the loop. i.e. the
# empty cells after are precisely the empty cells before
for(p in P) {
  
  # try to find a hole
  x <- first_available_cell(R, p)
  
  # if we were successful then fill that hole
  if(!is.null(x))  {
    R <- update_(R, x, p)
  }
  
  csv_line <- paste(x[1], x[2], p[1], p[2], volume(R), sep = ", ")
  message(csv_line)
  
}
#> 4, 6, 3, 5, 0.022222
#> 5, 6, 4, 9, 0.044444
#> 5, 3, 0, 1, 0.066667
#> 3, 2, 1, 4, 0.088889
#> 5, 8, 3, 8, 0.111111
#> 1, 9, 4, 6, 0.133333
#> 2, 9, 0, 2, 0.155556
#> 3, 4, 5, 8, 0.177778
#> 6, 1, 4, 8, 0.2
#> 1, 1, 5, 7, 0.222222
#> 9, 9, 5, 9, 0.244444
#> 6, 7, 2, 7, 0.266667
#> 2, 5, 3, 9, 0.288889
#> 8, 2, 3, 7, 0.311111
#> 2, 3, 4, 7, 0.333333
#> 1, 4, 1, 9, 0.355556
#> 9, 8, 1, 7, 0.377778
#> 4, 2, 0, 8, 0.4
#> 8, 5, 5, 6, 0.422222
#> 7, 5, 1, 2, 0.444444
#> 3, 6, 2, 6, 0.466667
#> , , 7, 9, 0.466667
#> 6, 9, 1, 3, 0.488889
#> 3, 5, 0, 7, 0.511111
#> 2, 7, 1, 5, 0.533333
#> 4, 1, 1, 6, 0.555556
#> 4, 3, 2, 9, 0.577778
#> 5, 2, 2, 5, 0.6
#> 7, 9, 7, 8, 0.622222
#> 5, 4, 6, 7, 0.644444
#> 9, 4, 2, 4, 0.666667
#> 8, 7, 8, 9, 0.688889
#> 1, 7, 0, 3, 0.711111
#> 9, 3, 6, 8, 0.733333
#> 6, 2, 6, 9, 0.755556
#> , , 3, 4, 0.755556
#> , , 3, 6, 0.755556
#> , , 2, 8, 0.755556
#> 6, 8, 0, 5, 0.777778
#> , , 4, 5, 0.777778
#> 7, 1, 0, 9, 0.8
#> , , 1, 8, 0.8
#> , , 0, 4, 0.8
#> , , 2, 3, 0.8
#> , , 0, 6, 0.8
toc()
#> 0.674 sec elapsed
```

``` r
is_partial_room(R)
#> [1] TRUE
```
