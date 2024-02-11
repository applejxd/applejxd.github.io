---
title: Python で ODD
---

## SOLID 原則

- [イラストで理解するSOLID原則](https://qiita.com/baby-degu/items/d058a62f145235a0f007)
- [SOLID 原則メモ](https://zenn.dev/megeton/articles/4aaa067fb3a8de)

- S：[単一責任の原則 (Single Responsibility)](https://plainprogram.com/single-responsibility-principle/)
  - God クラスを避ける・クラスを単一機能になるまで分割する
- O：[オープン・クローズドの原則（Open-Closed Principle）](https://plainprogram.com/open-closed-principle/)
  - 概要：オブジェクトに対して追加実装の余地がある（Open）・追加実装で既存機能の編集を要しない（Close）
  - アンチパターン：引数の内容に応じて分岐処理する
  - デザインパターン：[Factory Method を使う](https://qiita.com/k2491p/items/db69dd2dc43a5a678b4f)
- L：[リスコフの置換原則（Liskov Substitution）](https://plainprogram.com/liskov-substitution-principle/)
  - 概要：子クラスは親クラスのインターフェースを引き継がなければいけない
  - 備考：この原則を満たさないケースでは継承より委譲を使う
- I：[インターフェイス分離の原則 (Interface Segregation)](https://plainprogram.com/interface-segregation-principle/)
  - 概要：必須のインタフェースのみになるようクラスを分割する
  - 備考：共通化で使わないインタフェースが現れる場合はそもそも共通化をしない方がいい
- D：[依存性逆転の原則（Dependency Inversion Principle）](https://plainprogram.com/dependency-inversion-principle/)
  - 概要：上位・下位モジュールの依存は抽象化する。必要なメソッドのみに依存し、クラスの詳細に依存しない。
  - 例：[ダックタイピングを使う](https://code-graffiti.com/duck-typing-in-python/)（C++ ならテンプレート）
  - 例：[Dependency Injection](https://qiita.com/mkgask/items/d984f7f4d94cc39d8e3c)（内部でインスタンスを生成せずに引数として受け取る）

## GoF のデザインパターン

GoF のレビュー：

- [Python におけるデザインパターン](https://nishi2.info/pydp/)
  - シンプルな説明
- [Refactoring.Guru](https://refactoring.guru/ja)
  - 見やすい説明・複数言語での実装
- [ふと GoF のデザインパターンを再考しておく](http://www.moonmile.net/blog/archives/7678)
  - 実際の使われ方
- [再考: GoF デザインパターン](https://qiita.com/irxground/items/d1f9cc447bafa8db2388)
  - OOPの現代思想に照らしたコメント

### Abstruct Factory

- 概要：インスタンス生成専門のクラスを用意する
- 使い所：インスタンス生成が複雑・生成過程が似ているクラスが複数存在する
- 使用方法：
    1. インスタンスの生成過程を分割する。複数クラスが対象なら共通部分と非共通部分が別になるように分割する。
    2. 分割した手順をそれぞれメソッドに持つ Factory クラスを定義する。必要であれば共通部分について抽象規定クラスを定義する。
    3. Factory クラスのインスタンスを引数にする生成用の関数を定義する

### Factory Method パターン

- 概要：クラスを引数とする関数を定義して拡張性を持たせる
- 使い所：状況に応じて使用するクラスを変えたい場合
- 使用方法：
    1. クラスの使い分けをしたい場合は if 文でインスタンス生成を分岐させず、クラス

### Prototype パターン

- 概要：生成コストが高いクラスはできるだけコンストラクタを使わずにインスタンスのコピーで生成
- 使い所：Python で copy.deepcopy を使うところそのもの。
- 備考：多言語では np.ndarray.copy のようにコピーされる側がコピーするためのメソッドを備えることを特徴とする。このようにすることで

### Singleton パターン

- 概要：システムの構造から単一のインスタンスのみを使うオブジェクトはグローバル変数とする

## その他

- [継承よりも委譲](https://qiita.com/kotetsu75/items/4b903023001f157554a4)
