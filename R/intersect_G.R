intersect_g <- function(X, Y) {
  igraph::as_edgelist(
    igraph::graph.intersection(
      igraph::graph_from_edgelist(X, directed = FALSE),
      igraph::graph_from_edgelist(Y, directed = FALSE)
    )
  )
}

intersect_G <- function(x, y) {
  xx <- intersect_g(t(mapply(c, x)), t(mapply(c, y)))
  xx <- unlist(apply(xx, 1, list), recursive = FALSE)
  xx[order(match(xx, x))]
}
