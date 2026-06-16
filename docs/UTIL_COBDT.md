# cobdt テストデータ作成ユーティリティ

## クイックスタート

cobdt でテストデータを作る流れは、次の5ステップです。ここでは実在する受注データ `KJCF010`（プログラム `KJBM010` の入力）を題材にします。各ステップの詳しい書き方は、後続のセクションを参照してください。

1. ファイル仕様を確認する。`docs/FF_KJCF010.md` でレイアウト（項目・桁・PIC）を把握します。
2. 使うレコード定義 YAML（コピー句ID）を確認する。この環境ではレコード定義 YAML が `copylib/` に用意済みです。対象プログラムの入力ファイルに対応するコピー句ID（ここでは `KJCF010` → `copylib/KJCF010.yaml`）を確認します（→ 3節）。
3. データ定義 YAML を作成する。`programs/KJBM010I.yaml` に書き込む値を並べます（→ 4節）。`KJCF010` なら次のように、`data` キーへレコードをフラットなリストで列挙します。

```yaml
data:
    - ["1", " ", 1, " ", 25, 4, 1, " ", 10001, " ", 100, " "]
    - ["1", " ", 2, " ", 25, 4, 2, " ", 10002, " ", 50,  " "]
```

4. データファイルを生成する。`cobdt create` で `data/KJBM010.dat` を出力します（→ 5節）。
5. 生成結果を確認する。`cobdt dump` で各項目の値を検証します。

手を動かすのはステップ4・5の2コマンドです。

```bash
# 4. データファイルを生成
cobdt create --data-yaml programs/KJBM010/KJBM010I.yaml --output programs/KJBM010/KJBM010.dat copylib/KJCF010.yaml

# 5. 生成結果を確認
cobdt dump copylib/KJCF010.yaml data/KJBM010.dat
```

> 値の並べ方のルール（GROUP・FILLER・表・REDEFINES の扱い）は 4節を参照してください。まずこの流れを一度なぞり、必要に応じて各節で詳細を確認してください。

---

## 1. 基本情報

| 項目 | 内容 |
| ---- | ---- |
| ツール名 | cobdt |
| 概要 | レコード定義 YAML とデータ定義 YAML から COBOL データファイルを生成する OSS ユーティリティ |
| リポジトリ | https://github.com/yukkeorg/cobdt |
| 主な用途 | `cobc` でコンパイルしたプログラムへ与える入力データ（`data/<program-id>.dat`）の作成 |

cobdt は「レコード（ファイル）のレイアウト」と「実際に書き込む値」を分けて管理します。
本研修では次の 2 ファイルを使い分けます。

| ファイル | 役割 | 配置場所 | 文字コード |
| -------- | ---- | -------- | ---------- |
| レコード定義 YAML | レイアウト（`record`）を定義 | `copylib/<copylib-id>.yaml` | UTF-8 |
| データ定義 YAML | 書き込む値（`data`）を定義 | `programs/<program-id>I.yaml` | UTF-8 |

> 出力されるデータファイル本体（`.dat`）は Shift-JIS（cp932）です。レコード定義の `n-encode: sjis` がこれを制御します。

---

## 2. サブコマンド

| コマンド | 説明 |
| -------- | ---- |
| `cobdt create <config.yaml> <output.dat>` | YAML の内容からデータファイルを作成する |
| `cobdt dump <config.yaml> <input.dat>` | 既存データファイルをレイアウトに従い項目名・値で表示する |
| `cobdt create-copybook <config.yaml> [output.cpy]` | レコード定義から COBOL コピー句を生成する（省略時は標準出力） |

本研修でデータ作成に使うのは原則 `create` です。
作成後の確認には `dump` を使うと、各項目の値が正しく書き込めたか検証できます。

---

## 3. レコード定義 YAML（`copylib/<copylib-id>.yaml`）

`docs/FF_<copylib-id>.md`（ファイルフォーマット仕様）を参照し、レイアウトを記述します。

### トップレベルキー

| キー | 説明 |
| ---- | ---- |
| `name` | レコード名（コピー句生成時の 01 レベル名）。コピー句 ID と一致させる |
| `organization` | ファイル編成。`sequential` または `line sequential` |
| `n-encode` | N 項目（日本語）の文字コード。本研修では `sjis` を指定 |
| `record` | 項目定義のリスト（GROUP / 基本項目 / FILLER） |
| `data` | データ作成時は **未使用**（空リスト `[]` のままでよい） |

### 項目（`record`）の書き方

| 種別 | 必須キー | 任意キー |
| ---- | -------- | -------- |
| 基本項目 | `type`, `name` | `usage`, `value`, `occurs`, `redefine` |
| GROUP 項目 | `type: GROUP`, `name`, `subs` | `occurs` |
| FILLER | `type: FILLER(<桁数>)` | （名前なし・X 項目扱い） |

### 型（`type`）一覧

| 記法 | 説明 | 桁寄せ・パディング |
| ---- | ---- | ------------------ |
| `9(n)` | ゾーン形式 10 進数（整数 n 桁） | 右寄せ・ゼロ埋め |
| `S9(n)Vmm` / `S9(n)V9(m)` | 符号付き・整数 n 桁・小数 m 桁 | 右寄せ・ゼロ埋め |
| `X(n)` | 英数字 n 桁 | 左寄せ・スペース埋め |
| `N(n)` | 日本語 n 文字（`n-encode` に従う） | 左寄せ・スペース埋め |
| `GROUP` | `subs` に下位項目を持つ集団項目 | — |
| `FILLER(n)` | 名前なしの予備領域（n 桁） | X 項目扱い |

### 主な任意キー

| キー | 説明 |
| ---- | ---- |
| `usage` | `9` 系項目のみ有効。`DISPLAY`（既定・ゾーン 10 進）/ `PACKED-DECIMAL`（= `COMP-3`、パック 10 進） |
| `occurs: n` | 項目を n 回繰り返す配列（表）。`value` とは併用不可 |
| `redefine` | 同一バイト領域を別の意味で再定義する。`occurs` とは併用不可 |
| `value` | コピー句生成時の初期値。データ作成では使わない |

### 記述例（`copylib/KJCF010.yaml`）

受注データ（行順編成、レコード長 50）の実例です。

```yaml
name: KJCF010
organization: sequential
n-encode: sjis
record:
    - type: X(01)
      name: JF010-DATA-KBN
    - type: FILLER(1)
    - type: GROUP
      name: JF010-JUCHU-NO-X
      subs:
        - type: 9(04)
          name: JF010-JUCHU-NO
    - type: FILLER(1)
    - type: GROUP
      name: JF010-JUCHU-DATE
      subs:
        - type: 9(02)
          name: JF010-JUCHU-YY
        - type: 9(02)
          name: JF010-JUCHU-MM
        - type: 9(02)
          name: JF010-JUCHU-DD
    - type: FILLER(1)
    - type: GROUP
      name: JF010-SHOHIN-NO-X
      subs:
        - type: 9(05)
          name: JF010-SHOHIN-NO
    - type: FILLER(1)
    - type: GROUP
      name: JF010-SURYO-X
      subs:
        - type: 9(05)
          name: JF010-SURYO
    - type: FILLER(25)
data: []
```

---

## 4. データ定義 YAML（`programs/<program-id>I.yaml`）

`data` キーのみを持ち、レコードを「フラットなリスト」として列挙します。
**`record` を上から平坦化した順番どおり**に値を並べます。

### 並べ方のルール

1. **GROUP 項目自体には値を置かない**。下位の基本項目の値だけを順に並べる。
2. **FILLER の値も省略しない**。予備領域でもスペースや空文字などの値を 1 要素として含める。
3. **表（`occurs: n`）** は、各繰り返しを個別のリスト要素として展開（インラインに連続して並べる）。
4. **REDEFINES 項目** は、オブジェクト形式 `{ target: <再定義元フィールド名>, value: [ 値... ] }` で指定する。

### 記述例（`KJCF010` 用 `programs/KJBM010I.yaml`）

上記 `copylib/KJCF010.yaml` を平坦化すると、値の順序は次のとおりです。

```
JF010-DATA-KBN, FILLER(1), JF010-JUCHU-NO, FILLER(1),
JF010-JUCHU-YY, JF010-JUCHU-MM, JF010-JUCHU-DD, FILLER(1),
JF010-SHOHIN-NO, FILLER(1), JF010-SURYO, FILLER(25)
```

これに対応するデータ定義 YAML の例:

```yaml
data:
    - ["1", " ", 1, " ", 25, 4, 1, " ", 10001, " ", 100, "                         "]
    - ["1", " ", 2, " ", 25, 4, 2, " ", 10002, " ", 50,  "                         "]
    - ["9", " ", 3, " ", 25, 4, 3, " ", 10001, " ", 10,  "                         "]
```

> FILLER のスペースは桁数ぶん（最後の `FILLER(25)` なら 25 文字）を文字列で与えます。

---

## 5. データファイルの生成手順

```bash
# 1. レコード定義 YAML を作成・確認（copylib/<copylib-id>.yaml）
# 2. データ定義 YAML を作成（programs/<program-id>I.yaml、UTF-8）
# 3. cobdt create でデータファイルを生成
cobdt create --data-yaml programs/<program-id>I.yaml copylib/<copylib-id>.yaml data/<program-id>.dat
```

`--data-yaml` で値を別ファイル（データ定義 YAML）から読み込み、レイアウトはレコード定義 YAML から取得します。
出力先はテストデータの規約に従い `data/<program-id>.dat` とします（`programs/` 配下には作成しません）。

### 生成例（KJCF010）

```bash
cobdt create --data-yaml programs/KJBM010I.yaml copylib/KJCF010.yaml data/KJBM010.dat
```

### 生成結果の確認

```bash
cobdt dump copylib/KJCF010.yaml data/KJBM010.dat
```

各項目名と値が一覧表示されるので、桁寄せ・パディング・符号などが意図どおりか検証します。

---

## 6. 補足

ジョブフロー上に先行プログラムがある場合は、その**出力ファイル**の構造（出力側コピー句）に合わせてテストデータを作ります。現行プログラムの入力コピー句ではなく、上流が実際に吐き出すレイアウトを反映させてください。

パック項目があっても、データ定義 YAML には通常の数値をそのまま書けば構いません。例えば `copylib/KCCFSHO.yaml` の `CFSHO-TANKA`（`S9(05)V9(2)`、`usage: PACKED-DECIMAL`）なら、`123.45` のように 1 要素で与えれば cobdt がパック形式へ変換して書き込みます。

文字コードは、レコード定義・データ定義のどちらの YAML も UTF-8 で記述します。生成される `.dat` は `n-encode: sjis` の指定により Shift-JIS で出力されます。

---

## 7. 参考

- cobdt リポジトリ / README: https://github.com/yukkeorg/cobdt
- ファイルフォーマット仕様: `docs/FF_<copylib-id>.md`
- レコード定義 YAML の実例: `copylib/KJCF010.yaml`, `copylib/KCCFSHO.yaml`
