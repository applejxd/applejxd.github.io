---
title: Sphinx メモ
---

## セットアップ & ビルド

関連ライブラリをインストール。
`sphinx_rtd_theme` と `sphinx` のバージョン互換性に注意。

```shell
pip install "sphinx>=8.2,<9" sphinx_rtd_theme sphinx_mdinclude sphinx_autobuild
```

Graphviz を使う場合はそれも。

```shell
# Linux の場合
sudo apt-get install graphviz
# Windows の場合
winget install Graphviz.Graphviz
```

初期設定

```shell
# bash, zsh の場合
sphinx-quickstart docs/sphinx --sep -l en --ext-autodoc --ext-viewcode
```

```shell
# git/uv をベースにした powershell の場合の例
sphinx-quickstart docs/sphinx --sep -l en `
  -p $((uv version --output-format json | ConvertFrom-Json).package_name) `
  -a $(git config --get user.name) `
  -r $((uv version --output-format json | ConvertFrom-Json).version) `
  --ext-autodoc --ext-viewcode `
  --ext-githubpages `
  --extensions sphinx.ext.apidoc `
  --extensions sphinx_mdinclude `
  --extensions sphinx.ext.graphviz `
  --extensions sphinx.ext.inheritance_diagram
```

初期化後に以下を設定。リンク先には例。：

- [conf.py](https://github.com/applejxd/VideoConverter/blob/main/docs/sphinx/source/conf.py): 拡張機能の設定など
- [index.rst](https://github.com/applejxd/VideoConverter/blob/main/docs/sphinx/source/index.rst?plain=1): `modules` など追加したいページへのリンクを貼る
- [Makefile](https://github.com/applejxd/VideoConverter/blob/main/Makefile): ビルド設定

ビルドは [sphinx-build](https://www.sphinx-doc.org/ja/master/man/sphinx-apidoc.html)。
上記の `conf.py` の通り設定しておけば `sphinx-apidoc` は不要。

```shell
# see 
sphinx-build ./docs/sphinx/source ./docs/sphinx/build
```

## 拡張機能

- sphinx.ext.autodoc：docstring からドキュメント自動生成
  - sphinx.ext.napoleon: numpy/Google スタイルの docstring 対応 (reStructured text 形式には不要)
- sphinx.ext.viewcode: ソースコードへの link を追加
- sphinx.ext.graphviz: 各種図生成
  - sphinx.ext.inheritance_diagram：継承関係図生成
- sphinx_mdinclude: Markdown ファイルの読込
  - インストールコマンド: `pip install sphinx-mdinclude`

## reStructuredText

```python
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

## Tips

- docstring からのドキュメント自動生成には sphinx.ext.autodoc が必要なため注意
- 現在は `conf.py` の `sys.path` 変更は不要。
  `sphinx-apidoc`/`sphinx-build` の引数でソースのパスを適切に設定。
- Module 化していない場合に \_\_init\_\_.py を作っていると不具合が生じるため注意

- [Markdown から作成](https://github.com/omnilib/sphinx-mdinclude)
  1. `pip install sphinx-mdinclude`
  2. conf.py の extension に sphinx_mdinclude を追加
  3. [対応する rst ファイルを作成](https://stackoverflow.com/questions/46278683/include-my-markdown-readme-into-sphinx)
  4. 必要に応じて index.rst などに 上記3. のリンクを作成

## トラブルシューティング

- 出力にあたり以下が必要。対象ファイルの出力がうまくなされない。
  - モジュール があるフォルダには \_\_init\_\_.py を配置して認識させる
  - 相対パスは `from . import hoge` 等とする
  - 使用しているライブラリは sphinx build をする環境にインストール
  - パス名に "-" は厳禁。うまく認識しない。
- LaTeX のビルドは LuaTex の場合は日本語の改行がおかしくなる。XeTeX 推奨。

## 各種リンク

- [sphinx-apidoc](https://www.sphinx-doc.org/ja/master/man/sphinx-apidoc.html)：公式マニュアル
- [Sphinx Themes Gallery](https://sphinx-themes.org/)
- [Sphinxの使い方](https://qiita.com/futakuchi0117/items/4d3997c1ca1323259844)：入門記事
- [sphinxでpythonのクラスや関数のドキュメントを自動生成する](https://joppot.info/2018/03/30/4156)
- [PDFファイル作成](https://sphinx-users.jp/cookbook/pdf/index.html)
