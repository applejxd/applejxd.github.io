---
title: C++ デバッグ/エラー処理
---

## コーディング規約など

- [Google C++ スタイルガイド 日本語全訳](https://ttsuki.github.io/styleguide/cppguide.ja.html)
- [クリーンコーディング](https://qiita.com/elipmoc101/items/01003c82dbd2e464a071)
- [Enum でエラーコード](https://qiita.com/nrslib/items/1287b5888f7db6166320)

### Cpplint

- [Google C++ スタイルチェッカー：cpplint](https://github.com/cpplint/cpplint)
- "Single-parameter constructors should be marked explicit."
  - 暗黙のコンストラクタを呼び出さないように宣言に explicit を付ける
  - コーディング例

        ```cpp
        class Example {
         public:
          explicit Example(double arg);
        };
        ```

## 例外処理

- 基本

  ```cpp
  #include <iostream>
  #include <stdexcept>

  double divide(double a, double b){
    if (double b == 0){
      throw std::runtime_error("Error: Cannot divide by zero.");
    }
    return a / b;
  }

  int main(int argc, char* argv[]){
    if (argc != 3) {
      std::cerr << "Error: Please input two args." << std::endl;
      exit(1);
    }

    double ans;
    try {
      ans = divide(argv[1], argv[2]);
    } catch (const std::runtime_error &e) {
      std::cerr << e.what() << std::endl;
      exit(1);
    }

    std::cout << "Ans = " << ans << std::endl;

    return 0;
  }
  ```

- [例外クラス](https://programming-place.net/ppp/contents/cpp/library/017.html)
- [例外の再送出](http://kaitei.net/cpp/exceptions/)

## Segmentation Fault の解決

- デバッガを用いる方法
  1. ブレークポイントなしでデバッガ起動
  2. 「例外の発生」箇所から、コールスタックで呼び出し元を辿る
  3. 呼び出しに関連する変数チェック
  4. 「例外の発生」箇所に「条件付きブレークポイント」を設置
  5. デバッガの再起動
- 例外処理を用いる方法
  1. 上記「デバッガを用いる方法」で例外の発生箇所を特定
  2. 「例外発生が確定する箇所」と「例外が発生する箇所」の間で `throw`
  3. 呼び出し元で catch して呼び出しに関連する変数を `std::cerr` に出力
  4. 更に呼び出し元を辿る場合は終了せずに再度 `throw`
