
<!-- README.md is generated from README.Rmd. Please edit that file -->

# maximal-room-squares

<!-- badges: start -->
<!-- badges: end -->

``` r
library(dplyr)

set.seed(55)

n <- 8

# an empty tidy room square grid
R <- expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
  mutate(first = as.integer(NA), second = as.integer(NA)) %>%
  pivot_longer(first:second)
```

``` r
library(tictoc)

tic()
# go through each symbol and try to place it in a cell
# this can be the basis of is_maximal
# i.e. run through this loop once and return true iff
# no more cells are filled during the loop. i.e. the
# empty cells after are precisely the empty cells before
for(p in combn(0:(n-1), 2, simplify = FALSE)) {
  
  # try to find a hole
  x <- first_available_cell(R, p)
  
  # if we were successful then fill that hole
  if(!is.null(x))  {
    R <- update_(R, x, p)
  }
  
  csv_line <- paste(x[1], x[2], p[1], p[2], volume(R), sep = ", ")
  message(csv_line)
  
}
#> 5, 3, 0, 1, 0.035714
#> 7, 7, 0, 2, 0.071429
#> 2, 2, 0, 3, 0.107143
#> 3, 4, 0, 4, 0.142857
#> 1, 1, 0, 5, 0.178571
#> 6, 6, 0, 6, 0.214286
#> 4, 5, 0, 7, 0.25
#> 2, 4, 1, 2, 0.285714
#> 1, 6, 1, 3, 0.321429
#> 7, 2, 1, 4, 0.357143
#> 3, 5, 1, 5, 0.392857
#> 4, 1, 1, 6, 0.428571
#> 6, 7, 1, 7, 0.464286
#> 5, 5, 2, 3, 0.5
#> 6, 1, 2, 4, 0.535714
#> 4, 6, 2, 5, 0.571429
#> 3, 2, 2, 6, 0.607143
#> 1, 3, 2, 7, 0.642857
#> 4, 7, 3, 4, 0.678571
#> 7, 3, 3, 5, 0.714286
#> , , 3, 6, 0.714286
#> 3, 1, 3, 7, 0.75
#> , , 4, 5, 0.75
#> 1, 5, 4, 6, 0.785714
#> 2, 6, 4, 7, 0.821429
#> 5, 7, 5, 6, 0.857143
#> , , 5, 7, 0.857143
#> 7, 4, 6, 7, 0.892857
toc()
#> 0.416 sec elapsed
```

``` r
is_partial_room(R)
#> [1] TRUE
```

![](figure/plot-1.png)<!-- -->
