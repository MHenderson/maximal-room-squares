log_to_df <- function(X, i_, j_, available_, Pe_, fill_) {
  X <- X %>%
    bind_rows(
      tribble(  ~i,   ~j,      ~available, ~Pe, ~fill,
                i_, j_, available_,  Pe_, fill_)
    )
  return(X)
}