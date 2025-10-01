library(testthat)
library(dplyr)

source("../src/data_preprocessing.R")

context("Testes para data_preprocessing.R")

test_that("preprocess_data lida com valores faltantes corretamente (mean)", {
  data_with_na <- data.frame(
    a = c(1, 2, NA, 4),
    b = c(5, NA, 7, 8)
  )
  result <- preprocess_data(data_with_na, missing_strategy = "mean", normalize = FALSE, remove_outliers = FALSE)
  expect_false(any(is.na(result$data)))
  expect_equal(result$data$a[3], mean(c(1, 2, 4)))
})

test_that("preprocess_data lida com valores faltantes corretamente (remove)", {
  data_with_na <- data.frame(
    a = c(1, 2, NA, 4),
    b = c(5, NA, 7, 8)
  )
  result <- preprocess_data(data_with_na, missing_strategy = "remove", normalize = FALSE, remove_outliers = FALSE)
  expect_equal(nrow(result$data), 2)
  expect_false(any(is.na(result$data)))
})

test_that("preprocess_data normaliza dados corretamente", {
  data_numeric <- data.frame(
    a = c(1, 2, 3, 4),
    b = c(10, 20, 30, 40)
  )
  result <- preprocess_data(data_numeric, normalize = TRUE, missing_strategy = "remove", remove_outliers = FALSE)
  expect_true(all(abs(colMeans(result$data)) < 1e-9))
  expect_true(all(abs(apply(result$data, 2, sd) - 1) < 1e-9))
})

test_that("preprocess_data remove outliers corretamente (iqr)", {
  data_outliers <- data.frame(
    a = c(1, 2, 3, 4, 100),
    b = c(10, 20, 30, 40, 50)
  )
  result <- preprocess_data(data_outliers, remove_outliers = TRUE, outlier_method = "iqr", normalize = FALSE, missing_strategy = "remove")
  expect_equal(nrow(result$data), 4)
  expect_false(100 %in% result$data$a)
})

test_that("validate_data funciona corretamente", {
  data_test <- data.frame(
    a = c(1, 2, NA),
    b = c("x", "y", "z")
  )
  validation_result <- validate_data(data_test)
  expect_true(validation_result$is_data_frame)
  expect_equal(validation_result$missing_percentage, round(1 / 6 * 100, 2))
  expect_equal(validation_result$numeric_cols, 1)
  expect_equal(validation_result$character_cols, 1)
})

test_that("handle_missing_values com estratégia inválida", {
  data_test <- data.frame(a = c(1, NA))
  expect_error(handle_missing_values(data_test, strategy = "invalid"))
})

test_that("preprocess_data com data frame vazio", {
  expect_error(preprocess_data(data.frame()), "Data frame is empty")
})

test_that("preprocess_data com input não-data frame", {
  expect_error(preprocess_data(c(1,2,3)), "Input must be a data frame")
})

