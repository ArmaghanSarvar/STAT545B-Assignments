STAT545B Assignment B2
================
Armaghan Sarvar

# Package Description

**Package name:** Stat545ArmaghanSarvar

**Package latest version:** 0.1.0

The `Stat545ArmaghanSarvar` package is made by Armaghan Sarvar for the
STAT545B course at the University of British Columbia. The main goal of
this package is to make data analysis more efficient for different R
users. This package provides a function named `my_function` that
computes summary statistics range, mean, standard deviation and median
of a variable across the groups of another variable from an input
dataset in the datateachr package.

## Installation Instructions

The released development version of the `Stat545ArmaghanSarvar` package
can be installed by running:

``` r
# install.packages("devtools")
devtools::install_github("ArmaghanSarvar/STAT545B-Assignments/Stat545ArmaghanSarvar/")
```

Then, you can load the package with:

``` r
library("Stat545ArmaghanSarvar")
```

Note that once the package is submitted to CRAN, the final released
version with the final installation instructions will become available.

## Usage Example

In the following, you can find some examples on the demonstrated usage
of the provided package. Note that the type of the first argument has to
be of the dataframe class, and also the `variable` input (the third
argument) is numeric. Finally, the length of the `feature` and
`variable` vectors should not be zero.

``` r
library(Stat545ArmaghanSarvar)

#' @example
# An example of the function ran on the flow_sample data set
my_function(datateachr::flow_sample, year, flow)
#> # A tibble: 109 × 6
#>     year `range(flow)[1]` `range(flow)[2]` `mean(flow)` `stats::median(flow)`
#>    <dbl>            <dbl>            <dbl>        <dbl>                 <dbl>
#>  1  1909            NA                  NA         NA                    NA  
#>  2  1910            NA                  NA         NA                    NA  
#>  3  1911             5.75              264        135.                  135. 
#>  4  1912             5.8               174         89.9                  89.9
#>  5  1913             6.12              232        119.                  119. 
#>  6  1914             7.16              214        111.                  111. 
#>  7  1915             6.94              236        121.                  121. 
#>  8  1916             6.97              309        158.                  158. 
#>  9  1917             6.06              174         90.0                  90.0
#> 10  1918             6.03              345        176.                  176. 
#> # … with 99 more rows, and 1 more variable: stats::sd(flow) <dbl>

#' @example
# An example of the function ran on the cancer_sample data set
my_function(datateachr::cancer_sample, diagnosis, area_mean)
#> # A tibble: 2 × 6
#>   diagnosis `range(area_mean… `range(area_mea… `mean(area_mean… `stats::median(…
#>   <chr>                 <dbl>            <dbl>            <dbl>            <dbl>
#> 1 B                      144.             992.             463.             458.
#> 2 M                      362.            2501              978.             932 
#> # … with 1 more variable: stats::sd(area_mean) <dbl>

#' @example
# An example of the function ran on the vancouver_trees data set
my_function(datateachr::vancouver_trees, genus_name, diameter)
#> # A tibble: 97 × 6
#>    genus_name  `range(diameter)[1]` `range(diameter)[2]` `mean(diameter)`
#>    <chr>                      <dbl>                <dbl>            <dbl>
#>  1 ABIES                          1                 42.5            12.9 
#>  2 ACER                           0                317              10.6 
#>  3 AESCULUS                       0                 64              23.7 
#>  4 AILANTHUS                      3                 21.5            15.9 
#>  5 ALBIZIA                        6                  6               6   
#>  6 ALNUS                          0                 40              17.5 
#>  7 AMELANCHIER                    0                 20               3.21
#>  8 ARALIA                         3                 12               6.81
#>  9 ARAUCARIA                      3                 32              11.4 
#> 10 ARBUTUS                        6                 33              18.4 
#> # … with 87 more rows, and 2 more variables: stats::median(diameter) <dbl>,
#> #   stats::sd(diameter) <dbl>
```
