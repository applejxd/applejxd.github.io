---
title: C++ コーディングメモ
---

## サイトリンク
- [Google C++ スタイルガイド 日本語全訳](https://ttsuki.github.io/styleguide/cppguide.ja.html)
    - [出力の参照渡しとポインタ渡しの比較](http://orycha.hatenablog.com/entry/2017/02/19/115015)
    - [namespace の賢い使い方](https://qiita.com/_EnumHack/items/430da105a541f9ecd774),
    [無名名前空間](https://kaworu.jpn.org/cpp/%E7%84%A1%E5%90%8D%E5%90%8D%E5%89%8D%E7%A9%BA%E9%96%93)
- [Doxygen](http://www.doxygen.jp/docblocks.html)：コメントスタイル
    - [Doxygen 書き方メモ（C, C++）](https://qiita.com/inabe49/items/23e615649e8539d857a8),
    [JavaDoc](https://www.aiosl-tec.co.jp/java/247/)
- リファレンス
    - [cppreference.com](https://ja.cppreference.com/w/)
    - [cpprefjp - C++日本語リファレンス](https://cpprefjp.github.io/)
- 学習
    - [一週間で身につくC++言語の基本](http://cpp-lang.sevendays-study.com/)
    - [さくさく理解する C言語/C++ プログラミング 入門](http://vivi.dyndns.org/tech/cpp/cpp.html)
- Tips
    - [More C++ Idioms](https://ja.wikibooks.org/wiki/More_C%2B%2B_Idioms)
    - [C/C++迷信集](http://www.kijineko.co.jp/tech/superstitions)

## ややこしいものの区別

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
- [constexpr(コンパイル時定数)](http://tinyurl.com/y556prhr)
    - コンパイル時に定数として評価できることを保証
    - const は読み取り専用でコンパイル時に未定でもOK（定数ではない）
    - プリプロセッサは大域字句的置換. rvalue でも置換してしまう（不適切）.
- [右辺値参照と左辺値参照](https://cpprefjp.github.io/lang/cpp11/rvalue_ref_and_move_semantics.html)
    - 右辺値は名前無し一時オブジェクト
    - 左辺値は名前有り実態のあるオブジェクト

## ユースケース

- [STLの型の使い分け](https://qiita.com/h_hiro_/items/a83a8fd2391d4a3f0e1c)
    - （動的に要素数を宣言したい）配列：array
    - 動的配列：vector
- [配列よりも std::array](http://tinyurl.com/y3uqd7s5)
    - std::array の方が書きやすい
    - ポインタ渡しではなく、const 参照で渡す
- [vector のループは範囲ベースで](https://cpprefjp.github.io/lang/cpp11/range_based_for.html)
    ```cpp
    vector<double> elements;
    for(const auto& element: elements){ 
        element++; 
    }
    ```
    - イテレータの型は 'const auto&' 推奨（書き換え防止）
    - [速度の比較](http://jagabeeinitialize.hatenablog.com/entry/2018/01/24/001016),
    インデックスが必要な場合は従来のやり方
        ```cpp
        vector<double> elements;
        for(int index=0; index < elements.size(); index++){
            elements[index] += static_cast<double>(index);
        }
        ```
- [メンバイニシャライザを有効活用](http://jagabeeinitialize.hatenablog.com/entry/2018/01/21/192043)
    - コンストラクタによる初期化よりも速い
    - 宣言順での初期化に注意
- デフォルト引数の設定はヘッダで行う
    ```cpp
    class hoge{
        public:
            double method(double arg = 1.);
    };

    double hoge::method(double arg){
        ...
    }
    ```

## ライブラリ

- [GoogleTest](https://github.com/google/googletest)：
[Google Test ドキュメント日本語訳 上級ガイド](http://opencv.jp/googletestdocs/advancedguide.html)
- Eigen

## 疑問点

- [生ポインタは避ける？](https://qiita.com/hmito/items/44925fca9fca74e78f61)
    - STL は参照渡しで OK
    - 配列は std::array にして参照渡し
    - 生ポインタの代わりにスマートポインタ
- 巨大なコピーを避ける？
    - [RVO, NRVO 任せでも大丈夫？](https://theolizer.com/cpp-school1/cpp-school1-37/)
    - スマートポインタ？ムーブセマンティクス？
    - 巨大なメンバ変数は値？（スマート）ポインタ？参照？