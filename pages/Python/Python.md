---
title: Python まとめノート
---

## ライブラリ管理

- [Python環境構築ベストプラクティス2019](https://www.natsukium.com/blog/2019-02-18/python/)
：pipenv でプロジェクト固有のライブラリ空間を作る
- [ライブラリ管理の比較](https://qiita.com/KRiver1/items/c1788e616b77a9bad4dd)
：pipenv がベストっぽい

```bash
$ python3 -m pip install pipenv
$ pipenv install numpy
# 単一コマンド実行
$ pipenv run python3 main.py
# 仮想環境立ち上げ
$ pipenv shell
```

- Windows で機械学習やるなら anaconda 以外は使えない様子

```shell
$ choco install anaconda
$ conda config --append channels conda-forge
$ conda install lightgbm
```

## ドキュメント作成

- Python コーディング規約：[PEP8](https://qiita.com/simonritchie/items/bb06a7521ae6560738a7)
- Type Hints：型ヒント

```python
def method(arg: float) -> float:
		pass
```

	- [typing -- 型ヒントのサポート](https://docs.python.org/ja/3/library/typing.html)
	- [Pythonではじまる、型のある世界](https://qiita.com/icoxfog417/items/c17eb042f4735b7924a3)
- docstring：コメントスタイル
	- [可読性を上げるための、docstringの書き方](https://qiita.com/simonritchie/items/49e0813508cad4876b5a)
	- [docstringのstyle3種の例](https://qiita.com/yokoc1322/items/ebf25c9cb779ff5ebc9c)
	：Type Hints 付きなら reStructuredText で
	- [チームメイトのためにdocstringを書こう！](https://www.slideshare.net/cocodrips/docstring-pyconjp2019)

## オブジェクト指向プログラミング

- [Python におけるデザインパターン](https://pydp.info/)
- [継承よりも委譲](https://qiita.com/kotetsu75/items/4b903023001f157554a4)
- [ダックタイピング入門](https://code-graffiti.com/duck-typing-in-python/)
- [抽象基底クラス](https://docs.python.org/ja/3/library/abc.html)
- [抽象クラスとダック・タイピング](https://qiita.com/kaneshin/items/269bc5f156d86f8a91c4)

```python
from abc import ABC, abstructmethod

# 抽象基底クラス
class BaseClass(ABC):
	def __init__(self):
		pass

	@abstructmethod
	def method(self):
		pass
	
class ChildClass(BaseClass):
	def __init__(self):
		super().__init__()

	def method(self):
		printf("Hello World!")
	
class Composit:
	def __init__(self):
		self.instance = ChildClass()
		# ダックタイピング
		self.instance.method
```

- [クラスメソッドとスタティックメソッド](https://qiita.com/1plus4/items/b37ec6ea90569ffdebfe)

```python
class TestClass:
	# クラス変数のみ使う処理
	@classmethod
	def class_method(cls):
		pass

	# メンバ・クラス変数に依存しない処理
	@staticmethod
	def static_method():
		pass
```

- アクセス制限
	- [プライベートメンバの命名規則](https://www.python.ambitious-engineer.com/archives/323)
	- [プロパティによるアクセサ](https://qiita.com/okuhiiro/items/6a2378215f7160291da6)
	
```python
class TestClass:
	def __init__(self):
		self._hoge = 3.
			
	@property
	def hoge(self) -> float:
		return self._hoge
			
	@hoge.setter
	def hoge(self, hoge: float) -> None:
		self._hoge = hoge
```

## データ処理

- [高速な CSV 読み書き](https://tinyurl.com/yfntbf9c)

```python
import pandas as pd
import numpy as np
import dask as dd

# CSV で読み書き
df.to_csv('test.csv', index=None)
dd.read_csv('test.csv').compute()

# pd.DataFrame をヘッダ付きで読み書き
df.to_pickle('test.pkl')
pd.read_pickle('test.pkl')

# 多次元 np.ndarray の読み書き
np.savez('np_savez', x=a1, y=a2)
npz = np.load('np_savez.npz')
npz['x']
```

- [全要素に関数を適用](https://qiita.com/ysk24ok/items/6736c8d8cc6eb06c6aa1)

```python
import numpy as np

# 一番よく見かける方法
list(map(lambda_func, like_var))

# リスト内包表記
[lambda_func(x) for x in list_var]

# ufunc 化（一番高速らしい）
np.frompyfunc(lambda_func, 1, 1)(list_var)

# 次点?
np.vectorize(lambda_func)(list_var)

# iteratable オブジェクトを利用
np.fromiter((lambda_func(x) for x in l), np.float32, count=len(l))

# pd.Series に適用
series.map(lambda_func)
```
	
- [スライス](https://note.nkmk.me/python-numpy-ndarray-slice/)

```python
# 最後から5個目から最後までの要素
a[-5:-1]
# 3列目
a[:, 3]
```

- pandas (Dataframe)
	- [pandasでよく使う文法まとめ](https://qiita.com/okadate/items/7b9620a5e64b4e906c42)
	- [Python pandas 図でみる データ連結 / 結合処理](http://sinhrks.hatenablog.com/entry/2015/01/28/073327)
	- [先頭と末尾](https://note.nkmk.me/python-pandas-head-tail/)
	- [特定の列を落とす](https://note.nkmk.me/python-pandas-drop/)
- numpy (ndarray)
	- [Dataframe に変換](https://note.nkmk.me/python-pandas-numpy-conversion/)
- [pyplot](https://qiita.com/KntKnk0328/items/5ef40d9e77308dd0d0a4)
	- インスタンス化しない
	
```python
import matplotlib.pyplot as plt
import numpy as np

# array-like (or scalar) object
x: np.ndarray = ...
y: np.ndarray = ...

# プロットする内容
plt.plot(x, y, label="test")
# タイトル
plt.title("This is a title for this figure")
# 軸にラベル付け
plt.xlabel("This is a label for this x axis")
plt.ylabel("This is a label for this y axis")
# 凡例を表示
plt.legend()
# プロットを表示
plt.show()
```

## 機械学習

- [「Kaggleで勝つ」のサンプルコード](https://github.com/gnkm/kagglebook)
	- ch03: 前処理
	- ch04: モデル
	- ch05: バリデーション
	- ch06: ハイパーパラメータの調整
- sklearn.liner_model
	- [Ridge 回帰](https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.Ridge.html)
- [statsmodels](https://www.statsmodels.org/stable/index.html)
