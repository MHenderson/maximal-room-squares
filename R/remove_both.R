remove_both <- function(X, p) {
  X <- X[-match(p[1], X)]
  X[-match(p[2], X)]
}