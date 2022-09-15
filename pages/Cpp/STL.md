---
title: STL メモ
---

## 使い分け

- 組込型の代替
  - [配列よりも std::array](http://tinyurl.com/y3uqd7s5)
  - [char よりも std::string](https://qiita.com/7shi/items/cac7b3e9b90bf91b00cc)
- 配列として使う
  - （動的に要素数を宣言したい）静的配列：array
  - 動的配列：vector
- [STLの型の使い分け](https://qiita.com/h_hiro_/items/a83a8fd2391d4a3f0e1c)
  - ソートか速度か
    - 常にソートする：set, map, multimap
    - 高速にアクセスする：unordered 系統
  - ユニークにする：set, map 系統
  - キーを使ってアクセス：map, multimap 系統
  - 集合操作をする：set
- ユーザー定義の構造体に対するコンテナ
  - unordred 系列：[構造体に対するハッシュを定義](http://vivi.dyndns.org/tech/cpp/unordered_map.html#decl)
  - ソート可能なコンテナ：構造体に対する順序を定義
- ポインタ渡しではなく、const 参照で渡す

## 使用方法

- [要素アクセスは indexing より at() メソッドの方が安全](https://cpprefjp.github.io/reference/vector/vector/at.html)
- 巨大なコンテナは const 参照で渡す（値渡しでコピーしない）
- 検索は find_if で
    ```cpp
    double ref = 10;
    auto judge [double ref](double value) -> bool {
        return value == ref;
    };

    vector<double> d_vec;
    auto result = find_if(d_vec.begin(), d_vec,end(), judge);
    ```
- [std::vector の insert, erase は使用後に上書き必須](https://qiita.com/kumagi/items/4285b732dde3441ea854)
  ```cpp
  vector<int> elements{1, 2, 3, 4};
  auto iter = elements.begin() + 2;
  for (int index=0; index < 10; index++) {
    // intert 後はイテレータが不定になるので上書き
    iter = elements.insert(iter, index);
    iter++;
  }
  ```

## ループ処理

- [ループ速度の比較](http://jagabeeinitialize.hatenablog.com/entry/2018/01/24/001016)
- [単純なループは範囲ベースで](https://cpprefjp.github.io/lang/cpp11/range_based_for.html)
  ```cpp
  vector<double> elements;
  // 書き換え防止で const auto&
  for (const auto& element: elements) {
    element++; 
  }
  ```
- インデックスが必要な場合（従来のやり方）
  ```cpp
  vector<double> elements;
  for (int index=0; index < elements.size(); index++) {
    elements[index] += static_cast<double>(index);
  }
  ```
- イテレータが必要な場合
  ```cpp
  vector<double> elements;
  double sum{0};
  for(auto iter = elements.begin();
      iter != elements.end(); iter++) {
    sum += *iter;
  }
  ```
  
## 各種変換

```cpp
// 生配列 <-> vector
double raw_array[3]{1,2,3};
std::vector<double> vector_array(std::begin(raw_array), std::end(raw_array));
raw_array = vector_array.data();

// 生配列 -> array (std::array は C++11 から, std::to_array は C++20 から)
std::array<double, 3> array_array = std::to_array(raw_array)
raw_array = array_array.data();
```
