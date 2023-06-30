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
  expect_error(get_info(date = "20220701"), NA)
  expect_error(get_info(code = "86970", date = "20220701"), NA)
})


# get_daily_quotes --------------------------------------------------------
test_that("get_daily_quotes", {
  expect_error(get_daily_quotes(code = "86970"), NA)
  expect_error(get_daily_quotes(date = "20220715"), NA)
  expect_error(get_daily_quotes(code = "86970", date = "20220715"), NA)
  expect_error(get_daily_quotes(code = "86970", from = "20220701", to = "20220715"), NA)
})


# get_prices_am -----------------------------------------------------------
test_that("get_prices_am", {
  expect_error(get_prices_am(), NA)
  expect_error(get_prices_am(code = "86970"), NA)
})


# get_trades_spec ---------------------------------------------------------
test_that("get_trades_spec", {
  expect_error(get_trades_spec(section = "TSEPrime"), NA)
  expect_error(get_trades_spec(from = "20220101", to = "20220630"), NA)
  expect_error(get_trades_spec(section = "TSEPrime", from = "20220101", to = "20220630"), NA)
  expect_error(get_trades_spec(from = "20220101"), NA)
  expect_error(get_trades_spec(to = "20081231"), NA)
  expect_error(get_trades_spec(section = "TSEPrime", from = "20220101"), NA)
  expect_error(get_trades_spec(section = "TSEPrime", to = "20220630"), NA)
  # pagination
  expect_equal(nrow(get_trades_spec(from = "20080116", to="20230630")), 3682L)
})


# get_weekly_margin_interest ---------------------------------------------------------------
test_that("get_weekly_margin_interest", {
  expect_error(get_weekly_margin_interest(code = "86970"), NA)
  expect_error(get_weekly_margin_interest(date = "20220701"), NA)
  expect_error(get_weekly_margin_interest(code = "86970", from = "20220101", to = "20220630"), NA)
})


# get_short_selling ---------------------------------------------------------------
test_that("get_short_selling", {
  expect_error(get_short_selling(sector33code = "0050"), NA)
  expect_error(get_short_selling(date = "20220701"), NA)
  expect_error(get_short_selling(sector33code = "0050", from = "20220101", to = "20220630"), NA)
})


# get_breakdown ---------------------------------------------------------------
test_that("get_breakdown", {
  expect_error(get_breakdown(code = "86970"), NA)
  expect_error(get_breakdown(date = "20220701"), NA)
  expect_error(get_breakdown(code = "86970", from = "20220101", to = "20220630"), NA)
})


# get_trading_calendar ---------------------------------------------------------------
test_that("get_trading_calendar", {
  expect_error(get_trading_calendar(), NA)
  expect_error(get_trading_calendar(holidaydivision = "1"), NA)
  expect_error(get_trading_calendar(holidaydivision = "1", from = "20220101"), NA)
  expect_error(get_trading_calendar(holidaydivision = "1", to = "20220630"), NA)
  expect_error(get_trading_calendar(holidaydivision = "1", from = "20220101", to = "20220630"), NA)
  expect_error(get_trading_calendar(from = "20220101", to = "20220630"), NA)
})


# get_topix ---------------------------------------------------------------
test_that("get_topix", {
  expect_error(get_topix(), NA)
  expect_error(get_topix(from = "20220701"), NA)
  expect_error(get_topix(to = "20220715"), NA)
  expect_error(get_topix(from = "20220701", to = "20220715"), NA)
})


# get_financial_statements ------------------------------------------------
test_that("get_financial_statements", {
  expect_error(get_financial_statements(code = "86970"), NA)
  expect_error(get_financial_statements(date = "20220715"), NA)
  expect_error(get_financial_statements(code = "86970", date = "20220715"), NA)
  # pagination
  expect_equal(nrow(get_financial_statements(date = "20230512")), 1166L)
})


# get_financial_dividend ------------------------------------------------
test_that("get_financial_dividend", {
  expect_error(get_financial_dividend(code = "86970"), NA)
  expect_error(get_financial_dividend(date = "20220701"), NA)
  expect_error(get_financial_dividend(code = "86970", from = "20220101", to = "20220630"), NA)
})


# get_financial_announcement ----------------------------------------------
test_that("get_financial_announcement", {
  expect_error(get_financial_announcement(), NA)
})


# get_index_option ----------------------------------------------
test_that("get_index_option", {
  expect_error(get_index_option(date = "20220701"), NA)
})
