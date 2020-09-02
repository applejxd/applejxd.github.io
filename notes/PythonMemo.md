# Python まとめノート

## ライブラリ管理

- [Python環境構築ベストプラクティス2019](https://www.natsukium.com/blog/2019-02-18/python/)
	- pipenv でプロジェクト固有のライブラリ空間を作れ
- [ライブラリ管理の比較](https://qiita.com/KRiver1/items/c1788e616b77a9bad4dd)
	- pipenv がベストっぽい
- Windows で機械学習やるなら anaconda 以外は使えない様子
    - $ choco install anaconda
    - $ conda install -c conda-forge lightgbm

## ドキュメント作成

- Type Hints
	- [typing -- 型ヒントのサポート](https://docs.python.org/ja/3/library/typing.html)
	- [Pythonではじまる、型のある世界](https://qiita.com/icoxfog417/items/c17eb042f4735b7924a3)
- docstring
	- [可読性を上げるための、docstringの書き方](https://qiita.com/simonritchie/items/49e0813508cad4876b5a)
	- [docstringのstyle3種の例](https://qiita.com/yokoc1322/items/ebf25c9cb779ff5ebc9c)
		- Type Hints 付きなら reStructuredText で
	- [チームメイトのためにdocstringを書こう！](https://www.slideshare.net/cocodrips/docstring-pyconjp2019)
- Sphinx
	- [sphinx-apidoc](https://www.sphinx-doc.org/ja/master/man/sphinx-apidoc.html)
		- 公式マニュアル
	- [Sphinxの使い方．docstringを読み込んで仕様書を生成](https://qiita.com/futakuchi0117/items/4d3997c1ca1323259844)
		- 入門記事
	- [sphinxでpythonのクラスや関数のドキュメントを自動生成する](https://joppot.info/2018/03/30/4156)