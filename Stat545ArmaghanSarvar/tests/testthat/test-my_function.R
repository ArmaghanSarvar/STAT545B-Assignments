test_that("The statistical calculations work", {
  expect_error(my_function('cancer_sample', diagnosis, area_mean))
  expect_error(my_function(vancouver_trees, genus_name, std_street))
  expect_error(my_function(cancer_sample, diagnosis, numeric(0)))
  expect_error(my_function(cancer_sample, numeric(0), area_mean))
  expect_true(is.data.frame(cancer_sample))
  expect_true(is.numeric(cancer_sample$area_mean))
})
