remove_if_exists <- function(P, p) {
  x <- match(list(p), P)
  if(!is.na(x)) {
    P <- P[-match(list(p), P)]
  }
  return(P)
}

remove_all_if_exist <- function(P, Q) {
  for(q in Q) {
    P <- remove_if_exists(P, q)
  }
  return(P)
}