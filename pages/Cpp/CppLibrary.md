---
title: C++ ライブラリメモ
---

## 各種ライブラリ

- [glog](https://github.com/google/glog)
- [GoogleTest](https://github.com/google/googletest)
  - [Google Test ドキュメント日本語訳 上級ガイド](http://opencv.jp/googletestdocs/advancedguide.html)
- [matplotlib-cpp](https://github.com/lava/matplotlib-cpp)：要 Python パッケージ
- [fast-cpp-csv-parser](https://github.com/ben-strasser/fast-cpp-csv-parser)：コメントのスキップも可能

## Boost

- [boost::combine](https://www.boost.org/doc/libs/1_72_0/libs/range/doc/html/range/reference/utilities/combine.html)：Python の zip()
- [boost::adaptors::reversed](https://www.boost.org/doc/libs/1_74_0/libs/range/doc/html/range/reference/adaptors/reference/reversed.html)：逆順 for ループ

### UUID

- UUIDの型: [boost::uuids::uuid](https://boostjp.github.io/tips/uuid.html)
- uuid → string の変換
  - `lexical_cast<string>`
  - boost/uuid/uuid_io.hpp が必要
- UUID のランダム生成
  - `boost::uuids::random_generator()()`
- シードUUID を指定して string から変換
  - `boost::uuids::name_generator`
  - コンストラクタに uuid 指定
  - `name_gen(string)` のように変換

### Hash

- [hash_combine](https://boostjp.github.io/tips/hashmap.html)
  - 構造体に対する unordered_map・set で活用

## Eigen

- [デバッグ](http://wildpie.hatenablog.com/entry/20160206/1454747559)
  - ウォッチ式：`*var.data()@num`
- [注意点](https://www.regentechlog.com/2018/12/09/eigen-note/)
  - [固定サイズの型によるメンバ変数](http://eigen.tuxfamily.org/dox/group__TopicStructHavingEigenMembers.html)
  - [固定サイズの型に対するSTLコンテナの宣言](http://eigen.tuxfamily.org/dox/group__TopicStlContainers.html)
