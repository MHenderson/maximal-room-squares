n_filled_cells <- function(R) {
  R |>
    dplyr::filter(!is.na(first)) |> 
    nrow()
}