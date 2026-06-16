# tools — データ作成・確認ユーティリティ

COBOL演習で使うテストデータの「作成」「確認」と、コピーブックの「レイアウト解析」を
行う Python スクリプト群です。いずれも追加ライブラリ不要(標準ライブラリのみ)で動作します。

| スクリプト | 役割 |
|------------|------|
| `tools/make_data.py` | CSV から COBOL 用データファイル(Shift-JIS / 固定長)を生成 |
| `tools/check_data.py` | 生成済みデータファイルをフォーマット定義に照らして内容確認・検証 |
| `tools/parse_copybook.py` | COBOL コピーブックを解析し、各項目のバイト位置・サイズ一覧を出力 |

## クイックスタート(テンプレート → 編集 → データ作成)

テストデータを作る基本の流れは、次の3ステップです(例: `KJCF010` 受注データ)。

```bash
# 1. CSV テンプレート(ヘッダー + サンプル1行)を作成
uv run tools/make_data.py --template KJCF010 > data/kjcf010.csv

# 2. data/kjcf010.csv をエディタで開き、作りたいデータに編集
#    - ヘッダー行(列名)はそのまま、2行目以降にレコードを記入
#    - FILLER は書かなくてよい(自動で埋まる)
#    - 数値は 1000.00 や -50 のように 10進表記で記入

# 3. 編集した CSV から COBOL データファイルを生成
uv run tools/make_data.py KJCF010 data/kjcf010.csv data/KJBM010I.txt

# (任意) 生成結果を確認する
uv run tools/check_data.py KJCF010 data/KJBM010I.txt
```

各ステップの詳しいオプションは、後述の各スクリプトの説明を参照してください。

## 実行方法

すべて `uv run` で実行します。引数なしで実行するとヘルプが表示されます。

```bash
uv run tools/make_data.py --help
uv run tools/check_data.py --help
uv run tools/parse_copybook.py --help
```

## 対応フォーマット ID

`make_data.py` と `check_data.py` は、以下のフォーマット ID を共通で扱います。
レイアウトの詳細は各 `docs/FF_*.md` を参照してください。

| フォーマットID | 名称 | ファイル種別 | レコード長 |
|----------------|------|--------------|------------|
| `KJCF010` | 受注データ | 行順編成 (LINE SEQUENTIAL) | 50 バイト |
| `KJCF020` | 受注チェックファイル | 順編成 (固定長バイナリ) | 100 バイト |
| `KUCF010` | 売上ファイル | 順編成 (固定長バイナリ) | 100 バイト |
| `KUCF020` | 売上集計ファイル | 順編成 (固定長バイナリ) | 30 バイト |
| `KCCFSHO` | 商品マスタSAMファイル | 順編成 (固定長バイナリ) | 50 バイト |

> **行順編成** は改行(`\n`)区切りのテキスト、**順編成** は改行なしの固定長バイナリとして
> 入出力されます。数値はゾーン10進(PIC 9 / S9)・パック10進(PACKED-DECIMAL)、
> 日本語項目(PIC N)は全角スペース埋めの Shift-JIS で格納されます。

---

## 1. make_data.py — データファイル生成

CSV を入力として、指定フォーマットの COBOL データファイルを生成します。
出力ファイルは Shift-JIS / 固定長で、文字項目はスペース埋め、数値項目は
ゾーン・パック・符号付きへ自動エンコードされます。

### CSV テンプレートの出力

まず対象フォーマットの CSV テンプレート(ヘッダー行 + サンプル値の1行)を出力し、
それを編集してデータを用意するのが簡単です。

```bash
# 画面に表示して確認
uv run tools/make_data.py --template KJCF010

# ファイルに保存して編集する
uv run tools/make_data.py --template KCCFSHO > data/kccfsho_template.csv
```

CSV の列名はテンプレートのヘッダー行(各フォーマットのフィールド名)に合わせてください。
FILLER 項目は CSV に含める必要はなく、生成時に自動で埋められます。

### データファイルの生成

```bash
# 出力先を省略した場合: data/<フォーマットID><既定の拡張子> に出力
uv run tools/make_data.py KJCF010 data/input.csv

# 出力先を明示する場合
uv run tools/make_data.py KJCF010 data/input.csv data/KJBM010I.txt
uv run tools/make_data.py KCCFSHO data/master.csv data/KCCFSHO.dat
```

- 出力先を省略すると `data/<フォーマットID>` に、行順編成は `.txt`、順編成は `.dat` の
  拡張子で出力されます。
- 各レコードの項目内容が画面に表示され、レコード長が定義と一致しない場合はエラーで停止します。

### 数値項目の書き方(CSV 値)

- ゾーン数値・パック数値とも、CSV には `1000.00` や `-50` のように **10進表記** で記入します。
  小数桁数はフォーマット定義側で持っているため、CSV 側では小数点付きの実数値を書けば
  自動で内部表現へ変換されます。
- 数字以外を含む値を数値項目に入れた場合は、エラーデータ確認用として生 ASCII で格納されます
  (異常系テストデータの作成に利用できます)。

---

## 2. check_data.py — データファイル確認・検証

生成済み(あるいは COBOL プログラムが出力した)データファイルを、フォーマット定義に
照らして1レコードずつ解読・検証します。各項目を人間が読める形で表示し、
ゾーン/パックの符号ニブルやデータ区分・日付の妥当性などをチェックします。

```bash
uv run tools/check_data.py KJCF010 data/KJBM001I.txt
uv run tools/check_data.py KCCFSHO data/KCCFSHO.dat
```

### 出力の見方

- レコードごとに各項目の値を表示し、末尾に `[OK]` / `[NG]` を表示します。
- `[NG]` の場合は、不正の理由(数値データ不正、ゾーン/符号ニブル不正、データ区分の
  不正値、日付範囲外、レコード長不一致 など)が一覧されます。
- 最後に総レコード数・正常件数・エラー件数と、`合格` / `不合格` の総合結果を表示します。
- 終了コードは、全レコード正常なら `0`、1件でもエラーがあれば `1` を返します
  (シェルスクリプトでの自動判定に利用できます)。

### make_data.py との連携

生成 → 確認の流れで使うと、作成したデータが期待どおりかをすぐ検証できます。

```bash
uv run tools/make_data.py  KJCF010 data/input.csv data/KJBM010I.txt
uv run tools/check_data.py KJCF010 data/KJBM010I.txt
```

---

## 3. parse_copybook.py — コピーブック・レイアウト解析

COBOL コピーブック(固定形式)を解析し、各データ項目の **レベル / 項目名 / データ型 /
バイト数 / 開始位置 / 終了位置** を一覧表示します。レコードのバイトレイアウトを
把握したいときに使います。

- 対応: PIC `X` / `N` / `9` / `S9` / `V`、USAGE `DISPLAY` / `PACKED-DECIMAL` / `COMP-3`、
  `OCCURS` 句、`REDEFINES` 句、継続行。
- Shift-JIS のコピーブックも自動で読み込みます(失敗時は UTF-8 として再読込)。

```bash
# テーブル形式で表示
uv run tools/parse_copybook.py copylib/KJCF010.cob

# CSV 形式で出力(表計算ソフト等へ取り込む場合)
uv run tools/parse_copybook.py --csv copylib/KCCFSHO.cob > layout.csv
```

グループ項目は `GROUP` と表示され、サイズは子項目の合計から算出されます。
`REDEFINES` 項目は再定義元と同じ開始位置になり、グループのサイズには加算されません。

---

## 補足

- これらのスクリプトが扱う「フォーマット ID 別のレイアウト」は `make_data.py` /
  `check_data.py` 内に定義されています。新しいフォーマットを追加する場合は、
  両ファイルの定義(`FIELDS` / `FORMAT_META`、`FORMAT_CONFIG` と解析関数)を
  対応する `docs/FF_*.md` に合わせて追加してください。
- データファイルは Shift-JIS(cp932)固定長です。テキストエディタで開く際は
  文字コードに注意してください。
