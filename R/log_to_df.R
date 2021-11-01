log_to_df <- function(X, row_, col_, available_, Pe_, first_, second_, fill_, iter_, branch_) {
  X <- X %>%
    bind_rows(
      tribble(  ~row,   ~col,      ~available, ~Pe, ~first, ~second, ~fill, ~iter, ~branch,
                row_, col_, available_,  Pe_, first_, second_,  fill_, iter_, branch_)
    )
  return(X)
}