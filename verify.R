library(dplyr)
library(purrr)
library(tidyr)

is_row_latin_i <- function(R, i, S = 0:max(R$row, na.rm = TRUE)) {
  u <- R[R$row == i, "value"]$value
  u <- u[!is.na(u)]
  length(u) == length(unique(u))
}

is_col_latin_i <- function(R, i, S = 0:max(R$col, na.rm = TRUE)) {
  u <- R[R$col == i, "value"]$value
  u <- u[!is.na(u)]
  length(u) == length(unique(u))
}

is_row_latin <- function(R) {
  all(map_lgl(1:max(R$row), is_row_latin_i, R = R))
}

is_col_latin <- function(R) {
  all(map_lgl(1:max(R$col), is_col_latin_i, R = R))
}

distinct_pairs <- function(R) {
  R %>%
    pivot_wider() %>%
    filter(!is.na(first)) %>% 
    filter(!is.na(second)) %>%
    distinct(first, second)
}

n_filled_cells <- function(R) {
  R %>%
    filter(!is.na(value)) %>% 
    filter(name == "first") %>% 
    nrow()
}

is_room <- function(R) {
  expected_number_of_distinct_pairs <- choose(max(R$col) + 1, 2)
  nfc <- n_filled_cells(R)
  is_row_latin(R) && 
    is_col_latin(R) && 
    n_filled_cells(R) <= expected_number_of_distinct_pairs &&
    nrow(distinct_pairs(R)) == nfc
}

update <- function(R, i, j, first_, second_) {
  R[R$row == i & R$col == j & R$name == "first", "value"] <- first_
  R[R$row == i & R$col == j & R$name == "second", "value"] <- second_
  return(R)
}

empty_cells <- function(R) {
  R %>%
    filter(is.na(value))
}

all_pairs <- function(n) {
  
  x <- combn(0:n, 2)
  
  tibble(
    first = x[1,],
    second = x[2,]
  )
  
}