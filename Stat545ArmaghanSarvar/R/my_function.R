#' @title Statistical Measurements for a Dataset Variable
#' @description Computing the range, mean, median, and standard deviation of a variable across the groups of a feature from a dataset.
#' @param dataset The Tibble or Dataframe that the function will look at in order to extract the above information
#' @param feature The dataset column that we want to group the categories for
#' @param variable The dataset column that we want to calculate statistics on
#' @return A tibble, showing the statistics calculated
#' @examples
#' my_function(datateachr::cancer_sample, diagnosis, area_mean)
#' my_function(datateachr::vancouver_trees, genus_name, diameter)
#' @export
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
               dplyr::group_by({{feature}}) %>%
               dplyr::summarize(range({{variable}})[1], range({{variable}})[2], mean({{variable}}), stats::median({{variable}}), stats::sd({{variable}})))
  return(output)
}
