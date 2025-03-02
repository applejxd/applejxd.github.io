---
title: CMake & C++ ビルドメモ
---

## CMake

- [最新版のビルド・インストール方法](https://cmake.org/install/)
- CMakeLitst.txt の例
  - [フォルダ名からプロジェクト名・ターゲット名自動生成](https://gist.github.com/applejxd/3283739b41de073f3cde07771e48be75)
  - [同一階層のC++ソースファイルを全てターゲットに追加する](https://gist.github.com/applejxd/111ad0f3dcdebbb6a269759e8cf25bd5)
- CMake マニュアル
  - [cmake-variables](https://tinyurl.com/yfbepgg9)
  - [CMake チュートリアル](http://opencv.jp/cmake/cmake_tutorial.html)
- CMake の書き方
  - [現代的な cmake スクリプト](https://tinyurl.com/yfmlbw6v)
  - [CMake の使い方](https://tinyurl.com/ye25hbaf)
  - [プロジェクトの階層化](https://kamino.hatenablog.com/entry/cmake_tutorial2)

### 実行方法

- ビルド・インストール

  ```shell
  mkdir build && cd build
  cmake .. && make -j$(nproc)
  sudo make install
  ```

  CMake>=3.15からは以下が可能
  
  ```bash
  mkdir ./project/build
  cmake -S ./project -B ./project/build
  cmake --build ./project/build
  sudo cmake --install ./project/build 
  ```
  
  その他詳細は[こちら](https://qiita.com/osamu0329/items/0a72ee32ee6934a7edf7)

- アンインストール：`xargs sudo rm -rf < install_manifest.txt`

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
target_include_directories(Sub PUBLIC
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

## コマンドラインでのビルド

- 基本のコマンド：`gcc main.cpp -o out`
- コンパイラオプション
  - [プログラム高速化の禁術](https://tinyurl.com/y8rfnqjh)
  - [警告オプション](https://tinyurl.com/yhjbpj2d)
- Tips
  - [スタティックリンクとダイナミックリンク](https://tinyurl.com/yff4q2tf)
  - [条件付きコンパイル](http://www.wisdomsoft.jp/383.html)
- [Suffix Alias (fo Zsh)](https://tinyurl.com/yfdhr4cz)
  - 拡張子に応じてコマンドを実行してくれるエイリアス(Zsh 限定)
  
```zsh
function runcpp () {
  g++ -O2 $1
  shift
  ./a.out $@ 
}
# Suffix Alias
alias -s {c,cpp}='runcpp'    

# コンパイル
./main.cpp
```
