pairs_containing <- function(P, x) {
  P[map_lgl(map(P, `%in%`, x), ~.[1] | .[2])]
}