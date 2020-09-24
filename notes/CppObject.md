---
title: C++ オブジェクト指向メモ
---

## 修飾子

- [static 修飾子(クラス内グローバル)](http://www.s-cradle.com/developer/sophiaframework/tutorial/Cpp/static.html)
    - 静的メンバ変数はいわゆるクラス変数
    - 静的メソッドはいわゆるクラスメソッド
- [const 修飾子(読み取り専用)](http://www.s-cradle.com/developer/sophiaframework/tutorial/Cpp/const.html)
    - const メンバ変数
        - 初期化時のみ書き込み可能
        - 以降は読み取り専用変数
    - const メソッド
        - メンバ変数を書き換えないメソッド
        - const ではないメソッドを呼ぶとエラー.
- [constexpr (コンパイル時定数)](http://tinyurl.com/y556prhr)
    - コンパイル時に定数として評価できることを保証
    - const は読み取り専用でコンパイル時に未定でもOK（定数ではない）
    - プリプロセッサは大域字句的置換. rvalue でも置換してしまう（不適切）.

## メンバ変数設計
- 修飾子の方針
  1. 読み取り専用で初期値はコンパイル時に評価可能：constexpr メンバ変数
  2. 読み取り専用だが初期値は不定：const メンバ変数
  3. 同一クラスによるインスタンスで共有する：静的メンバ変数
  4. 読み書きする：通常のメンバ変数

## 関数設計
- 修飾子の方針
  1. メンバ変数未使用：名前空間内関数（Effective C++ §23）
  2. 静的メンバ変数を利用：静的メンバ関数
  3. メンバ変数を読み取り専用で利用：const メンバ関数
  4. メンバ変数を変更：通常のメンバ関数
- アクセサの例
  ```cpp
  // セッター
  ExampleClass& setter(const vector<double>& member){
    this->member = member;
    // メソッドチェインが可能
    return *this;
  }
  // ゲッター
  const vector<double>& getter(void) const{
    // const 参照でコピーコストを下げる
    return this->member;
  }
  ```
