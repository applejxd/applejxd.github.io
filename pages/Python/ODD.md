---
title: Python で ODD
---

## SOLID 原則

- [イラストで理解するSOLID原則](https://qiita.com/baby-degu/items/d058a62f145235a0f007)
- [SOLID 原則メモ](https://zenn.dev/megeton/articles/4aaa067fb3a8de)

- S：[単一責任の原則 (Single Responsibility)](https://plainprogram.com/single-responsibility-principle/)
  - 概要：クラスを単一機能になるまで分割
  - アンチパターン：God クラス・Manager クラスができる
- O：[オープン・クローズドの原則（Open-Closed Principle）](https://plainprogram.com/open-closed-principle/)
  - 概要
    - オブジェクトに対して追加実装の余地がある（Open）
    - 追加実装で既存機能の編集を要しない（Close）
  - アンチパターン：引数の内容に応じて分岐処理
  - デザインパターン：[Factory Method](https://qiita.com/k2491p/items/db69dd2dc43a5a678b4f)
    - 機能改変時に処理オブジェクトは変更せずにデータオブジェクトのみを変更できるようにする
- L：[リスコフの置換原則（Liskov Substitution）](https://plainprogram.com/liskov-substitution-principle/)
  - 概要：子クラスは親クラスのインターフェースを引き継ぐべき
  - 備考：この原則を満たさないケースでは継承より委譲
- I：[インターフェイス分離の原則 (Interface Segregation)](https://plainprogram.com/interface-segregation-principle/)
  - 概要：必須のインタフェースのみになるようクラスを分割
  - 備考：共通化で使わないインタフェースが現れる場合は共通化をしない
- D：[依存性逆転の原則（Dependency Inversion Principle）](https://plainprogram.com/dependency-inversion-principle/)
  - 概要：上位・下位オブジェクトの依存は抽象化。具体実装に依存しない。
  - アンチパターン：上位オブジェクト内で下位オブジェクトのインスタンスを生成し使用
  - デザインパターン：[ダックタイピング](https://code-graffiti.com/duck-typing-in-python/)（C++ ならテンプレート）
    1. [Dependency Injection](https://qiita.com/mkgask/items/d984f7f4d94cc39d8e3c)：内部でインスタンスを生成せずに引数として受け取る
    2. 受け取るオブジェクトにインタフェースを定義してインタフェースに依存
    3. インタフェースを受け取り側に含める → ダックタイピング

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

### 生成に関するパターン

- [Factory の比較](https://refactoring.guru/ja/design-patterns/factory-comparison)
  - Factory：生成に関するクラス・メソッド・デザインパターン全般
  - 生成メソッド：新しいオブジェクトを生成するメソッド。コンストラクタのラッパー。
    - 既存のインスタンスををベースに生成・private の内容も使用して生成が可能
  - 静的生成メソッド：コンストラクタの代わりとなるメソッド
    - インスタンスを生成のポリモーフィズムで型が重複する（オーバーロードで対応できない）ケースで便利
  - 単純ファクトリーパターン：引数に応じた分岐で生成するインスタンスを切り替える
    - Factory 系デザインパターンのアンチパターン
  - Factory Method パターン：サブクラスでインスタンス生成のメソッドを定義・拡張
    - サブクラスの選択で生成内容が切り替えられる
  - Abstruct Factory パターン：インスタンス

#### Abstruct Factory

- 概要：インスタンス生成専門のクラスを用意・
- 使い所：
  - インスタンス生成が複雑
  - 生成過程が似ているクラスが複数存在する
- 使用方法：
    1. インスタンスの生成過程を分割。複数クラスが対象なら共通部分と非共通部分が別になるように分割。
    2. 分割した手順をそれぞれメソッドに持つ Factory クラスを定義。必要であれば共通部分について抽象基底クラスを定義。
    3. Factory クラスのインスタンスを引数に持つ生成用の関数を定義

#### Factory Method パターン

- 概要：クラスを引数とする関数を定義して拡張性を持たせる
- 使い所：状況に応じて使用するクラスを変えたい場合
- 使用方法：
    1. クラスの使い分けをしたい場合は if 文でインスタンス生成を分岐させず、クラス
    2.

#### Prototype パターン

- 概要：生成コストが高いクラスはできるだけコンストラクタを使わずにインスタンスのコピーで生成
- 使い所：Python で copy.deepcopy を使うところそのもの。
- 備考：多言語では np.ndarray.copy のようにコピーされる側がコピーするためのメソッドを備えることを特徴とする。このようにすることで

#### Singleton パターン

- 概要：システムの構造から単一のインスタンスのみを使うオブジェクトはグローバル変数とする

## その他

- [継承よりも委譲](https://qiita.com/kotetsu75/items/4b903023001f157554a4)
