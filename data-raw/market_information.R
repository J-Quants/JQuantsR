market_information <- tibble::tibble(
  MarketType = c(
    "\u6771\u8a3c\u975e\u4e0a\u5834",
    "\u5e02\u5834\u4e00\u90e8",
    "\u5e02\u5834\u4e8c\u90e8",
    "\u30de\u30b6\u30fc\u30ba",
    "\u305d\u306e\u4ed6\uff08ETF\u30fbREIT\u30fb\u30a4\u30f3\u30d5\u30e9\u30d5\u30a1\u30f3\u30c9\uff09",
    "JASDAQ \u30b9\u30bf\u30f3\u30c0\u30fc\u30c9",
    "\u6771\u8a3c\u975e\u4e0a\u5834",
    "TOKYO PRO Market",
    "\u4e0a\u5834\u5ec3\u6b62",
    "\u30d7\u30e9\u30a4\u30e0",
    "\u30b9\u30bf\u30f3\u30c0\u30fc\u30c9",
    "\u30b0\u30ed\u30fc\u30b9"
  ),
  MarketCode = c(
    "", "1", "2", "3", "5", "6", "7", "8", "9", "A", "B", "C"
  )
)

usethis::use_data(market_information, overwrite = TRUE)
