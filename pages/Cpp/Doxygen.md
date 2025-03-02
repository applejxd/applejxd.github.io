---
title: Doxygen 使い方メモ
---

## 使用方法

- [Doxygen 公式](http://www.doxygen.jp/docblocks.html)
- インストール方法

    ```shell
    sudo apt install -y doxygen graphviz
    ```

- [使用方法](http://penguinitis.g1.xrea.com/computer/programming/doxygen.html)

    ```shell
    doxygen -g Doxyfile # 設定ファイル生成
    # Doxyfile を編集
    doxygen Doxyfile # ドキュメント生成
    ```

- [Doxyfile 記載例](https://github.com/applejxd/slam-practice/blob/master/cpp/Doxyfile)

## 設定方法

- 基本設定
  - 出力先：`OUTPUT_DIRECTORY = docs`
  - 言語設定：`OUTPUT_LANGUAGE = JAPANESE`
  - LaTeX を生成しない：`GENERATE_LATEX = NO`
- 表示内容
  - private も表示：`EXTRACT_PRIVATE = YES`
  - static も表示：`EXTRACT_STATIC = YES`
  - ソースコードも含める：`INLINE_SOURCES = YES`
- 図作成（要 graphviz）
  - 図を作成：`HAVE_DOT = YES`
  - 呼び出し関係図を作成：`CALL_GRAPH = YES`
  - 被呼び出し関係図を作成：`CALLER_GRAPH = YES`

## コメントスタイル

- [Doxygen 書き方メモ（C, C++）](https://qiita.com/inabe49/items/23e615649e8539d857a8)
- [JavaDoc](https://www.aiosl-tec.co.jp/java/247/)
- ヘッダファイル

    ````cpp
    /**
     * @file header.h
     * @brief ヘッダファイル
     * Copyright 2020 applejxd
     */
    ````

- 名前空間

    ```cpp
    //! hoge に関するクラス群
    namespace hoge{
        ...
    }   // namespace hoge
    ```

- クラス

    ```cpp
    //! hoge を行うクラス
    class Hoge{
        ...
    };
    ```

- 関数・メソッド

    ````cpp
    /*
     * 関数
     * @param arg 引数
     * @return 戻り値
     */
    double function(int arg){
        ...
    }
    ````

- 変数

    ```cpp
    //! 変数
    double var;
    ```
