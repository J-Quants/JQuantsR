
# JQuantsR

<!-- badges: start -->
<!-- badges: end -->

[J-Quants](https://jpx-jquants.com/)は、日本取引所グループ（JPX）が提供する個人投資家向けデータ配信APIです。

JQuantsRは、J-QuantsをRから扱いやすいようにラップしたRパッケージです。

## インストール

以下の通り、本リポジトリからインストールしてください。インストールには4.0.0以上のバージョンのRが必要です。

``` r
install.packages("remotes")
remotes::install_github("J-Quants/JQuantsR")
```

## サンプルコード

JQuantsRを使用する前に、[J-Quants](https://jpx-jquants.com/)よりユーザー登録を行ってください。

``` r
library(JQuantsR)

# 各Rセッションの最初にJQuantsR::authorize()を実行してください。
# Rの環境変数"JQUANTSR_MAIL_ADDRESS"と"JQUANTSR_PASSWORD"に、
# J-Quants APIに登録しているメールアドレスとパスワードをそれぞれ設定しておくと、
# JQuantsR::authorize(mail_address = "YOUR MAIL ADDRESS", password = "YOUR PASSWORD")の代わりに
# JQuantsR::authorize()で実行できます。
authorize(mail_address = "YOUR MAIL ADDRESS", password = "YOUR PASSWORD")

get_info()
get_info(code = "86970")
get_info(date = "20220701")

get_daily_quotes(code = "86970")
get_daily_quotes(date = "20220701")

get_prices_am()

get_trades_spec()
get_trades_spec(section = "TSEPrime")
get_trades_spec(from = "20220101", to = "20220630")

get_weekly_margin_interest(code = "86970")
get_weekly_margin_interest(date = "20220701")

get_short_selling(sector33code = "0050")
get_short_selling(date = "20220701")

get_breakdown(code = "86970")
get_breakdown(date = "20220701")

get_trading_calendar()

get_indices(code = "0000")
get_indices(date = "20220701")

get_topix()

get_financial_statements(code = "86970")
get_financial_statements(date = "20220105")

get_financial_details(code = "86970")
get_financial_details(date = "20220127")

get_financial_dividend(code = "86970")
get_financial_dividend(date = "20220701")

get_financial_annoucement()

get_index_option(date = "20220701")
```

## 各関数について

### 概要

本パッケージに含まれる関数は以下の通りです。`authorize()`を除き、取得したデータをtibbleで返します。

契約しているプランが関数の対象プランではない場合、データを取得することができません。

各関数の引数や返り値、取得できるデータの詳細は、JQuantsRのヘルプや[J-Quants
API
Reference](https://jpx.gitbook.io/j-quants-ja/api-reference)をご参照ください。

- Freeプラン以上
  - `authorize()`:
    メールアドレスとパスワードを用いてリフレッシュトークンを取得後、リフレッシュトークンを用いてIDトークンを取得する
    - \[POST\] /token/auth_user
    - \[POST\] /token/auth_refresh
  - `get_info()`: 上場銘柄一覧を取得する
    - \[GET\] /listed/info
  - `get_daily_quotes()`: 株価四本値を取得する
    - \[GET\] /prices/daily_quotes
  - `get_financial_statements()`: 決算情報を取得する
    - \[GET\] /fins/statements
  - `get_financial_announcement()`:
    3月期・9月期決算会社の翌営業日の決算発表予定銘柄を取得する
    - \[GET\] /fins/annoucement
  - `get_trading_calendar()`: 取引カレンダーを取得する
    - \[GET\] /markets/trading_calendar
- Lightプラン以上
  - `get_trades_spec()`: 投資部門別売買状況（金額）を取得する
    - \[GET\] /markets/trades_spec
  - `get_topix()`: TOPIX四本値を取得する
    - \[GET\] /indices/topix
- Standardプラン以上
  - `get_indices()`: 指数四本値を取得する
    - \[GET\] /indices
  - `get_index_option()`: オプション四本値を取得する
    - \[GET\] /option/index_option
  - `get_weekly_margin_interest()`: 信用取引週末残高を取得する
    - \[GET\] /markets/weekly_margin_interest
  - `get_short_selling()`: 業種別空売り比率を取得する
    - \[GET\] /markets/short_selling
- Premiumプラン以上
  - `get_breakdown()`: 売買内訳データを取得する
    - \[GET\] /markets/breakdown
  - `get_prices_am()`: 前場終了時に前場の株価を取得する
    - \[GET\] /prices/prices_am
  - `get_financial_dividend()`: 配当金情報を取得する
    - \[GET\] /fins/dividend
  - `get_financial_details()`: 財務諸表（BS/PL）を取得する
    - \[GET\] /fins/fs_details

### `JQuantsR::authorize()`

- 各Rセッションにおいて、最初に`JQuantsR::authorize()`を実行してリフレッシュトークンとIDトークンを取得する必要があります。
  - `JQuantsR::authorize()`は、リフレッシュトークンとIDトークンを取得し、`JQUANTSR_REFRESH_TOKEN`と`JQUANTSR_ID_TOKEN`という変数名の環境変数にそれぞれリフレッシュトークンとIDトークンをセットします。
  - 各Rセッション内で一度`JQuantsR::authorize()`を実行すれば、`id_token`を引数に取る各関数にIDトークンを渡す必要はありません。
- メールアドレスとパスワードをそれぞれ`JQUANTSR_MAIL_ADDRESS`と`JQUANTSR_PASSWORD`という変数名の環境変数に設定すれば、`JQuantsR::authorize()`の引数`mail_address`と`password`にそれぞれメールアドレスとパスワードを指定する必要はありません。
  - `.Renviron`ファイルに`JQUANTSR_MAIL_ADDRESS`と`JQUANTSR_PASSWORD`を記載することを推奨します。
- リフレッシュトークンとIDトークンの有効期限はそれぞれ1週間、24時間です。
  - いずれかの有効期限が切れた場合、`JQuantsR::authorize()`を再度実行してください。

## その他

- 本パッケージは現在開発途上であるため、本パッケージの仕様は今後変更される可能性があります。
- バグ報告や機能追加のリクエストなどはIssuesにご投稿ください。Pull
  Requestも歓迎です。

## Reference

- [J-Quants](https://jpx-jquants.com/)
- [J-Quants API
  Reference](https://jpx.gitbook.io/j-quants-ja/api-reference)
