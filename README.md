
<!-- README.md is generated from README.Rmd. Please edit that file -->

# maximal-room-squares

<!-- badges: start -->
<!-- badges: end -->

``` r
library(dplyr)

set.seed(55)

n <- 8

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
#> 6, 4, 5, 6, 0.035714
#> 3, 7, 3, 5, 0.071429
#> 7, 6, 0, 3, 0.107143
#> 5, 4, 1, 7, 0.142857
#> 4, 2, 0, 1, 0.178571
#> 7, 5, 1, 6, 0.214286
#> 1, 3, 4, 5, 0.25
#> 7, 3, 2, 7, 0.285714
#> 6, 5, 0, 2, 0.321429
#> 2, 1, 0, 6, 0.357143
#> 2, 5, 5, 7, 0.392857
#> 1, 7, 0, 7, 0.428571
#> 6, 1, 3, 4, 0.464286
#> , , 0, 5, 0.464286
#> 5, 3, 3, 6, 0.5
#> 3, 4, 0, 4, 0.535714
#> 4, 4, 2, 3, 0.571429
#> 5, 6, 2, 5, 0.607143
#> , , 1, 5, 0.607143
#> 4, 7, 4, 6, 0.642857
#> 1, 2, 2, 6, 0.678571
#> 2, 6, 1, 4, 0.714286
#> , , 3, 7, 0.714286
#> , , 2, 4, 0.714286
#> 3, 1, 1, 2, 0.75
#> 3, 6, 6, 7, 0.785714
#> , , 1, 3, 0.785714
#> , , 4, 7, 0.785714
toc()
#> 0.456 sec elapsed
```

``` r
is_partial_room(R)
#> [1] TRUE
```

![](figure/plot-1.png)<!-- -->
