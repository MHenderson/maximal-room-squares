all_pairs <- function(n) {
  
  x <- combn(0:n, 2)
  
  tibble(
    first = x[1,],
    second = x[2,]
  )
  
}