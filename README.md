Generating Maximal Partial Room Squares in R
================
Matthew Henderson

-   [I: greedy1](#i-greedy1)
-   [II: greedy2](#ii-greedy2)
-   [Results](#results)
-   [References](#references)

<!-- README.md is generated from README.Rmd. Please edit that file -->

Two different greedy procedures for building maximal partial Room
squares in R inspired by Meszka and Rosa (2021).

# I: greedy1

`greedy1` visits all cells in order placing into the next cell the first
available pair not violating the conditions of being a partial Room
square.

``` r
library(tictoc)

n <- 10

tic()
R <- greedy1(n)
toc()
#> 0.17 sec elapsed
```

![](figure/greedy1_example_plot-1.png)<!-- -->

``` r
# is R a maximal partial Room square?
is_maximal_proom(R)
#> [1] TRUE
```

# II: greedy2

`greedy2` iterates through all pairs in order placing the next pair in
the first available cell not violating the conditions of being a partial
Room square.

``` r
n <- 10

tic()
R <- greedy2(n)
toc()
#> 0.239 sec elapsed
```

![](figure/greedy2_example_plot-1.png)<!-- -->

``` r
# is R a maximal partial Room square?
is_maximal_proom(R)
#> [1] TRUE
```

# Results

``` r
targets::tar_read(results)
#> # A tibble: 12 × 5
#>        n name    value              n_filled_cells volume
#>    <int> <chr>   <list>                      <dbl>  <dbl>
#>  1    10 greedy1 <tibble [81 × 4]>              33  0.733
#>  2    10 greedy2 <tibble [81 × 4]>              37  0.822
#>  3    12 greedy1 <tibble [121 × 4]>             55  0.833
#>  4    12 greedy2 <tibble [121 × 4]>             50  0.758
#>  5    14 greedy1 <tibble [169 × 4]>             76  0.835
#>  6    14 greedy2 <tibble [169 × 4]>             74  0.813
#>  7    16 greedy1 <tibble [225 × 4]>            101  0.842
#>  8    16 greedy2 <tibble [225 × 4]>            104  0.867
#>  9    18 greedy1 <tibble [289 × 4]>            127  0.830
#> 10    18 greedy2 <tibble [289 × 4]>            131  0.856
#> 11    20 greedy1 <tibble [361 × 4]>            163  0.858
#> 12    20 greedy2 <tibble [361 × 4]>            151  0.795
```

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-meszkaMaximalPartialRoom2021" class="csl-entry">

Meszka, Mariusz, and Alexander Rosa. 2021. “Maximal Partial Room
Squares.” *Journal of Combinatorial Designs* 29 (7): 482–501.
<https://doi.org/10.1002/jcd.21777>.

</div>

</div>
