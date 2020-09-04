---
title: Python まとめノート
---

## ライブラリ管理

- [Python環境構築ベストプラクティス2019](https://www.natsukium.com/blog/2019-02-18/python/)
：pipenv でプロジェクト固有のライブラリ空間を作る
- [ライブラリ管理の比較](https://qiita.com/KRiver1/items/c1788e616b77a9bad4dd)
：pipenv がベストっぽい
- Windows で機械学習やるなら anaconda 以外は使えない様子
	```PowerShell
	$ choco install anaconda
	$ conda install -c conda-forge lightgbm
	```

## ドキュメント作成

- Type Hints：型ヒント
	- [typing -- 型ヒントのサポート](https://docs.python.org/ja/3/library/typing.html)
	- [Pythonではじまる、型のある世界](https://qiita.com/icoxfog417/items/c17eb042f4735b7924a3)
- docstring：コメントスタイル
	- [可読性を上げるための、docstringの書き方](https://qiita.com/simonritchie/items/49e0813508cad4876b5a)
	- [docstringのstyle3種の例](https://qiita.com/yokoc1322/items/ebf25c9cb779ff5ebc9c)
	：Type Hints 付きなら reStructuredText で
	- [チームメイトのためにdocstringを書こう！](https://www.slideshare.net/cocodrips/docstring-pyconjp2019)
- Sphinx：docstringを読み込んで仕様書を生成
	- [sphinx-apidoc](https://www.sphinx-doc.org/ja/master/man/sphinx-apidoc.html)
	：公式マニュアル
	- [Sphinxの使い方](https://qiita.com/futakuchi0117/items/4d3997c1ca1323259844)
	：入門記事
	- [sphinxでpythonのクラスや関数のドキュメントを自動生成する](https://joppot.info/2018/03/30/4156)

## オブジェクト指向プログラミング

- [Python におけるデザインパターン](https://pydp.info/)
- [継承よりも委譲](https://qiita.com/kotetsu75/items/4b903023001f157554a4)
- [抽象基底クラス](https://docs.python.org/ja/3/library/abc.html)
	- [抽象クラスとダック・タイピング](https://qiita.com/kaneshin/items/269bc5f156d86f8a91c4)
- [クラスメソッドとスタティックメソッド](https://qiita.com/1plus4/items/b37ec6ea90569ffdebfe)
- アクセス制限
	- [プライベートメンバの命名規則](https://www.python.ambitious-engineer.com/archives/323)
	- [プロパティによるアクセサ](https://qiita.com/okuhiiro/items/6a2378215f7160291da6)

## データ処理

- [スライス](https://note.nkmk.me/python-numpy-ndarray-slice/)
	```python
	a[-5:-1]	# 最後から5個目から最後までの要素
	a[:, 3]		# 3列目
	```
- pandas (Dataframe)
	- [先頭と末尾](https://note.nkmk.me/python-pandas-head-tail/)
	- [特定の列を落とす](https://note.nkmk.me/python-pandas-drop/)
- numpy (ndarray)
	- [Dataframe に変換](https://note.nkmk.me/python-pandas-numpy-conversion/)
- [pyplot](https://qiita.com/KntKnk0328/items/5ef40d9e77308dd0d0a4)

## 機械学習

- [「Kaggleで勝つ」のサンプルコード](https://github.com/gnkm/kagglebook)
	- ch03: 前処理
	- ch04: モデル
	- ch05: バリデーション
	- ch06: ハイパーパラメータの調整
- sklearn.liner_model
	- [Ridge 回帰](https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.Ridge.html)
- [statsmodels](https://www.statsmodels.org/stable/index.html)
- [LightGBM](https://lightgbm.readthedocs.io/en/latest/)
	- [LightGBMで時系列データ分析](LightGBM.md)
	- [パラメータの説明](https://lightgbm.readthedocs.io/en/latest/Parameters.html)
	- [原論文](https://papers.nips.cc/paper/6907-lightgbm-a-highly-efficient-gradient-boosting-decision-tree.pdf),
	[GBDTの解説](https://copypaste-ds.hatenablog.com/entry/2019/09/05/184947)
