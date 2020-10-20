---
title: C++ ビルドメモ
---

## リンク

- ドキュメント
  - [cmake-variables](https://cmake.org/cmake/help/v3.13/manual/cmake-variables.7.html)
  - [CMake チュートリアル](http://opencv.jp/cmake/cmake_tutorial.html)
- 書き方
  - [現代的な cmake スクリプト](https://qiita.com/shohirose/items/5b406f060cd5557814e9)
  - [CMake の使い方](https://qiita.com/shohirose/items/45fb49c6b429e8b204ac)
  - [プロジェクトの階層化](https://kamino.hatenablog.com/entry/cmake_tutorial2)
- Tips
  - [スタティックリンクとダイナミックリンク](http://www.cc.kyoto-su.ac.jp/~kbys/kiso/cpu/dynamic-link.html)
  - [条件付きコンパイル](http://www.wisdomsoft.jp/383.html)

## 単一ファイルのビルド

- コマンドライン
  ```bash
  $ gcc main.cpp -o out
  ```
- [Suffix Alias (fo Zsh)](https://itchyny.hatenablog.com/entry/20130227/1361933011)
  - 拡張子に応じてコマンドを実行してくれるエイリアス(Zsh 限定)
  - .zshrc に以下を記載
    ```zsh
    function runcpp () {
      g++ -O2 $1
      shift
      ./a.out $@ 
    }
    alias -s {c,cpp}='runcpp'    
    ```
  - 次のコマンドでコンパイル
    ```zsh
    $ ./main.cpp
    ```

## CMake

### 実行方法

- ビルド・インストール
  ```shell
  $ mkdir build && cd build
  $ cmake ../
  $ make
  $ make install
  ```
- アンインストール：`xargs sudo rm < install_manifest.txt`

### 単一ファイルの場合

```cmake
# CMake のバージョン指定
# 3.8 では Google Test に関する機能が使える
cmake_minimum_required(VERSION 3.8.0)
project(Main)
add_executable(Main main.cpp)
# コンパイルオプション指定
target_compile_options(Main PUBLIC -O2 -Wall)
# 特定の機能を持つバージョンを指定
# cf. http://tinyurl.com/y48o2xhh
target_compile_features(Main PUBLIC cxx_std_11)
```

### 階層化プロジェクトのビルド

- プロジェクト階層：<br>
project<br>
 ├ include<br>
 │ └ sub.h<br>
 ├ src<br>
 │ ├ sub.cpp<br>
 │ └ CMakeLists.txt<br>
 ├ test<br>
 │ ├ test.cpp<br>
 │ └ CMakeLists.txt<br>
 ├ main.cpp<br>
 └ CMakeLists.txt
- /project/CMakeLists.txt
    ```cmake
    cmake_minimum_required(VERSION 3.8.0)
    project(Main)

    add_executable(Main main.cc)
    target_compile_options(Main PUBLIC -O2 -Wall)
    target_compile_features(Main PUBLIC cxx_std_11)

    # サブディレクトリのプロジェクトを追加してリンク
    add_subdirectory(src)
    target_link_libraries(Main PUBLIC Sub)

    # テストを有効化
    enable_testing()
    add_subdirectory(test)
    ```
- /project/src/CMakeLists.txt
    ```cmake
    cmake_minimum_required(VERSION 3.8.0)

    add_library(Sub SHARED sub.cpp)

    # ヘッダファイルのフォルダを指定
    target_include_directories(Sub
        PUBLIC
            ${PROJECT_SOURCE_DIR}/include
    )
    ```
- /project/test/CMakeLists.txt
    ```cmake
    cmake_minimum_required(VERSION 3.8.0)

    include(GoogleTest)

    add_library(GTest
        SHARED ${PROJECT_SOURCE_DIR}/test/gtest/gtest-all.cc
    )
    target_include_directories(GTest
        PUBLIC ${PROJECT_SOURCE_DIR}/test
    )

    add_library(GMain
        SHARED ${PROJECT_SOURCE_DIR}/test/gtest/gtest_main.cc
    )
    target_include_directories(GMain
        PUBLIC ${PROJECT_SOURCE_DIR}/test
    )

    add_executable(SolverTest solver_test.cc)
    target_compile_options(SolverTest PUBLIC -O2 -Wall)
    target_compile_features(SolverTest PUBLIC cxx_std_11)
    target_link_libraries(SolverTest
        PUBLIC
            GTest
            GMain
    )

    gtest_add_tests(TARGET SolverTest)
    ```