
# JQuantsR

<!-- badges: start -->
<!-- badges: end -->

[J-Quants
API](https://jpx-jquants.com/)は、日本取引所グループ（JPX）が提供する個人投資家向けデータ配信APIです。

JQuantsRは、J-Quants
APIをRから扱いやすいようにラップしたRパッケージです。

## インストール

以下の通り、本リポジトリからインストールしてください。

インストールには4.0.0以上のバージョンのRが必要です。

2023年4月リリースの有償版を使用するためには、以下のコマンドで1.0.0以上のバージョンのJQuantsRにアップデートしてください。

``` r
install.packages("remotes")
remotes::install_github("J-Quants/JQuantsR")
```

## ユーザー登録

JQuantsRを使用する前に、[J-Quants
API](https://jpx-jquants.com/)よりユーザー登録を行ってください。

## サンプルコード

プレミアムプランに登録していれば全ての関数から値を取得できますが、登録しているプランによっては値が取得できない関数があります。

``` r
library(JQuantsR)

# 各Rセッションの最初にJQuantsR::authorize()を実行してください。
# Rの環境変数"JQUANTSR_MAIL_ADDRESS"と"JQUANTSR_PASSWORD"に、
# Quants APIに登録しているメールアドレスとパスワードをそれぞれ設定しておくと、
# JQuantsR::authorize(mail_address = "YOUR MAIL ADDRESS", password = "YOUR PASSWORD")の代わりに
# JQuantsR::authorize()で実行できます。
authorize(mail_address = "YOUR MAIL ADDRESS", password = "YOUR PASSWORD")

# 引数や返り値の詳細はJ-Quants API Referenceや関数のヘルプをご参照ください。
get_info()
get_info(code = "86970")
get_info(date = "20220701")
get_info(code = "86970", date = "20220701")

get_daily_quotes(code = "86970")
get_daily_quotes(date = "20220701")
get_daily_quotes(code = "86970", from = "20220101", to = "20220630")

get_prices_am()
get_prices_am(code = "86970")

get_trades_spec(section = "TSEPrime")
get_trades_spec(from = "20220101", to = "20220630")
get_trades_spec(section = "TSEPrime", from = "20220101", to = "20220630")

get_weekly_margin_interest(code = "86970")
get_weekly_margin_interest(date = "20220701")
get_weekly_margin_interest(code = "86970", from = "20220101", to = "20220630")

get_short_selling(sector33code = "0050")
get_short_selling(date = "20220701")
get_short_selling(sector33code = "0050", from = "20220101", to = "20220630")

get_breakdown(code = "86970")
get_breakdown(date = "20220701")
get_breakdown(code = "86970", from = "20220101", to = "20220630")

get_trading_calendar()
get_trading_calendar(holidaydivision = "1")
get_trading_calendar(holidaydivision = "1", from = "20220101")
get_trading_calendar(holidaydivision = "1", to = "20220630")
get_trading_calendar(holidaydivision = "1", from = "20220101", to = "20220630")
get_trading_calendar(from = "20220101", to = "20220630")

get_topix()
get_topix(from = "20220101")
get_topix(to = "20220630")
get_topix(from = "20220101", to = "20220630")

get_financial_statements(code = "86970")
get_financial_statements(date = "20220105")
get_financial_statements(code = "86970", date = "20220105")

get_financial_dividend(code = "86970")
get_financial_dividend(date = "20220701")
get_financial_dividend(code = "86970", from = "20220101", to = "20220630")

get_financial_annoucement()

get_index_option(date = "20220701")
```

## 各関数について

### 概要

本パッケージに含まれる関数は以下の通りです。

- `JQuantsR::authorize()`:
  メールアドレスとパスワードを用いてリフレッシュトークンを取得後、リフレッシュトークンを用いてIDトークンを取得する
  - POST to “<https://api.jquants.com/v1/token/auth_user>”
  - POST to “<https://api.jquants.com/v1/token/auth_refresh>”
- `JQuantsR::get_info()`:
  最新の、あるいは指定した日付における上場銘柄一覧を取得する
  - GET to “<https://api.jquants.com/v1/listed/info>”
- `JQuantsR::get_daily_quotes()`: 日次の株価を取得する
  - GET to “<https://api.jquants.com/v1/prices/daily_quotes>”
- `JQuantsR::get_prices_am()`: 前場終了時に前場の株価を取得する
  - GET to “<https://api.jquants.com/v1/prices/prices_am>”
- `JQuantsR::get_trades_spec()`: 投資部門別売買状況（金額）を取得する
  - GET to “<https://api.jquants.com/v1/markets/trades_spec>”
- `JQuantsR::get_weekly_margin_interest()`: 信用取引週末残高を取得する
  - GET to “<https://api.jquants.com/v1/markets/weekly_margin_interest>”
- `JQuantsR::get_short_selling()`: 業種別空売り比率を取得する
  - GET to “<https://api.jquants.com/v1/markets/short_selling>”
- `JQuantsR::get_breakdown()`: 売買内訳データを取得する
  - GET to “<https://api.jquants.com/v1/markets/get_breakdown>”
- `JQuantsR::get_trading_calendar()`: 取引カレンダーを取得する
  - GET to “<https://api.jquants.com/v1/markets/trading_calendar>”
- `JQuantsR::get_topix()`: 日次のTOPIXを取得する
  - GET to “<https://api.jquants.com/v1/indices/topix>”
- `JQuantsR::get_financial_statements()`: 決算情報を取得する
  - GET to “<https://api.jquants.com/v1/fins/statements>”
- `JQuantsR::get_financial_dividend()`: 配当金情報を取得する
  - GET to “<https://api.jquants.com/v1/fins/dividend>”
- `JQuantsR::get_financial_announcement()`:
  翌日の決算発表予定銘柄を取得する
  - GET to “<https://api.jquants.com/v1/fins/annoucement>”
- `JQuantsR::get_index_option()`: オプション四本値を取得する
  - GET to “<https://api.jquants.com/v1/option/index_option>”

`JQuantsR::authorize()`を除き、取得したデータをtibbleで返します。

各関数の引数や返り値、取得できるデータの詳細は、[J-Quants API
Reference](https://jpx.gitbook.io/j-quants-ja/api-reference)やJQuantsRのヘルプをご参照ください。

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
