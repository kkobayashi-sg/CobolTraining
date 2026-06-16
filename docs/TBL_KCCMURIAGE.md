# KCCMURIAGE

## 1. 基本情報

| **システム名** | **サブシステム名** | **物理テーブル名** | **論理テーブル名** |
| -------------- | ------------------ | ------------------ | ------------------ |
| 研修 (ID: K) | 共通 (ID: KC) | KCCMURIAGE | 売上マスタ |

## 2. テーブルレイアウト

| 項目名               | 項目日本語名 | データ型       | 制約 | 備考 |
| -------------------- | ------------ | :------------: | ---- | ---- |
| CMURIAGE_SHOHIN_NO   | 商品番号     | NUMERIC(5)     | P   |      |
| CMURIAGE_SHOHIN_MEI  | 商品名       | CHAR(20)       | N    |      |
| CMURIAGE_URIAGE_YM   | 売上年月     | CHAR(6)        | P   |      |
| CMURIAGE_URIKAKE_ZAN | 売掛現在残高 | NUMERIC(9,0)   | N    |      |
| CMURIAGE_URIAGE_GAKU | 売上金額     | NUMERIC(9,0)   | N    |      |
| CMURIAGE_NYUKIN_GAKU | 入金金額     | NUMERIC(9,0)   | N    |      |

**制約凡例**

| 記号 | 意味 |
| :--: | ---- |
| P   | プライマリキー |
| U    | ユニークキー |
| N    | NOT NULL |

## 3. インデックス・制約情報

* **P以外のインデックス**: なし
* **外部参照キー**: なし

## 4. データ受け渡し用コピーブック

COBOL側で本テーブルのデータを受け取る（ホスト変数とする）ためのコピーブックを以下に用意しています。`EXEC SQL INCLUDE` または `COPY` で取り込んで使用します。

* **コピーブック**: `copylib/KCCMURIAGE.cob`

| テーブル項目名       | COBOL項目名          | PIC句     | 備考   |
| -------------------- | -------------------- | --------- | ------ |
| CMURIAGE_SHOHIN_NO   | CMURIAGE-SHOHIN-NO   | `9(05)`   |        |
| CMURIAGE_SHOHIN_MEI  | CMURIAGE-SHOHIN-MEI  | `N(10)`   | 20バイト（日本語10文字） |
| CMURIAGE_URIAGE_YM   | CMURIAGE-URIAGE-YM   | `X(06)`   |        |
| CMURIAGE_URIKAKE_ZAN | CMURIAGE-URIKAKE-ZAN | `S9(09)`  | 未使用 |
| CMURIAGE_URIAGE_GAKU | CMURIAGE-URIAGE-GAKU | `S9(09)`  |        |
| CMURIAGE_NYUKIN_GAKU | CMURIAGE-NYUKIN-GAKU | `S9(09)`  | 未使用 |

> ※ コピーブックは 03 レベルで定義されているため、上位の 01 レベル集団項目の配下に取り込んでください。
