---
site.title: トップページ
---

# C++ コーディングメモ

## サイトリンク
- コーディングスタイル：[Google C++ スタイルガイド 日本語全訳](https://ttsuki.github.io/styleguide/cppguide.ja.html)
    - [namespace の賢い使い方](https://qiita.com/_EnumHack/items/430da105a541f9ecd774),
    [無名名前空間](https://kaworu.jpn.org/cpp/%E7%84%A1%E5%90%8D%E5%90%8D%E5%89%8D%E7%A9%BA%E9%96%93)
- コメントスタイル
    - [Doxygen 公式](http://www.doxygen.jp/docblocks.html)
    - [JavaDoc](https://www.aiosl-tec.co.jp/java/247/)
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
    - 静的メンバ関数はいわゆるクラスメソッド
- [const 修飾子(読み取り専用)](http://www.s-cradle.com/developer/sophiaframework/tutorial/Cpp/const.html)
    - const メンバ変数は読み取り専用変数
    - const メソッドはメンバ変数を書き換えないメソッド
    - const メソッドは const ではないメソッドを呼ぶとエラー
- [constexpr(コンパイル時定数)](http://tinyurl.com/y556prhr)
    - 機械的な置換を行うプリプロセッサよりも constexpr
    - const は読み取り専用で初期化するまでは未定.厳密な定数ではない.
- [右辺値参照と左辺値参照](https://cpprefjp.github.io/lang/cpp11/rvalue_ref_and_move_semantics.html)
    - 右辺値は名前無し一時オブジェクト
    - 左辺値は名前有り実態のあるオブジェクト

## ユースケース参考

- [STLの型の使い分け](https://qiita.com/h_hiro_/items/a83a8fd2391d4a3f0e1c)
- [配列よりも std::array](http://tinyurl.com/y3uqd7s5)
    - std::array の方が書きやすい
- [vector のループは範囲ベースで](https://cpprefjp.github.io/lang/cpp11/range_based_for.html)
    - イテレータの型は 'const auto&' 推奨（書き換え防止）
    - [速度の比較](http://jagabeeinitialize.hatenablog.com/entry/2018/01/24/001016),
    インデックスが必要な場合は従来のやり方で
- [メンバイニシャライザを有効活用](http://jagabeeinitialize.hatenablog.com/entry/2018/01/21/192043)
    - コンストラクタによる初期化よりも速い
    - 宣言順での初期化に注意

## ライブラリ

- cmake
    - [現代的な cmake スクリプト](https://qiita.com/shohirose/items/5b406f060cd5557814e9)
    - [CMake の使い方](https://qiita.com/shohirose/items/45fb49c6b429e8b204ac)
    - [cmake-variables](https://cmake.org/cmake/help/v3.13/manual/cmake-variables.7.html)
- [GoogleTest](https://github.com/google/googletest)
    - [Google Test ドキュメント日本語訳 上級ガイド](http://opencv.jp/googletestdocs/advancedguide.html)
- OpenCV

## メモ

- [生ポインタは避ける？](https://qiita.com/hmito/items/44925fca9fca74e78f61)
    - STL は参照渡し
    - 配列は std::array にして参照渡し
    - 生ポインタの代わりにスマートポインタ
- 巨大なコピーを避ける？
    - [RVO, NRVO 任せでも大丈夫？](https://theolizer.com/cpp-school1/cpp-school1-37/)
    - スマートポインタ？ムーブセマンティクス？
    - 巨大なメンバ変数は値？（スマート）ポインタ？参照？