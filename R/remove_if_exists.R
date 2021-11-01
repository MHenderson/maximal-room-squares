remove_if_exists <- function(P, p) {
  x <- match(list(p), P)
  if(!is.na(x)) {
    P <- P[-match(list(p), P)]
  }
  return(P)
}

# P is a list of pairs
# Q is a list of symobls
remove_all_if_exist <- function(P, Q) {
  for(q in Q) {
    P <- remove_if_exists(P, q)
  }
  return(P)
}

remove_all_if_exist_G <- function(X, Y) {
  G1 <- igraph::graph_from_edgelist(X, directed = FALSE)
  G1 <- igraph::delete_vertices(G1, Y)
  igraph::as_edgelist(G1)
}

# this works
# remove_all_if_exist_G(t(mapply(c, R$Pe[[1]])), c(2, 3, 4))

# alas
# remove_all_if_exist_G(t(mapply(c, R$Pe[[1]])), c(2, 3, 4, 11))
