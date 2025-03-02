---
title: C++ オブジェクト指向メモ
---

## 設計

### 関数設計

- 修飾子の方針
  1. 名前空間内関数：外部変数未使用
  2. 静的メンバ関数：静的メンバ変数を利用
  3. const メンバ関数：メンバ変数を読み取り専用で利用
  4. 通常のメンバ関数：メンバ変数を変更
- 引数・返り値の方針
  1. 関数の成否：必要であれば返り値は bool
  2. 入出力用の引数があるか（引数を in-place に変更するか)：あればポインタ型で与える
  3. 入力用引数は const 参照で、残りは std::tuple で返す（不要な戻り値は std::ignore で無視）
- アクセサの例

  ```cpp
  // セッター
  inline void setter(const vector<double>& member) {
    this->member = member
  };
  // メソッドチェインが可能なセッター
  inline ExampleClass& setter(const vector<double>& member) {
    this->member = member;
    return *this;
  }
  // ゲッター
  inline const vector<double>& getter(void) const {
    // const 参照でコピーコストを下げる
    return this->member;
  }
  ```
  
### メンバ変数設計

- 修飾子の方針
  1. 読み取り専用で初期値はコンパイル時に評価可能：constexpr メンバ変数
  2. 読み取り専用だが初期値は不定：const メンバ変数
  3. 同一クラスによるインスタンスで共有する：静的メンバ変数
  4. 読み書きする：通常のメンバ変数

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

## [インターフェース](https://marycore.jp/prog/cpp/interface-class-and-duck-typing/)

- 継承（純粋仮想関数）

  ```cpp
  // 抽象クラス
  class ITest {
    ITest(double);
    virtual void DoTest(void) = 0;
  }
  // 具象クラス
  class Test : public ITest {
    // 継承コンストラクタ
    using ITest::ITest;
    void DoTest(void) override { printf("Hello World!\n"); }
  }
  // 抽象クラスのコンポジション
  class TestRunner{
    // アップキャスト
    TestRunner() : test_ins(new Test()) {}
    ITest* test_ins;
  }
  ```

## 名前空間（カプセル化）

- [namespace の賢い使い方](https://qiita.com/_EnumHack/items/430da105a541f9ecd774)
- [無名名前空間](https://kaworu.jpn.org/cpp/%E7%84%A1%E5%90%8D%E5%90%8D%E5%89%8D%E7%A9%BA%E9%96%93)：他ファイルから参照する必要のない処理を記載
- 複数ヘッダファイル/同一名前空間での関数定義が有効（Effective C++ §23）
  - 各ヘッダファイルのインクルードで部分的に関数読み込み
  - クラス外関数定義で各メンバ変数のカプセル化を高める

## ユーザー定義の型（構造体・クラス・共用体）

- [ユーザー定義型の変換（C++)](https://docs.microsoft.com/ja-jp/cpp/cpp/user-defined-type-conversions-cpp?view=vs-2019)
- 共用体：変数名とインデックス双方からアクセス

  ```cpp
  union {
    std::array<double, 4>;
    struct {
      double x;
      double y;
      double dxdt;
      double dydt;
    }
  }
  ```
