---
title: GitHub Pages メモ
---

## GitHub Pages まとめ

- [Markdown で作って公開](http://yoshikyoto.github.io/text/git/gh_pages_md.html)
- [テーマの設定](https://docs.github.com/ja/github/working-with-github-pages/adding-a-theme-to-your-github-pages-site-with-the-theme-chooser)
- [ユーザーページとプロジェクトページ](https://qiita.com/mesh1nek0x0/items/ab5f4557d1fc3a7c5ce3)
- [目次の作り方](https://blog.kotet.jp/2018/04/toc-on-github-pages/#allejojekyll-toc)

## 自動生成ドキュメントの表示

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

## 構文

- Markdown
  - [コードブロックとシンタックスハイライト](https://docs.github.com/ja/github/writing-on-github/creating-and-highlighting-code-blocks)
- Jekyll
  - [テンプレート作成のための変数](http://jekyllrb-ja.github.io/docs/variables/)
  - [テンプレート用言語 Liquid](https://shopify.github.io/liquid/)

## ライブラリ

- CDN関連
  - [Google Hosted Libraries](https://developers.google.com/speed/libraries)
  - [MathJax](http://docs.mathjax.org/en/latest/web/start.html)
