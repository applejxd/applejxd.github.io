---
title: Sphinx メモ
---

## 使用方法
- [sphinx-apidoc](https://www.sphinx-doc.org/ja/master/man/sphinx-apidoc.html)
：公式マニュアル
- [Sphinxの使い方](https://qiita.com/futakuchi0117/items/4d3997c1ca1323259844)
：入門記事
- [sphinxでpythonのクラスや関数のドキュメントを自動生成する](https://joppot.info/2018/03/30/4156)

## セットアップ & ビルド

- インストール
  ```shell
  $ conda install sphinx
  $ conda install sphinx_rtd_theme
  ```
- セットアップ
  ```shell
  $ mkdir docs
  # conf.py, index.rst 変更
  $ sphinx-quickstart docs
  ```
- ビルド
  ```shell
  $ sphinx-apidoc -f -o ./rst .
  $ sphinx-build -a ./rst ./docs
  ```

## 拡張機能

- sphinx.ext.inheritance_diagrams
  - 継承関係図

## reStructuredText

```Python
class Hoge:
  """
  テストクラス
  """
  #: 保存した文字列
  member: str

  def fuga(self, arg: str) -> int:
    """
    テストメソッド

    :param arg: カウントする文字
    :return: 文字数
    """
    self.member = arg
    return len(arg)
```