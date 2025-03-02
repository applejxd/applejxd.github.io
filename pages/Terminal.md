---
title: Terminal 操作メモ
---

## 一般

- [インフラエンジニアとしてよく使うコマンド集](https://qiita.com/sion_cojp/items/04a2aa76a1021fe77079)
- Mac ではシェルスクリプトを .terminal で保存してダブルクリックで実行可能

## コマンド操作

- 事前コマンドを実行

  ```bash
  !!
  ```

- 事前のコマンドの foo を bar に入れ替えて実行：$ ^foo^bar

  ```bash
  ls -a
  ^-a ^-la  # ls -la と同じ
  ```

- [fzf (fuzzy finder)](https://wonderwall.hatenablog.com/entry/2017/10/06/063000)
  - C-t：カレントディレクトリ以下検索
  - C-r：コマンド履歴検索
  - M-c：検索しながら移動

## ジョブ管理

```bash
command &  #バックグラウンドジョブとして実行
kill %<Job No.>  # ジョブを停止
jobs  # ジョブ確認
bg %<Job No.>  # バックグラウンド処理
fg %<Job No.>  # フォアグラウンド処理
```

- プロセス終了：Ctrl+C
- プロセス中断：Ctrl+Z

## ディレクトリスタック

```bash
push  # pwd をスタックに積んで引数のディレクトリに移動
push +n  # n 番目のスタックに移動
dirs  # 現在のスタック一覧を表示
popd +n  # n 番目のスタックを削除
```
