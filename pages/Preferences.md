---
title: 開発環境メモ
---

## VS Code

- [マルチカーソル](https://meshikui.com/2018/12/12/1420/)
  - カーソルを使わない方法：矩形選択 → A-S-I
- [デバッグ機能](https://qiita.com/bigengelt/items/e4c6f08003fe15988b7d)
  - コールスタック：現在呼び出している関数の一覧
  - .natvis ファイル：独自形式の変数表示
- clang-format
  - `$ sudo apt install -y clang-format`
  - "Google style" に設定
- cpplint
  - pip3 からインストール

    ```shell
    sudo apt -y install python3-pip
    pip3 install cpplint
    pip3 show -f cpplint
    ```

  - 設定で`$HOME/.local/bin/cpplint`を絶対パスで指定
- [Draw.io integration](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio)
  - ファイル形式：.png.drawio ならそのまま編集・閲覧・利用が可能
  - 数式組版はタブから設定
- その他拡張機能
  - Awesome Emacs Keymap
  - GitLens, GitGraph
  - PlantUML
  - [Polacode](https://www.mitsue.co.jp/knowledge/blog/frontend/201804/02_1600.html)
  ：ソースコードを画像に
  - jumpy

## エディタ

- Vim
  - [Vim幼稚園からVim小学校へ](https://qiita.com/hachi8833/items/7beeee825c11f7437f54)
  - [上達したいVim初心者のための設定・プラグインの見つけ方、学び方](https://employment.en-japan.com/engineerhub/entry/2019/01/28/103000)
  - [iceberg.vim](https://github.com/cocopon/iceberg.vim)
- Emacs
  - [Spacemacs](https://www.spacemacs.org/)
  - [YaTeX](http://hooktail.sub.jp/tex/yatex/)

## IDE

- PyCharm
  - なんでも検索：Shift Double
  - [最強のPython統合開発環境PyCharm](https://qiita.com/yamionp/items/f88d50da8d6b548fc44c)

## ターミナル

- Windows：[Windows Terminal](https://www.microsoft.com/ja-jp/p/windows-terminal/9n0dx20hk701)
  - 起動方法：Win キー → "wt" をタイプ → Enter
  - [起動時に $HOME を開く](https://qiita.com/bindi/items/6aa20a157d83a6efd86f)
  - [Iceberg カラースキーム](https://gist.github.com/kshimi/86a6d840bab526c427b6e71acde44a81)
  - [Git Bash を追加](https://qiita.com/yokra9/items/bdd0882268b308cf22ca)
- Mac：[iTerm2](https://iterm2.com/)
  - [Hotkey](https://qiita.com/ruwatana/items/8d9c174250061721ad11)
  - [俺よりiTerm使いこなしてるやつおる？](https://www.rasukarusan.com/entry/2019/04/13/180443)
- クロスプラットフォーム：[Hyper](https://hyper.is/)
  - [プラグイン集](https://qiita.com/yamannnu/items/f40b2cffa85f5250e03e)
  - [hyperterm-overlay](https://qiita.com/yamannnu/items/f40b2cffa85f5250e03e#hyperterm-overlay)
  ：ホットキーで起動
