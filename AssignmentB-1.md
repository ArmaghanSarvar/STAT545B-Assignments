Assignment B-1
================
Armaghan Sarvar

## Loading the the Necessary Packages

``` r
library(datateachr)  # provides 7 semi-tidy datasets
library(tidyverse)  # provides data analysis libraries
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──

    ## ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
    ## ✓ tibble  3.1.5     ✓ dplyr   1.0.7
    ## ✓ tidyr   1.1.4     ✓ stringr 1.4.0
    ## ✓ readr   2.0.2     ✓ forcats 0.5.1

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(testthat)
```

    ## 
    ## Attaching package: 'testthat'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     matches

    ## The following object is masked from 'package:purrr':
    ## 
    ##     is_null

    ## The following objects are masked from 'package:readr':
    ## 
    ##     edition_get, local_edition

    ## The following object is masked from 'package:tidyr':
    ## 
    ##     matches

# Exercise 1 and 2: Make a Function and Document it

-   making a function, fortifying and documenting it. \*

The implemented function computes the range, mean, standard deviation
and median of a variable across the groups of another variable from the
input dataset. I have also edited the implemented function so that it
includes conditions that check the input arguments. More specifically, I
first check the type of the first argument which has to be of the
dataframe class, and considering the fact that the `feature` input is
not limited to any criteria here, I also check whether the `variable`
input is numeric. Finally, I check whether the length of the `feature`
and `variable` vectors is not zero.

``` r
#' Using roxygen to document the function defined in the last section 
#' @title Statistical Measurements for a Dataset Variable
#' @description Computing the range, mean, median, and standard deviation of a variable across the groups of a feature from a dataset.
#' @param dataset: The Tibble or Dataframe that the function will look at in order to extract the above information
#' @param feature: The dataset column that we want to group the categories for
#' @param variable: The dataset column that we want to calculate statistics on
#' @return A tibble, showing the statistics calculated

my_function <- function(dataset, feature, variable) {
    if(!is.data.frame(dataset)) {
      stop('Your first argument should be of type dataframe. However, your input dataset is of class:', class(dataset))
    }
   calculations <- dplyr::summarise(
    dataset,
    is_numeric_variable = is.numeric({{ variable }}),
    class_variable = class({{ variable }}),
    length_variable = length({{variable}}),
    length_feature = length({{feature}})
  )
  if (!calculations$is_numeric_variable) {
    stop("`variable` column must be numeric, but it is an object of class ",
         calculations$class_variable)
  }
  if(calculations$length_variable == 0 | calculations$length_feature == 0){
    stop('One of the variable or feature input arguments is of length zero!')
  }
  output <- (dataset %>%
  group_by({{feature}}) %>%
  summarize(range({{variable}})[1], range({{variable}})[2], mean({{variable}}), median({{variable}}), sd({{variable}})))
  return(output)
}
```

# Exercise 3: Include examples

Here, we will demonstrate the usage of the implemented function with a
few examples.

-   Example 1

``` r
cancer_sample
```

    ## # A tibble: 569 × 32
    ##          ID diagnosis radius_mean texture_mean perimeter_mean area_mean
    ##       <dbl> <chr>           <dbl>        <dbl>          <dbl>     <dbl>
    ##  1   842302 M                18.0         10.4          123.      1001 
    ##  2   842517 M                20.6         17.8          133.      1326 
    ##  3 84300903 M                19.7         21.2          130       1203 
    ##  4 84348301 M                11.4         20.4           77.6      386.
    ##  5 84358402 M                20.3         14.3          135.      1297 
    ##  6   843786 M                12.4         15.7           82.6      477.
    ##  7   844359 M                18.2         20.0          120.      1040 
    ##  8 84458202 M                13.7         20.8           90.2      578.
    ##  9   844981 M                13           21.8           87.5      520.
    ## 10 84501001 M                12.5         24.0           84.0      476.
    ## # … with 559 more rows, and 26 more variables: smoothness_mean <dbl>,
    ## #   compactness_mean <dbl>, concavity_mean <dbl>, concave_points_mean <dbl>,
    ## #   symmetry_mean <dbl>, fractal_dimension_mean <dbl>, radius_se <dbl>,
    ## #   texture_se <dbl>, perimeter_se <dbl>, area_se <dbl>, smoothness_se <dbl>,
    ## #   compactness_se <dbl>, concavity_se <dbl>, concave_points_se <dbl>,
    ## #   symmetry_se <dbl>, fractal_dimension_se <dbl>, radius_worst <dbl>,
    ## #   texture_worst <dbl>, perimeter_worst <dbl>, area_worst <dbl>, …

First, I will rewrite what the function does in the below code chunk
separately to have a performance baseline.

``` r
cancer_sample_summary <- cancer_sample %>% 
              group_by(diagnosis) %>%
              summarize(range(area_mean)[1], range(area_mean)[2], mean(area_mean), median(area_mean), sd(area_mean))
print(cancer_sample_summary)
```

    ## # A tibble: 2 × 6
    ##   diagnosis `range(area_mean… `range(area_mea… `mean(area_mean… `median(area_me…
    ##   <chr>                 <dbl>            <dbl>            <dbl>            <dbl>
    ## 1 B                      144.             992.             463.             458.
    ## 2 M                      362.            2501              978.             932 
    ## # … with 1 more variable: sd(area_mean) <dbl>

Here, I will call the function with the same input arguments as the
baseline chunk above for comparison.

``` r
my_function(cancer_sample, diagnosis, area_mean)
```

    ## # A tibble: 2 × 6
    ##   diagnosis `range(area_mean… `range(area_mea… `mean(area_mean… `median(area_me…
    ##   <chr>                 <dbl>            <dbl>            <dbl>            <dbl>
    ## 1 B                      144.             992.             463.             458.
    ## 2 M                      362.            2501              978.             932 
    ## # … with 1 more variable: sd(area_mean) <dbl>

As we can see, the output is the same, so we have successfully put the
functionality we want in the `my_function` function, and we do not have
to rewrite the code inside our function for every different possible
`dataset`, `feature` and `variable` value.

-   Providing examples for other sample function inputs: \*

-   Example 2

``` r
vancouver_trees
```

    ## # A tibble: 146,611 × 20
    ##    tree_id civic_number std_street    genus_name species_name cultivar_name  
    ##      <dbl>        <dbl> <chr>         <chr>      <chr>        <chr>          
    ##  1  149556          494 W 58TH AV     ULMUS      AMERICANA    BRANDON        
    ##  2  149563          450 W 58TH AV     ZELKOVA    SERRATA      <NA>           
    ##  3  149579         4994 WINDSOR ST    STYRAX     JAPONICA     <NA>           
    ##  4  149590          858 E 39TH AV     FRAXINUS   AMERICANA    AUTUMN APPLAUSE
    ##  5  149604         5032 WINDSOR ST    ACER       CAMPESTRE    <NA>           
    ##  6  149616          585 W 61ST AV     PYRUS      CALLERYANA   CHANTICLEER    
    ##  7  149617         4909 SHERBROOKE ST ACER       PLATANOIDES  COLUMNARE      
    ##  8  149618         4925 SHERBROOKE ST ACER       PLATANOIDES  COLUMNARE      
    ##  9  149619         4969 SHERBROOKE ST ACER       PLATANOIDES  COLUMNARE      
    ## 10  149625          720 E 39TH AV     FRAXINUS   AMERICANA    AUTUMN APPLAUSE
    ## # … with 146,601 more rows, and 14 more variables: common_name <chr>,
    ## #   assigned <chr>, root_barrier <chr>, plant_area <chr>,
    ## #   on_street_block <dbl>, on_street <chr>, neighbourhood_name <chr>,
    ## #   street_side_name <chr>, height_range_id <dbl>, diameter <dbl>, curb <chr>,
    ## #   date_planted <date>, longitude <dbl>, latitude <dbl>

Testing the function when we want to have the summary statistics of the
`diameter` variable considering the categories of the `genus_name`
feature.

``` r
my_function(vancouver_trees, genus_name, diameter)
```

    ## # A tibble: 97 × 6
    ##    genus_name  `range(diameter)[1]` `range(diameter)[2]` `mean(diameter)`
    ##    <chr>                      <dbl>                <dbl>            <dbl>
    ##  1 ABIES                          1                 42.5            12.9 
    ##  2 ACER                           0                317              10.6 
    ##  3 AESCULUS                       0                 64              23.7 
    ##  4 AILANTHUS                      3                 21.5            15.9 
    ##  5 ALBIZIA                        6                  6               6   
    ##  6 ALNUS                          0                 40              17.5 
    ##  7 AMELANCHIER                    0                 20               3.21
    ##  8 ARALIA                         3                 12               6.81
    ##  9 ARAUCARIA                      3                 32              11.4 
    ## 10 ARBUTUS                        6                 33              18.4 
    ## # … with 87 more rows, and 2 more variables: median(diameter) <dbl>,
    ## #   sd(diameter) <dbl>

-   Example 3

Now, let’s deliberately show an error which can happen due to the
`variable` column being non-numeric.

``` r
my_function(vancouver_trees, genus_name, std_street)
```

    ## Error in my_function(vancouver_trees, genus_name, std_street): `variable` column must be numeric, but it is an object of class character

-   Example 4

``` r
flow_sample
```

    ## # A tibble: 218 × 7
    ##    station_id  year extreme_type month   day  flow sym  
    ##    <chr>      <dbl> <chr>        <dbl> <dbl> <dbl> <chr>
    ##  1 05BB001     1909 maximum          7     7   314 <NA> 
    ##  2 05BB001     1910 maximum          6    12   230 <NA> 
    ##  3 05BB001     1911 maximum          6    14   264 <NA> 
    ##  4 05BB001     1912 maximum          8    25   174 <NA> 
    ##  5 05BB001     1913 maximum          6    11   232 <NA> 
    ##  6 05BB001     1914 maximum          6    18   214 <NA> 
    ##  7 05BB001     1915 maximum          6    27   236 <NA> 
    ##  8 05BB001     1916 maximum          6    20   309 <NA> 
    ##  9 05BB001     1917 maximum          6    17   174 <NA> 
    ## 10 05BB001     1918 maximum          6    15   345 <NA> 
    ## # … with 208 more rows

Testing the function when we want to have the summary statistics of the
`flow` variable considering different values of the `year` feature.

``` r
my_function(flow_sample, year, flow)
```

    ## # A tibble: 109 × 6
    ##     year `range(flow)[1]` `range(flow)[2]` `mean(flow)` `median(flow)`
    ##    <dbl>            <dbl>            <dbl>        <dbl>          <dbl>
    ##  1  1909            NA                  NA         NA             NA  
    ##  2  1910            NA                  NA         NA             NA  
    ##  3  1911             5.75              264        135.           135. 
    ##  4  1912             5.8               174         89.9           89.9
    ##  5  1913             6.12              232        119.           119. 
    ##  6  1914             7.16              214        111.           111. 
    ##  7  1915             6.94              236        121.           121. 
    ##  8  1916             6.97              309        158.           158. 
    ##  9  1917             6.06              174         90.0           90.0
    ## 10  1918             6.03              345        176.           176. 
    ## # … with 99 more rows, and 1 more variable: sd(flow) <dbl>

# Exercise 4: Test the Function

Here, we aim to write a formal testing for the implemented function. I
test the conditions that have been implemented in the functions
regarding the criteria each input argument should follow.

``` r
function_testing <- test_that("Testing the implemented function", {
  expect_error(my_function('cancer_sample', diagnosis, area_mean))
  expect_error(my_function(vancouver_trees, genus_name, std_street))
  expect_error(my_function(cancer_sample, diagnosis, numeric(0)))
  expect_error(my_function(cancer_sample, numeric(0), area_mean))
  expect_true(is.data.frame(cancer_sample))
  expect_true(is.numeric(cancer_sample$area_mean))
})
```

    ## Test passed 🥇
