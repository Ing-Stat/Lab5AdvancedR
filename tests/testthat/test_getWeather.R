
context("getWeather")


# test_that("The query is correct.", {
#   expect_error(getWeather(100))
#   expect_error(getWeather("100"))
#   expect_error(getWeather(c(100, 45)))
#   expect_error(getWeather(list("name" = "Kris")))
#   expect_error(getWeather(longitude = 45))
# })
# 
# 
# test_that("The data is output in the correct format.", {
#   expect_true(is.list(getWeather()))
#   expect_true(length(getWeather()$parameters) == 24)
#   expect_true(getWeather()$date == Sys.Date())
#   expect_true(is.vector(getWeather()$location))
#   expect_equal(getWeather()$location[[1]], 16)
# })
# 
