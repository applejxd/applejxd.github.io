---
title: GitHub メモ
---

## GitHub Pages

### Markdown のサイト化

[jekyll](https://docs.github.com/ja/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll) を使うのが通常。

典型的な構成は以下：

1. Jekyll サイトの初期化：`jekyll new --skip-bundle .`
2. [使いたいテーマを選定](https://jekyllrb-ja.github.io/docs/themes/)
3. `_config.yml` にテーマも含めて[サイト設定を記載](https://docs.github.com/ja/pages/setting-up-a-github-pages-site-with-jekyll/about-github-pages-and-jekyll)：[例](https://github.com/applejxd/applejxd.github.io/blob/main/_config.yml)
4. `index.md` をルートに置いてそこから各ページへリンクを貼る
5. スタイルを編集したい場合はテーマのリポジトリを参照して編集。[slate テーマならここ](https://github.com/pages-themes/slate)。
6. サイトをデプロイ
   - ユーザページならそのまま markdown のみが含まれるリポジトリを指定
   - プロジェクトページならフォルダスタイル (`./docs` 以下など)かブランチスタイル（`gh-pages` ブランチ内など）を選んでデプロイ

### 自動生成ドキュメントのサイト化

これはほぼブランチスタイル（`gh-pages` ブランチ内など）でデプロイ。
`gh-pages` は orphan ランチとして用意するため worktree を使用。

1. "Settings > GitHub Pages > Source" に進む
2. "master/docs" で Save
3. README.md にリンク設置
    - Doxygen：(固有アドレス)/html/annotated.html
    - Sphinx:(固有アドレス)/index.html

Sphinx の場合は次の操作が必要：

- doc/.nojekyll の空ファイル生成
- index.html に次を追加

    ```html
    <base href="(固有アドレス)" charset="utf-8/>
    ```

### 参考：構文

- Markdown
  - [コードブロックとシンタックスハイライト](https://docs.github.com/ja/github/writing-on-github/creating-and-highlighting-code-blocks)
- Jekyll
  - [テンプレート作成のための変数](http://jekyllrb-ja.github.io/docs/variables/)
  - [テンプレート用言語 Liquid](https://shopify.github.io/liquid/)

### 参考：ライブラリ

- CDN関連
  - [Google Hosted Libraries](https://developers.google.com/speed/libraries)
  - [MathJax](http://docs.mathjax.org/en/latest/web/start.html)

### 参考：リンク集

- [Markdown で作って公開](http://yoshikyoto.github.io/text/git/gh_pages_md.html)
- [ユーザーページとプロジェクトページ](https://qiita.com/mesh1nek0x0/items/ab5f4557d1fc3a7c5ce3)
- [目次の作り方](https://blog.kotet.jp/2018/04/toc-on-github-pages/#allejojekyll-toc)
