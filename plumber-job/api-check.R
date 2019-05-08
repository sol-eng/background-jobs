# A script to check Plumber endpoints
library(httr)

# Check echo endpoint
test_that("/echo endpoint", {
  echo_resp <- GET("http://127.0.0.1:5762/echo?msg=heyo")
  expect_equal(status_code(echo_resp), 200)
  expect_equal(headers(echo_resp)[["content-type"]], "application/json")
  expect_equal(content(echo_resp)[["msg"]][[1]], "The message is: 'heyo'")
})

# Check plot endpoint
test_that("/plot endpoint", {
  plot_resp <- GET("http://127.0.0.1:5762/plot")
  expect_equal(status_code(plot_resp), 200)
  expect_equal(headers(plot_resp)[["content-type"]], "image/png")
})

# Check sum endpoint
test_that("/sum endpoint", {
  sum_resp <- POST("http://127.0.0.1:5762/sum?a=4&b=2")
  expect_equal(status_code(sum_resp), 200)
  expect_equal(headers(sum_resp)[["content-type"]], "application/json")
  expect_equal(content(sum_resp)[[1]], 6)
})
