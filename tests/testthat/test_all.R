# authorize ---------------------------------------------------------------
test_that("authorize", {
  expect_error(authorize(), NA)
})

# authorize_refresh_token ---------------------------------------------------------------
test_that("authorize_refresh_token", {
  expect_error(authorize_refresh_token(), NA)
})

# authorize_id_token ---------------------------------------------------------------
test_that("authorize_id_token", {
  expect_error(authorize_id_token(), NA)
})


# get_info ----------------------------------------------------------------
test_that("get_info", {
  expect_error(get_info(), NA)
  expect_error(get_info(code = "86970"), NA)
})


# get_sections ------------------------------------------------------------
test_that("get_sections", {
  expect_error(get_sections(), NA)
})


# get_daily_quotes --------------------------------------------------------
test_that("get_daily_quotes", {
  expect_error(get_daily_quotes(code = "86970"), NA)
  expect_error(get_daily_quotes(date = "20220715"), NA)
  expect_error(get_daily_quotes(code = "86970", date = "20220715"), NA)
  expect_error(get_daily_quotes(code = "86970", from = "20220701", to = "20220715"), NA)

})


# get_financial_statements ------------------------------------------------
test_that("get_financial_statements", {
  expect_error(get_financial_statements(code = "86970"), NA)
  expect_error(get_financial_statements(date = "20220715"), NA)
  expect_error(get_financial_statements(code = "86970", date = "20220715"), NA)
})


# get_financial_announcement ----------------------------------------------
test_that("get_financial_announcement", {
  expect_error(get_financial_announcement(), NA)
})
