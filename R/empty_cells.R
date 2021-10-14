empty_cells <- function(R) {
  E <- R %>%
    filter(is.na(value), name == "first")
  E <- map2(E$row, E$col, c)
  return(E)
}