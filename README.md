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

Let *n* denote the order of the partial Room square. Let
*S* = {0, …, *n* − 1}. Let $P = {S \\choose 2}$.

Let *U*(*R*) denote the subset of *P* used in *R*. Let
*M*(*R*) = *P* ∖ *U*(*R*) denote the subset of *P* missing from *R*.

If *e* is an empty cell in a partial Room square *R* then by
*S*(*e*, *R*) we denote the subset of *S* *seen* by *e*. A symbol is
seen by an empty cell *e* if it appears in the same row or column as
*e*.

For now we’ll just live without special notation for
*S* ∖ *S*(*e*, *R*): the subset of symbols not seen by *e*.

We also talk about the subset $S \\backslash S(e, R) \\choose 2$: the
subset of all pairs that can be made from symbols not seen by *e*.

Notice that it is possible for $S \\backslash S(e, R) \\choose 2$ to
have non-empty intersections with both *U*(*R*) and *M*(*R*). In other
words those pairs that are available for an empty cell when considering
only the symbols in the same row or column may or may not already appear
somewhere in R.

# Algorithms

## I: greedy1

`greedy1` is described in Meszka and Rosa (2021).

`greedy1` visits all cells in order placing into the next cell the first
available pair not violating the conditions of being a partial Room
square.

``` r
# the order of maximal partial Room square we are looking for
n <- 10

tic()
R <- expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
  mutate(first = as.integer(NA), second = as.integer(NA)) %>%
  mutate(avail = list(0:(n - 1))) %>%
  greedy1()
toc()
#> 0.229 sec elapsed
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
# iterate through pairs in given order
R <- expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
  mutate(first = as.integer(NA), second = as.integer(NA)) %>%
  mutate(avail = list(0:(n - 1))) %>%
  greedy2()
toc()
#> 0.438 sec elapsed
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
pair *p* = {*x*, *y*} in
$M(R\_t) \\cap S \\backslash {S(e, R\_t) \\choose 2}$. In other words
the first pair that is compatible with the empty cell which hasn’t
already been used in *R*<sub>*t*</sub>

After filling an empty cell the global set of available pairs is
updated: *U*(*R*<sub>*t* + 1</sub>) ← *U*(*R*<sub>*t*</sub>) ∖ *p*

As are the sets of symbols not seen by empty cells *e*′ lying in the
same row or column as *e*:
*S* ∖ *S*(*e*′, *R*<sub>*t* + 1</sub>) ← *S*(*e*, *R*) ∖ *x* and
*S* ∖ *S*(*e*′, *R*<sub>*t* + 1</sub>) ← *S*(*e*, *R*) ∖ *y*.

``` r
n <- 10

tic()
R <- expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
  mutate(first = as.numeric(NA), second = as.numeric(NA)) %>%
  mutate(avail = list(1:n)) %>%
  greedy3()
toc()
#> 0.302 sec elapsed
```

``` r
# is R a maximal partial Room square?
is_maximal_proom(R)
#> [1] TRUE
```

![](figure/greedy3_plot-1.png)<!-- -->

## IV: greedy4: Track available pairs

`greedy4` is a modification of `greedy3`.

`greedy4` visits cells in order placing into the next cell the first
available cell from
$M(R\_t) \\cap S \\backslash {S(e, R\_t) \\choose 2}$.

The difference is that instead of calculating
$T(R\_t, e) := M(R\_t) \\cap S \\backslash {S(e, R\_t) \\choose 2}$ at
each step we keep track of it as cells are filled.

This means initialising $T(R\_t, e) \\leftarrow {S \\choose 2}$ at the
beginning and then after filling an empty cell *e* with
*p* = {*x*, *y*}:

-   removing every pair *p*′ containing either *x* or *y* from all lists
    of available pairs *e*′ in the same row or column as *e*:
    *T*(*R*<sub>*t* + 1</sub>, *e*′) ← *T*(*R*<sub>*t*</sub>, *e*′) ∖ *p*′
-   removing *p* from the list of available pairs for every other empty
    cell *e*′:
    *T*(*R*<sub>*t* + 1</sub>, *e*′) ← *T*(*R*<sub>*t*</sub>, *e*′) ∖ *p*

``` r
n <- 10

tic()
R <- expand_grid(row = 1:(n - 1), col = 1:(n - 1)) %>%
  mutate(first = as.numeric(NA), second = as.numeric(NA)) %>%
  mutate(Pe = list(combn(as.numeric(0:(n - 1)), 2, simplify = FALSE))) %>%
  greedy4()
toc()
#> 0.949 sec elapsed
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
