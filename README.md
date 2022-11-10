
# JQuantsR

<!-- badges: start -->
<!-- badges: end -->

[J-Quants
API](https://application.jpx-jquants.com/)は、日本取引所グループ（JPX）が[J-Quants](https://jpx-jquants.com/)の取り組みの一環として提供する株式情報APIです。

JQuantsRは、J-Quants
APIをRから扱いやすいようにラップしたRパッケージです。

## インストール

以下の通り、本リポジトリからインストールしてください。

インストールには4.0.0以上のバージョンのRが必要です。

``` r
install.packages("remotes")
remotes::install_github("J-Quants/JQuantsR")
```

## ユーザー登録

JQuantsRを使用する前に、[J-Quants
API](https://application.jpx-jquants.com/)よりユーザー登録を行ってください。

## サンプルコード

``` r
# 各Rセッションの最初にJQuantsR::authorize()を実行してください。
# Rの環境変数"JQUANTSR_MAIL_ADDRESS"と"JQUANTSR_PASSWORD"に、
# Quants APIに登録しているメールアドレスとパスワードをそれぞれ設定しておくと、
# JQuantsR::authorize(mail_address = "YOUR MAIL ADDRESS", password = "YOUR PASSWORD")の代わりに
# JQuantsR::authorize()で実行できます。
JQuantsR::authorize(mail_address = "YOUR MAIL ADDRESS", password = "YOUR PASSWORD")

# 引数や返り値の詳細はJ-Quants API Referenceや関数のヘルプをご参照ください。
JQuantsR::get_info()
JQuantsR::get_info(code = "86970")

JQuantsR::get_sections()

JQuantsR::get_daily_quotes(code = "86970")
JQuantsR::get_daily_quotes(code = "86970", from = "20220701", to = "20220715")
JQuantsR::get_daily_quotes(date = "20220701")

JQuantsR::get_topix()
JQuantsR::get_topix(from = "20220101")
JQuantsR::get_topix(to = "20220630")
JQuantsR::get_topix(from = "20220101", to = "20220630")

JQuantsR::get_trades_spec()
JQuantsR::get_trades_spec(section = "TSEPrime")
JQuantsR::get_trades_spec(from = "20220101", to = "20220630")
JQuantsR::get_trades_spec(section = "TSEPrime", from = "20220101", to = "20220630")

JQuantsR::get_financial_statements(code = "86970")
JQuantsR::get_financial_statements(date = "20220701")

JQuantsR::get_financial_announcement()
```

## 各関数について

### 概要

本パッケージに含まれる関数は以下の通りです。

-   `JQuantsR::authorize()`:
    メールアドレスとパスワードを用いてリフレッシュトークンを取得後、リフレッシュトークンを用いてIDトークンを取得する
    -   POST to “<https://api.jpx-jquants.com/v1/token/auth_user>”
    -   POST to “<https://api.jpx-jquants.com/v1/token/auth_refresh>”
-   `JQuantsR::get_info()`: 最新の全上場銘柄一覧を取得する
    -   GET to “<https://api.jpx-jquants.com/v1/listed/info>”
-   `JQuantsR::get_sections()`: 業種一覧を取得する
    -   GET to “<https://api.jpx-jquants.com/v1/listed/sections>”
-   `JQuantsR::get_daily_quotes()`: 日次の株価を取得する
    -   GET to “<https://api.jpx-jquants.com/v1/prices/daily_quotes>”
-   `JQuantsR::get_topix()`: 日次のTOPIXを取得する
    -   GET to “<https://api.jpx-jquants.com/v1/indices/topix>”
-   `JQuantsR::get_trades_spec()`: 投資部門別売買状況（金額）を取得する
    -   GET to “<https://api.jpx-jquants.com/v1/markets/trades_spec>”
-   `JQuantsR::get_financial_statements()`: 決算情報を取得する
    -   GET to “<https://api.jpx-jquants.com/v1/fins/statements>”
-   `JQuantsR::get_financial_announcement()`:
    翌日の決算発表予定銘柄を取得する
    -   GET to “<https://api.jpx-jquants.com/v1/fins/annoucement>”

`JQuantsR::authorize()`を除き、取得したデータをtibbleで返します。

また、`JQuantsR::market_information`というtibble形式のデータがあります。市場区分のテーブルであり、`JQuantsR::get_info()`の返り値に含まれる`MarketCode`が表す市場区分の名称を示します。

各関数の引数や返り値、取得できるデータの詳細は、[J-Quants API
Reference](https://jpx.gitbook.io/j-quants-api/api-reference)やJQuantsRのヘルプをご参照ください。また、データの更新時間は[データの更新頻度](https://jpx.gitbook.io/j-quants-api/api-reference/data-update)をご参照ください。

### `JQuantsR::authorize()`

-   各Rセッションにおいて、最初に`JQuantsR::authorize()`を実行してリフレッシュトークンとIDトークンを取得する必要があります。
    -   `JQuantsR::authorize()`は、リフレッシュトークンとIDトークンを取得し、`JQUANTSR_REFRESH_TOKEN`と`JQUANTSR_ID_TOKEN`という変数名の環境変数にそれぞれリフレッシュトークンとIDトークンをセットします。
    -   各Rセッション内で一度`JQuantsR::authorize()`を実行すれば、`id_token`を引数に取る各関数にIDトークンを渡す必要はありません。
-   メールアドレスとパスワードをそれぞれ`JQUANTSR_MAIL_ADDRESS`と`JQUANTSR_PASSWORD`という変数名の環境変数に設定すれば、`JQuantsR::authorize()`の引数`mail_address`と`password`にそれぞれメールアドレスとパスワードを指定する必要はありません。
    -   `.Renviron`ファイルに`JQUANTSR_MAIL_ADDRESS`と`JQUANTSR_PASSWORD`を記載することを推奨します。
-   リフレッシュトークンとIDトークンの有効期限はそれぞれ1週間、24時間です。
    -   いずれかの有効期限が切れた場合、`JQuantsR::authorize()`を再度実行してください。

## その他

-   J-Quants
    APIは現在ベータ版であり、また本パッケージは現在開発途上であるため、本パッケージの仕様は今後変更される可能性があります。
-   バグ報告や機能追加のリクエストなどはIssuesにご投稿ください。Pull
    Requestも歓迎です。

## Reference

-   [J-Quants](https://jpx-jquants.com/)
-   [J-Quants API](https://application.jpx-jquants.com/)
-   [J-Quants API
    Reference](https://jpx.gitbook.io/j-quants-api/api-reference)
    -   [データの更新頻度](https://jpx.gitbook.io/j-quants-api/api-reference/data-update)
