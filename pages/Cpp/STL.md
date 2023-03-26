---
title: STL メモ
---

## 使い分け

[STLの型の使い分け](https://qiita.com/h_hiro_/items/a83a8fd2391d4a3f0e1c)

- 文字列操作
  - [char よりも std::string](https://qiita.com/7shi/items/cac7b3e9b90bf91b00cc)
- リスト操作
  - （動的に要素数を宣言したい）静的配列：array
    - [配列よりも std::array](http://tinyurl.com/y3uqd7s5)
  - 動的配列
    - ランダムアクセス/末尾への追加を実施：vector
    - 任意の位置への追加を実施: list
  - 要ベクトル計算: valarray
    - コンストラクタ引数は vector と逆で[(値, 数)の順](https://cpprefjp.github.io/reference/valarray/valarray/op_constructor.html)
- 集合操作(探索)
  - 要ソート: set
  - 高速探索: unordered_set
- 辞書操作(探索・キーアクセス)
  - 要ソート/キーがユニーク: map
  - 高速アクセス: unordered_map
  - キーがユニークではない: multimap
- ユーザー定義の構造体に対して STL を使用する場合
  - ソートを要する STL：構造体に対する順序を定義しておく
  - unordred_set/unordered_map：[構造体に対するハッシュを事前に定義しておく](http://vivi.dyndns.org/tech/cpp/unordered_map.html#decl)

## 計算時間

- [ソート (std::sort)](https://cpprefjp.github.io/reference/algorithm/sort.html): O(N・log(N))
- 探索
  - [std::set::find](https://cpprefjp.github.io/reference/set/set/find.html): O(log(N))
  - [std::map::find](https://cpprefjp.github.io/reference/map/map/find.html): O(log(N))
  - [std::unordered_set::find](https://cpprefjp.github.io/reference/unordered_set/unordered_set/find.html): 平均 O(1), 最悪 O(N) (ハッシュが完全に衝突する場合)
  - [std::unordered_map::find](https://cpprefjp.github.io/reference/unordered_map/unordered_map/find.html): 平均 O(1), 最悪 O(N) (ハッシュが完全に衝突する場合)
  - ソートしていない std::vector & [std::find_if](https://cpprefjp.github.io/reference/algorithm/find_if.html): O(N)
  - ソート済み std::vector & std::binary_search: O(log(N))
- [競プロ覚書：二分探索，std::lower_bound を使いこなす](https://pyteyon.hatenablog.com/entry/2019/02/20/194140)
  - [std::binary_search](https://cpprefjp.github.io/reference/algorithm/binary_search.html)
  - [std::lower_bound](https://cpprefjp.github.io/reference/algorithm/lower_bound.html)
  - [std::equal_range](https://cpprefjp.github.io/reference/algorithm/equal_range.html)

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

## Tips

- [要素アクセスは indexing より at() メソッドの方が安全](https://cpprefjp.github.io/reference/vector/vector/at.html)
- 巨大なコンテナは const 参照で渡す（値渡しでコピーしない）
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
