
# JQuantsR

<!-- badges: start -->
<!-- badges: end -->

J-Quants API is the API that provides Japanese stock data, such as daily
stock price and financial data, from Japan Exchange Group (JPX).

JQuantsR is a R package of J-Quants API wrapper.

## Installation

You can install JQuantsR from GitHub as follows.

``` r
install.packages("remotes")
remotes::install_github("J-Quants/JQuantsR")
```

## Registration of J-Quants API and getting refresh token

Before using JQuantsR, you have to register J-Quants API from
[here](https://application.jpx-jquants.com/register).

Then, [login](https://application.jpx-jquants.com/) and get “refresh
token”.

## Usage

### Summary

Each function of JQuantsR is the wrapper funtion of POST or GET method
of J-Quants API, and transform fetched data to a tibble (except for
`JQuantsR::authorize()`).

For detailed information about parameters and returns of each function,
refer to [J-Quants API
Reference](https://jpx.gitbook.io/j-quants-api/api-reference) and
JQuantsR help document.

-   `JQuantsR::authorize()`: POST method to
    “<https://api.jpx-jquants.com/v1/token/auth_refresh>”
-   `JQuantsR::get_sections()`: GET method to
    “<https://api.jpx-jquants.com/v1/listed/sections>”
-   `JQuantsR::get_daily_quotes()`: GET method to
    “<https://api.jpx-jquants.com/v1/prices/daily_quotes>”
-   `JQuantsR::get_financial_statements()`: GET method to
    “<https://api.jpx-jquants.com/v1/fins/statements>”
-   `JQuantsR::get_financial_announcement()`: GET method to
    “<https://api.jpx-jquants.com/v1/fins/annoucement>”

### Acquisition of ID token

-   **Before using the following functions whose name starts with
    “get\_”, you need to run `JQuantsR::authorize()` to acquire your ID
    token.**
    -   `JQuantsR::authorize()` returns your ID token and automatically
        set your ID token to a environment variable named
        “JQUANTSR\_ID\_TOKEN”.
    -   So, once you run `JQuantsR::authorize()`, you don’t have to set
        parameter `id_token` to other functions, since the default
        parameter of id\_token is `Sys.getenv("JQUANTSR_ID_TOKEN")`.
        -   Otherwise, you have to set “id\_token” parameter to the
            those functions manually (not recommended).
-   Validity period of refresh token is 1 week and that of ID token is
    24 hours.
    -   If refresh token are expired, login from
        [here](https://application.jpx-jquants.com/) and get “refresh
        token”.
    -   If ID token are expired, run `JQuantsR::authorize()` and get the
        latest ID token.

``` r
JQuantsR::authorize(refresh_token = Sys.getenv("JQUANTSR_REFRESH_TOKEN"))
```

If you have set a environment variable named “JQUANTSR\_REFRESH\_TOKEN”,
you don’t have to set parameter `refresh_token`, since the default
parameter of refresh\_token is `Sys.getenv("JQUANTSR_REFRESH_TOKEN")`.
It is recommended to set your refresh token to
“JQUANTSR\_REFRESH\_TOKEN” in `.Renviron` file.

### Getting listed info

``` r
JQuantsR::get_info()
#> # A tibble: 4,232 x 7
#>    Code  UpdateDate CompanyNameFull      MarketCode CompanyName CompanyNameEngl~
#>    <chr> <chr>      <chr>                <chr>      <chr>       <chr>           
#>  1 79860 20220726   日本アイ・エス・ケイ B          日本アイエ~ NIHON ISK Compa~
#>  2 33280 20220726   ＢＥＥＮＯＳ         A          ＢＥＥＮＯ~ BEENOS Inc.     
#>  3 31970 20220726   （株）すかいらーく~  A          すかいらー~ SKYLARK HOLDING~
#>  4 72410 20220726   フタバ産業           A          フタバ産    FUTABA INDUSTRI~
#>  5 83030 20220726   （株）新生銀行       B          新生銀      Shinsei Bank,Li~
#>  6 95520 20220726   （株）Ｍ＆Ａ総合研~  C          Ｇ－Ｍ＆Ａ~  M&A Research In~
#>  7 40640 20220726   日本カーバイド工業   A          カーバイド  Nippon Carbide ~
#>  8 21570 20220726   （株）コシダカホー~  A          コシダカＨ~ KOSHIDAKA HOLDI~
#>  9 79190 20220726   野崎印刷紙業         B          野崎印      Nozaki Insatsu ~
#> 10 62760 20220726   シリウスビジョン     B          シリウスＶ  SiriusVision CO~
#> # ... with 4,222 more rows, and 1 more variable: SectorCode <chr>
```

``` r
JQuantsR::get_info(code = "86970")
#> # A tibble: 1 x 7
#>   Code  UpdateDate CompanyNameFull       MarketCode CompanyName CompanyNameEngl~
#>   <chr> <chr>      <chr>                 <chr>      <chr>       <chr>           
#> 1 86970 20220726   （株）日本取引所グル~ A          ＪＰＸ      Japan Exchange ~
#> # ... with 1 more variable: SectorCode <chr>
```

### Getting listed sections

``` r
JQuantsR::get_sections()
#> # A tibble: 34 x 2
#>    SectorCode SectorName          
#>    <chr>      <chr>               
#>  1 7150       保険業              
#>  2 5250       情報・通信業        
#>  3 7100       証券、商品先物取引業
#>  4 3350       ゴム製品            
#>  5 7050       銀行業              
#>  6 1050       鉱業                
#>  7 6050       卸売業              
#>  8 3150       パルプ・紙          
#>  9 3650       電気機器            
#> 10 3800       その他製品          
#> # ... with 24 more rows
```

### Getting daily stock price

``` r
JQuantsR::get_daily_quotes(code = "86970")
#> # A tibble: 1,358 x 14
#>    Code  Close Date     AdjustmentHigh  Volume TurnoverValue AdjustmentClose
#>    <chr> <dbl> <chr>             <dbl>   <dbl>         <dbl>           <dbl>
#>  1 86970  1706 20170104           1713 1999000    3401429400            1706
#>  2 86970  1712 20170105           1716 2137100    3653717900            1712
#>  3 86970  1691 20170106           1698 1678400    2841346600            1691
#>  4 86970  1664 20170110           1688 1883600    3147535700            1664
#>  5 86970  1687 20170111           1702 1786100    3019238000            1687
#>  6 86970  1682 20170112           1693 1938100    3267008400            1682
#>  7 86970  1692 20170113           1704 1646200    2778858800            1692
#>  8 86970  1673 20170116           1690  941900    1578043700            1673
#>  9 86970  1642 20170117           1675 1212200    1999247500            1642
#> 10 86970  1661 20170118           1664 1323500    2187853900            1661
#> # ... with 1,348 more rows, and 7 more variables: AdjustmentLow <dbl>,
#> #   Low <dbl>, High <dbl>, Open <dbl>, AdjustmentOpen <dbl>,
#> #   AdjustmentFactor <dbl>, AdjustmentVolume <dbl>
```

``` r
JQuantsR::get_daily_quotes(code = "86970", from = "20220701", to = "20220715")
#> # A tibble: 11 x 14
#>    Code  Close Date     AdjustmentHigh  Volume TurnoverValue AdjustmentClose
#>    <chr> <dbl> <chr>             <dbl>   <dbl>         <dbl>           <dbl>
#>  1 86970 1973  20220701          1994  2053700    4052986850           1973 
#>  2 86970 2048. 20220704          2058. 1061700    2165798050           2048.
#>  3 86970 2060  20220705          2079  1087500    2241513850           2060 
#>  4 86970 2064. 20220706          2070  1044500    2152787600           2064.
#>  5 86970 2084. 20220707          2108.  958600    1998405100           2084.
#>  6 86970 2091  20220708          2119  1233600    2586094800           2091 
#>  7 86970 2118. 20220711          2138.  783700    1659576050           2118.
#>  8 86970 2112. 20220712          2126. 1018700    2150600600           2112.
#>  9 86970 2110. 20220713          2118.  759000    1600645950           2110.
#> 10 86970 2090  20220714          2100.  642000    1340200900           2090 
#> 11 86970 2100  20220715          2107   818600    1716277300           2100 
#> # ... with 7 more variables: AdjustmentLow <dbl>, Low <dbl>, High <dbl>,
#> #   Open <dbl>, AdjustmentOpen <dbl>, AdjustmentFactor <dbl>,
#> #   AdjustmentVolume <dbl>
```

``` r
JQuantsR::get_daily_quotes(date = "20220701")
#> # A tibble: 4,196 x 14
#>     Close Code  Date     AdjustmentHigh  Volume TurnoverValue AdjustmentClose
#>     <dbl> <chr> <chr>             <dbl>   <dbl>         <dbl>           <dbl>
#>  1  3445  13010 20220701          3490    16900      58521000           3445 
#>  2  1970. 13050 20220701          2008   415170     819484090           1970.
#>  3  1946. 13060 20220701          1987  3697750    7219984655           1946.
#>  4  1926  13080 20220701          1964  1186300    2295908400           1926 
#>  5 45520  13090 20220701         47000      512      23750570          45520 
#>  6   893  13110 20220701           909.   10640       9529387            893 
#>  7 19240  13120 20220701         19295       26        493085          19240 
#>  8  3290  13130 20220701          3385      210        697950           3290 
#>  9   338. 13190 20220701           346.   21000       7253100            338.
#> 10 27105  13200 20220701         27620    66624    1808813245          27105 
#> # ... with 4,186 more rows, and 7 more variables: AdjustmentLow <dbl>,
#> #   Low <dbl>, High <dbl>, Open <dbl>, AdjustmentOpen <dbl>,
#> #   AdjustmentFactor <dbl>, AdjustmentVolume <dbl>
```

### Getting financial statements

``` r
JQuantsR::get_financial_statements(code = "86970")
#> # A tibble: 28 x 43
#>    Profit    ForecastDividen~ ForecastDividen~ NumberOfIssuedA~ ForecastDividen~
#>    <chr>     <chr>            <chr>            <chr>            <chr>           
#>  1 "3183200~ ""               21.0             "549069100"      42.0            
#>  2 ""        ""               26.0             ""               47.0            
#>  3 "4212400~ "－"             24.0             "549069100"      48.0            
#>  4 "1087400~ ""               24.0             "549069100"      48.0            
#>  5 "2269200~ ""               24.0             "549069100"      48.0            
#>  6 "3719500~ ""               24.0             "549069100"      48.0            
#>  7 ""        ""               33.0             ""               57.0            
#>  8 "5048400~ "－"             27.0             "536351448"      54.0            
#>  9 "1162300~ ""               27.0             "536351448"      54.0            
#> 10 "2392000~ ""               27.0             "536351448"      54.0            
#> # ... with 18 more rows, and 38 more variables: ForecastNetSales <chr>,
#> #   ChangesBasedOnRevisionsOfAccountingStandard <chr>,
#> #   ResultDividendPerShareFiscalYearEnd <chr>,
#> #   CurrentFiscalYearStartDate <chr>, MaterialChangesInSubsidiaries <chr>,
#> #   AverageNumberOfShares <chr>, OrdinaryProfit <chr>,
#> #   ChangesInAccountingEstimates <chr>, DisclosedDate <chr>,
#> #   ForecastDividendPerShare3rdQuarter <chr>, ...
```

### Getting financial annoucement

If there is no financial annoucement the next day, the return is `NULL`.

``` r
JQuantsR::get_financial_announcement()
#> # A tibble: 58 x 7
#>    Code  Date     CompanyName        FiscalYear SectorName FiscalQuarter Section
#>    <chr> <chr>    <chr>              <chr>      <chr>      <chr>         <chr>  
#>  1 27600 20220727 東京エレクトロン~  3月31日    卸売業     第１四半期    プライ~
#>  2 59070 20220727 ＪＦＥコンテイナー 3月31日    金属製品   第１四半期    スタン~
#>  3 19440 20220727 きんでん           3月31日    建設業     第１四半期    プライ~
#>  4 19460 20220727 トーエネック       3月31日    建設業     第１四半期    プライ~
#>  5 86090 20220727 岡三証券グループ   3月31日    証券、商~  第１四半期    プライ~
#>  6 72500 20220727 太平洋工業         3月31日    輸送用機器 第１四半期    プライ~
#>  7 63820 20220727 トリニティ工業     3月31日    機械       第１四半期    スタン~
#>  8 23590 20220727 コア               3月31日    情報・通~  第１四半期    プライ~
#>  9 27150 20220727 エレマテック       3月31日    卸売業     第１四半期    プライ~
#> 10 75700 20220727 橋本総業ホールデ~  3月31日    卸売業     第１四半期    プライ~
#> # ... with 48 more rows
```

## Additional Information

-   J-Quants API is beta version, so the specs of JQuantsR may be
    changed.
-   J-Quants takes no responsibility for any damages that might occur in
    using J-Quants API and JQuantsR.

## Reference

-   [J-Quants API](https://application.jpx-jquants.com/)
-   [API Reference](https://jpx.gitbook.io/j-quants-api/api-reference)
    -   [Data Update
        Time](https://jpx.gitbook.io/j-quants-api/api-reference/data-update)
