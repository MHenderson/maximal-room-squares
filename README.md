
<!-- README.md is generated from README.Rmd. Please edit that file -->

# maximal-room-squares

<!-- badges: start -->
<!-- badges: end -->

## I: Nested loops

``` r
library(dplyr)
library(tictoc)

# the order of Room square we are looking for
n <- 10

# a data frame representing an empty Room square
# of the desired order
R <- expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
  mutate(first = as.integer(NA), second = as.integer(NA)) %>%
  mutate(avail = list(0:(n - 1)))

# pairs to be used in order
P <- not_used_pairs(R)
P <- list(c(0, 1), c(0, 2), c(0, 3), c(0, 4), c(1, 2), c(1, 3), c(1, 5), c(2, 3), c(2, 6), c(4, 5), c(4, 6), c(4, 7), c(4, 8), c(4, 9), c(5, 6), c(5, 7), c(5, 8), c(5, 9), c(6, 7), c(6, 8), c(6, 9), c(7, 8), c(7, 9), c(8, 9))
#P <- P[order(sapply(P, diff), decreasing = TRUE)]

# empty cells to be visited in order
#E <- empty_cells(R)
E <- list(c(1, 1), c(2, 2), c(3, 3), c(4, 4), c(3, 4), c(4, 2), c(2, 3), c(5, 5), c(4, 3), c(1, 2), c(6, 6), c(7, 7), c(8, 8), c(9, 9), c(7, 8), c(9, 6), c(6, 9), c(8, 7), c(8, 9), c(9, 7), c(1, 4), c(2, 1), c(6, 8), c(7, 6))
#E <- E[order(sapply(sapply(E, diff), abs), decreasing = TRUE)]
```

``` r
tic()
# iterate through empty cells in given order
for(e in E) {
  
  # these symbols are available
  available <- R[R$row == e[1] & R$col == e[2], "avail"]$avail[[1]]

  # iterate through un-used pairs in given order
  for(p in P) {
    
    # if empty cell e is suitable for pair p
    # then:
    # assign p to cell e,
    # remove cell e from the list of empty cells
    # remove cell p from the list of pairs
    # remove both elements of p from lists of symbols missing in row e[1]
    # remove both elements of p from lists of symbols missing in col e[2]
    # and stop
    if(p[1] %in% available && p[2] %in% available) {

      # assign p to cell e,
      R[R$row == e[1] & R$col == e[2], "first"] <- p[1]
      R[R$row == e[1] & R$col == e[2], "second"] <- p[2]

      # remove cell e from the list of empty cells
      E <- E[-match(list(e), E)]
      # remove cell p from the list of pairs
      P <- P[-match(list(p), P)]

      # remove both elements of p from lists of available symbols in row e[1]
      R[R$row == e[1], "avail"]$avail <- lapply(R[R$row == e[1], "avail"]$avail, remove_both, p)
      # remove both elements of p from lists of available symbols in col e[2]
      R[R$col == e[2], "avail"]$avail <- lapply(R[R$col == e[2], "avail"]$avail, remove_both, p)

      break()
    }
    
  }
  
}
toc()
#> 0.13 sec elapsed
```

``` r
# is R a maximal partial Room square?
is_maximal_proom(R)
#> [1] TRUE
```

![](figure/plot-1.png)<!-- -->

## II: Calculate available pairs

``` r
# a data frame representing an empty Room square
# of the desired order
R <- expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
  mutate(first = as.integer(NA), second = as.integer(NA)) %>%
  mutate(avail = list(0:(n - 1)))

# pairs to be used in order
P <- not_used_pairs(R)
P <- P[order(sapply(P, diff), decreasing = TRUE)]

# empty cells to be visited in order
E <- empty_cells(R)
E <- E[order(sapply(sapply(E, diff), abs), decreasing = TRUE)]
```

``` r
tic()
# iterate through empty cells in given order
for(e in E) {
  
  # these symbols are available
  available <- R[R$row == e[1] & R$col == e[2], "avail"]$avail[[1]]
  
  # if there are fewer than 2 available symbols then move to the next empty cell
  if(length(available) < 2) { next() }
  
  # these are the available pairs
  # this possibly doesn't work
  Pe <- intersect(P, combn(available, 2, simplify = FALSE))
  
  # if there are none then move to the next empty cell
  if(length(Pe) < 1) { next() }

  # choose the first suitable pair
  p <- Pe[[1]]

  # assign p to cell e,
  R[R$row == e[1] & R$col == e[2], "first"] <- p[1]
  R[R$row == e[1] & R$col == e[2], "second"] <- p[2]

  # remove cell e from the list of empty cells
  E <- E[-match(list(e), E)]
  # remove cell p from the list of pairs
  P <- P[-match(list(p), P)]

  # remove both elements of p from lists of available symbols in row e[1]
  R[R$row == e[1], "avail"]$avail <- lapply(R[R$row == e[1], "avail"]$avail, remove_both, p)
  # remove both elements of p from lists of available symbols in col e[2]
  R[R$col == e[2], "avail"]$avail <- lapply(R[R$col == e[2], "avail"]$avail, remove_both, p)

}
toc()
#> 0.158 sec elapsed
```

``` r
# is R a maximal partial Room square?
is_maximal_proom(R)
#> [1] TRUE
```

![](figure/plot2-1.png)<!-- -->
