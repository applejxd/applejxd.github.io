---
title:  Series/DataFrame/ndarray 逆引きインデックス
---

前提
```python
import pandas as pd
import numpy as np
```

## 可変リストとして扱う

大きさを指定して生成
```python
# 通常の配列（参考）
var = [0, 1, 2, 3]
# 1次元配列
n1array = np.empty(len(var))
df_1 = pd.Series(index=range(len(var)), dtype=float)
# 2次元配列（行数・列数）
n2array = np.empty((2,3))
df_2 = pd.DataFrame(index=range(len(var)), columns=[], dtype=float)
```

データの追加
```python
# 軸を指定して追加
result_array = np.append((a_array, b_array, axis=1))
# 列方向
df["new_col"] = df_1
# 行方向
df = df.appned(df_1)
```

## 要素の選択

ndarray のスライス。
view ではなく copy が必要なら明記する。
```python
# スタンダードなフォーマット（view）
array[a:b, c:d]
# 5行目以降
array[5:]
# 3列目以降
array[:, 3:]
# リストで指定（ファンシーインデックス）
array[[3, 2], [4, 5]]
# copy を取得
array[a:b, c:d].copy()
```

DataFrame の指定。

```python
# ラベルで指定
# スライスと同様の記法だがstop まで含まれる。
df.loc["A":"B", ["C","D"]]
# 番号で指定
df.iloc[a:b, c:d]
```

番号で指定

## 変換

## DataFrame のビュー（参照）とコピー

- コピー：df.copy()
- [SettingWithCopyWarning 対策](https://note.nkmk.me/python-pandas-setting-with-copy-warning/)
  - chained indexing が原因
  - 対策法1: indexing をまとめる

