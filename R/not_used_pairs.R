not_used_pairs <- function(R) {
  n <- max(R$row) + 1
  # find the pairs already used
  used_pairs <- R %>% pivot_wider() %>% filter(!is.na(first)) %>% select(first, second)
  # construct the set of pairs not used (namely all pairs minus used pairs)
  x <- combn(0:(n-1), 2)
  
  all_pairs <- tibble(
    first = x[1,],
    second = x[2,]
  )
  
  anti_join(all_pairs, used_pairs, by = c("first", "second")) %>%
    mutate(ffs = map2(first, second, c)) %>%
    pull(ffs)
}