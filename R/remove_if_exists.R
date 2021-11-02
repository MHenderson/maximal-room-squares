# P is a list of pairs
# p is a pair
# returns P if p not in P and P - p if p in P
# a bit like the set operation P \ p
remove_if_exists <- function(P, p) {
  x <- match(list(p), P)
  if(!is.na(x)) {
    P <- P[-x]
  }
  return(P)
}

# P is a list of pairs
# Q is a list of pairs
# removes every pair of Q from P (if P contains that pair)
remove_all_if_exist <- function(P, Q) {
  for(q in Q) {
    P <- remove_if_exists(P, q)
  }
  return(P)
}

# X is a list of pairs
# Y is a list of symbols
# removes every pair from X that has a non-empty intersection with Y
remove_all_if_exist_G <- function(X, Y) {
  if(length(X) == 0) {
    return(list())
  }
  if(length(Y) == 0) { # return X, surely?
    return(X)
  }
  # unique symbols in Y that appear somewhere in X
  Ye <- intersect(Y, unique(unlist(X)))
  X_chr <- t(matrix(as.character(as.numeric(unlist(X))), ncol = length(X)))
  G1 <- igraph::graph_from_edgelist(X_chr, directed = FALSE)
  G1 <- igraph::delete_vertices(G1, as.character(Ye))
  if(igraph::gsize(G1) == 0) {
    return(list())
  } else {
    G1_num <- matrix(as.numeric(igraph::as_edgelist(G1)), ncol = 2)
    x <- unlist(apply(G1_num, 1, list), recursive = FALSE)
    # it's a shame that this sort is required because it takes a lot
    # of time
    return(lapply(x, sort)) 
  }
}
