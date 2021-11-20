test_that("The statistical calculations work", {
  # Is the type of the first argument of the dataframe class?
  expect_error(my_function('cancer_sample', diagnosis, area_mean))
  # Is the `variable` numeric?
  expect_error(my_function(datateachr::vancouver_trees, genus_name, std_street))
  # Are none of the variables or features inputs of length zero?
  expect_error(my_function(datateachr::cancer_sample, diagnosis, numeric(0)))
  # Are none of the variables or features inputs of length zero?
  expect_error(my_function(datateachr::cancer_sample, numeric(0), area_mean))
  # Does the code execute silently without printing output to the console?
  expect_silent(my_function(datateachr::cancer_sample, diagnosis, area_mean))
  # Does the numeric(0) function return a zero length variable?
  expect_false(length(numeric(0)) != 0)
  # Is the first argument of type dataframe?
  expect_true(is.data.frame(datateachr::cancer_sample))
  # Is the variable input of the function numeric?
  expect_true(is.numeric(datateachr::cancer_sample$area_mean))
})
