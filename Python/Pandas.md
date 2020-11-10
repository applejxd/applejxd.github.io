---
title: Pandas メモ
---

## [データの種類](https://pandas.pydata.org/docs/getting_started/overview.html#data-structures)

- Series：配列
  - 1次元ラベル付き
  - 同一タイプ
- DataFrame：テーブル構造
  - 最大2次元ラベル付き
  - 列のタイプは可変
  - サイズミュータブル

## DataFrame のビュー（参照）とコピー

- コピー：df.copy()
- [SettingWithCopyWarning 対策](https://note.nkmk.me/python-pandas-setting-with-copy-warning/)
  - chained indexing が原因
  - 対策法1: indexing をまとめる

## その他
- 要素指定
- 書き換え
- ndarray との変換
- DataFrame 同士の演算