Generating Maximal Partial Room Squares in R
================
Matthew Henderson

-   [Notation](#notation)
-   [Algorithms](#algorithms)
    -   [I: greedy1](#i-greedy1)
    -   [II: greedy2](#ii-greedy2)
    -   [III: greedy3: Calculate available
        pairs](#iii-greedy3-calculate-available-pairs)
    -   [IV: greedy4: Track available
        pairs](#iv-greedy4-track-available-pairs)
-   [References](#references)

<!-- README.md is generated from README.Rmd. Please edit that file -->

Four different greedy procedures for building maximal partial Room
squares in R inspired by Meszka and Rosa (2021).

# Notation

Let $n$ denote the order of the partial Room square. Let
$S = \{0, \ldots, n - 1\}$. Let $P = {S \choose 2}$.

Let $U(R)$ denote the subset of $P$ used in $R$. Let
$M(R) = P \backslash U(R)$ denote the subset of $P$ missing from $R$.

If $e$ is an empty cell in a partial Room square $R$ then by $S(e, R)$
we denote the subset of $S$ *seen* by $e$. A symbol is seen by an empty
cell $e$ if it appears in the same row or column as $e$.

So $S \backslash S(e, R)$ is the subset of symbols not seen by $e$ and
$S \backslash S(e, R) \choose 2$ is the subset of all pairs made from
symbols not seen by $e$.

Notice that it is possible for $S \backslash S(e, R) \choose 2$ to have
non-empty intersections with both $U(R)$ and $M(R)$. In other words
those pairs that are available for an empty cell when considering only
the symbols in the same row or column may or may not already appear
somewhere in R.

# Algorithms

## I: greedy1

`greedy1` is described in Meszka and Rosa (2021).

`greedy1` visits all cells in order placing into the next cell the first
available pair not violating the conditions of being a partial Room
square.

``` r
n <- 10

tic()
R <- greedy1(n)
toc()
#> 0.192 sec elapsed
```

``` r
# is R a maximal partial Room square?
is_maximal_proom(R)
#> [1] TRUE
```

![](figure/greedy1_plot-1.png)<!-- -->

## II: greedy2

`greedy2` is also described in (Meszka and Rosa (2021)).

`greedy2` iterates through all pairs in order placing the next pair in
the first available cell not violating the conditions of being a partial
Room square.

``` r
n <- 10

tic()
R <- greedy2(n)
toc()
#> 0.307 sec elapsed
```

``` r
# is R a maximal partial Room square?
is_maximal_proom(R)
#> [1] TRUE
```

![](figure/greedy_2_plot-1.png)<!-- -->

## III: greedy3: Calculate available pairs

`greedy3` is a modification of `greedy1`.

`greedy3` visits all cells in order placing into the next cell the first
pair $p = \{x, y\}$ in $M(R_t) \cap S \backslash {S(e, R_t) \choose 2}$.
In other words the first pair that is compatible with the empty cell
which hasn’t already been used in $R_t$

After filling an empty cell the global set of available pairs is
updated: $U(R_{t + 1}) \leftarrow U(R_t)\backslash p$

As are the sets of symbols not seen by empty cells $e\prime$ lying in
the same row or column as $e$:
$S\backslash S(e\prime, R_{t + 1}) \leftarrow S(e, R) \backslash {x}$
and
$S\backslash S(e\prime, R_{t + 1}) \leftarrow S(e, R) \backslash {y}$.

``` r
n <- 10

tic()
R <- greedy3(n)
toc()
#> 0.263 sec elapsed
```

``` r
# is R a maximal partial Room square?
is_maximal_proom(R)
#> [1] FALSE
```

![](figure/greedy3_plot-1.png)<!-- -->

## IV: greedy4: Track available pairs

`greedy4` is a modification of `greedy3`.

`greedy4` visits cells in order placing into the next cell the first
available cell from $M(R_t) \cap S \backslash {S(e, R_t) \choose 2}$.

The difference is that instead of calculating
$T(R_t, e) := M(R_t) \cap S \backslash {S(e, R_t) \choose 2}$ at each
step we keep track of it as cells are filled.

This means initialising $T(R_t, e) \leftarrow {S \choose 2}$ at the
beginning and then after filling an empty cell $e$ with $p = \{x, y\}$:

-   removing every pair $p\prime$ containing either $x$ or $y$ from all
    lists of available pairs $e\prime$ in the same row or column as $e$:
    $T(R_{t + 1}, e\prime) \leftarrow T(R_t, e\prime)\backslash p\prime$
-   removing $p$ from the list of available pairs for every other empty
    cell $e\prime$:
    $T(R_{t + 1}, e\prime) \leftarrow T(R_t, e\prime)\backslash p$

``` r
n <- 14

tic()
R <- greedy4(14)
toc()
#> 4.249 sec elapsed
```

``` r
# is R a maximal partial Room square?
is_maximal_proom(R)
#> [1] TRUE
```

![](figure/greedy4_plot-1.png)<!-- -->

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-meszkaMaximalPartialRoom2021" class="csl-entry">

Meszka, Mariusz, and Alexander Rosa. 2021. “Maximal Partial Room
Squares.” *Journal of Combinatorial Designs* 29 (7): 482–501.
<https://doi.org/10.1002/jcd.21777>.

</div>

</div>
