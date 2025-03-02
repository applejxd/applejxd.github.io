---
title: C++ コーディングメモ
---

## サイトリンク

- コーディングスタイル
  - [Google C++ スタイルガイド](https://ttsuki.github.io/styleguide/cppguide.ja.html)
  - [軽量コーディング](https://marycore.jp/prog/cpp/cpp-lightweight-coding-standards/)
  - [重量コーディング](https://marycore.jp/prog/cpp/cpp-heavyweight-coding-standards/)
- リファレンス
  - [cppreference.com](https://ja.cppreference.com/w/)
  - [cpprefjp - C++日本語リファレンス](https://cpprefjp.github.io/)
  - [hacking C++](https://hackingcpp.com/index.html)
- 学習
  - [一週間で身につくC++言語の基本](http://cpp-lang.sevendays-study.com/)
  - [さくさく理解する C言語/C++ プログラミング 入門](http://vivi.dyndns.org/tech/cpp/cpp.html)
- Tips
  - [More C++ Idioms](https://ja.wikibooks.org/wiki/More_C%2B%2B_Idioms)
  - [C/C++迷信集](http://www.kijineko.co.jp/tech/superstitions)

## [インタフェース](https://tinyurl.com/ye4w87rm)

### インタフェースクラス

- 派生クラスをインタフェースクラスにアップキャストする
- 実行時に動的にポリモーフィズムを達成

### テンプレート

- テンプレートは静的(コンパイル時計算)ポリモーフィズム
- 継承は移譲 + テンプレートで書けることがある
- コンパイル時の注意
  - [テンプレートの定義はヘッダファイルに書く](https://qiita.com/i153/items/38f9688a9c80b2cb7da7)
  - [多重インクルードエラーは inline で回避](https://qiita.com/m4saka/items/cf5d3867dd50438021b4)
  - [テンプレートと純粋仮想関数は両立不可](https://stackoverflow.com/questions/2354210/can-a-class-member-function-template-be-virtual)：テンプレートはコンパイル時にコード生成するが、純粋仮想関数は実行時に動的呼び出しを行うため
    - [Type Erasure による両立](https://clown.cube-soft.jp/entry/20110321/1300714348)
- 各種テクニック
  - [部分特殊化](https://programming-place.net/ppp/contents/cpp/language/023.html#partial_specialization)
  - [可変引数テンプレート](https://cpprefjp.github.io/lang/cpp11/variadic_templates.html)

## Tips

- [右辺値参照と左辺値参照](https://cpprefjp.github.io/lang/cpp11/rvalue_ref_and_move_semantics.html)
  - 右辺値は名前無し一時オブジェクト
  - 左辺値は名前有り実態のあるオブジェクト
  - [Range based for と auto&& による perfect forwarding](https://peng225.hatenablog.com/entry/2016/08/10/224044)
- キャストは C++ の機能で
  - static_cast
  - dynamic_cast
- ループで使う変数はループ内で宣言, 例外は以下（Effective C++ §26）
  - 効率化重視
  - 代入が生成と破棄よりもローコスト
  - ループ回数が多い
- 巨大なコピーを避ける
  - 巨大な（組み込み型等以外の）変数は const 参照で（Effective C++ §20）
  - [出力の参照渡しとポインタ渡しの比較](http://orycha.hatenablog.com/entry/2017/02/19/115015)
    - ポインタ渡しだと使わない戻り値を宣言しなくてよい
    - ポインタ渡しだと nullptr チェックが必要
  - [ローカル変数の戻り値は値渡しで RVO, NRVO 任せ](https://theolizer.com/cpp-school1/cpp-school1-37/)（Effective C++ §21）
- [メンバイニシャライザを有効活用](http://jagabeeinitialize.hatenablog.com/entry/2018/01/21/192043)
  - コンストラクタによる初期化よりも速い
  - 宣言順での初期化に注意
  - 一様初期化構文（波カッコによる初期化子リスト）を有効活用
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

- ラムダ式：単一の関数内で同一の処理が繰り返される場合など

```cpp
void func(double a){
    auto f = [a](double x){
        return pow(x,a);
    };

    auto df = [a](double x){
        return a*pow(x, a-1);
    };

    double value = f(10.) + df(10.) * 10.;

    ...
}
```

- マクロの正しい使い方：条件付きコンパイルなど
- [アライメントとパディング](http://jr0bak.homelinux.net/~imai/linux/arm_gcc_badknowhow/arm_gcc_badknowhow.html)
