library(dplyr)
library(purrr)
library(tidyr)

is_row_latin_i <- function(R, i, S = 0:max(R$row, na.rm = TRUE)) {
  R <- R %>% pivot_longer(first:second)
  u <- R[R$row == i, "value"]$value
  u <- u[!is.na(u)]
  length(u) == length(unique(u))
}

is_col_latin_i <- function(R, i, S = 0:max(R$col, na.rm = TRUE)) {
  R <- R %>% pivot_longer(first:second)
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
    filter(!is.na(first)) %>% 
    nrow()
}

is_partial_room <- function(R) {
  expected_number_of_distinct_pairs <- choose(max(R$col) + 1, 2)
  nfc <- n_filled_cells(R)
  is_row_latin(R) && 
    is_col_latin(R) && 
    n_filled_cells(R) <= expected_number_of_distinct_pairs
}

# does this make sense?
is_room <- function(R) {
  nfc <- n_filled_cells(R)
  is_partial_room(R) && nrow(distinct_pairs(R)) == nfc
}
