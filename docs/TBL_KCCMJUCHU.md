# KCCMJUCHU

## 1. 基本情報

| **システム名** | **サブシステム名** | **物理テーブル名** | **論理テーブル名** |
| -------------- | ------------------ | ------------------ | ------------------ |
| 研修 (ID: K) | 共通 (ID: KC) | KCCMJUCHU | 受注マスタ |

## 2. テーブルレイアウト

| 項目名             | 項目日本語名 | データ型     | 制約 | 備考 |
| ------------------ | ------------ | :----------: | ---- | ---- |
| CMJUCHU_DATA_KBN   | データ区分   | NUMERIC(1)   | N    |      |
| CMJUCHU_JUCHU_NO   | 受注番号     | NUMERIC(4)   | P    |      |
| CMJUCHU_JUCHU_DATE | 受注日付     | CHAR(6)      | N    | YYMMDD |
| CMJUCHU_SHOHIN_NO  | 商品番号     | CHAR(5)      | N    |      |
| CMJUCHU_SURYO      | 数量         | NUMERIC(5)   | N    |      |

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

* **コピーブック**: `copylib/KCCMJUCHU.cob`

| テーブル項目名     | COBOL項目名         | PIC句   |
| ------------------ | ------------------- | ------- |
| CMJUCHU_DATA_KBN   | CMJUCHU-DATA-KBN    | `9(01)` |
| CMJUCHU_JUCHU_NO   | CMJUCHU-JUCHU-NO    | `9(04)` |
| CMJUCHU_JUCHU_DATE | CMJUCHU-JUCHU-DATE  | `X(06)` |
| CMJUCHU_SHOHIN_NO  | CMJUCHU-SHOHIN-NO   | `X(05)` |
| CMJUCHU_SURYO      | CMJUCHU-SURYO       | `9(05)` |

> ※ コピーブックは 03 レベルで定義されているため、上位の 01 レベル集団項目の配下に取り込んでください。
