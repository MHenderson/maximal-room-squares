not_used_pairs <- function(R) {
  n <- max(R$row) + 1
  # find the pairs already used
  used_pairs <- R |> dplyr::select(first, second)
  # construct the set of pairs not used (namely all pairs minus used pairs)
  x <- combn(0:(n-1), 2)
  
  all_pairs <- tibble::tibble(
     first = x[1,],
    second = x[2,]
  )
  
  dplyr::anti_join(all_pairs, used_pairs, by = c("first", "second")) |>
    dplyr::mutate(ffs = purrr::map2(first, second, c)) |>
    dplyr::pull(ffs)
}