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


# market_information ---------------------------------------------------------------
test_that("market_information", {
  expect_equal(nrow(market_information), 12L)
  expect_equal(ncol(market_information), 2L)
})


# get_info ----------------------------------------------------------------
test_that("get_info", {
  expect_error(get_info(), NA)
  expect_error(get_info(code = "86970"), NA)
  expect_error(get_info(date = "20220701"), NA)
  expect_error(get_info(code = "86970", date = "20220701"), NA)
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


# get_topix ---------------------------------------------------------------
test_that("get_topix", {
  expect_error(get_topix(), NA)
  expect_error(get_topix(from = "20220701"), NA)
  expect_error(get_topix(to = "20220715"), NA)
  expect_error(get_topix(from = "20220701", to = "20220715"), NA)
})


# get_trades_spec ---------------------------------------------------------
test_that("get_trades_spec", {
  expect_error(get_trades_spec(), NA)
  expect_error(get_trades_spec(section = "TSEPrime"), NA)
  expect_error(get_trades_spec(from = "20220101", to = "20220630"), NA)
  expect_error(get_trades_spec(section = "TSEPrime", from = "20220101", to = "20220630"), NA)
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
