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
  - OOP の現代思想に照らしたコメント

### 生成に関するパターン

- [Factory の比較](https://refactoring.guru/ja/design-patterns/factory-comparison)
  - Factory：生成に関するクラス・メソッド・デザインパターン全般
  - 生成メソッド：新しいオブジェクトを生成するメソッド。コンストラクタのラッパー。
    - 既存のインスタンスををベースに生成可能
    - private の内容も使用して生成が可能
  - 静的生成メソッド：インスタンスに依存しない生成メソッド
    - インスタンスを生成のポリモーフィズムで型が重複する（オーバーロードで対応できない）ケースで便利
  - 単純ファクトリーパターン：引数に応じた分岐で生成するインスタンスを切り替える
    - Factory 系デザインパターンのアンチパターン
  - Factory Method パターン：サブクラスでインスタンス生成のメソッドを定義・拡張
    - 生成専用メソッドでコンストラクタの肥大化を避ける
    - 具象化するまで生成方法を定義しない
    - サブクラスの選択で生成内容が切り替えられる
  - Abstruct Factory パターン：Factory クラスの選択で生成内容を切り替える
    - 生成専用クラスでコンストラクタの肥大化を避ける
    - Factory クラス群に対して抽象基底クラスを定義するから Abstruct Factory パターン
    - 抽象基底クラスの継承の代わりにダックタイピングを使っても OK

#### Factory Method パターン

- 概要：（サブクラスで）生成用のメソッドを定義
- 使い所：
  - オブジェクト生成が複雑
  - インターフェースが共通だが生成過程が異なるオブジェクトが複数存在
- 使用方法
  - 抽象基底クラスでは生成に関するメソッドを abstractmethod とする。継承時に定義。
  - あるいは(継承を使わずに)クラス自体を引数として与えダックタイピングを使う(Dependency Injection)

#### Abstruct Factory パターン

- 概要：オブジェクト生成用のクラスを定義
- 使い所：
  - オブジェクト生成が複雑
  - 生成過程が似ているオブジェクトが複数存在
- 使用方法：
    1. オブジェクトの生成過程を分割
       - 複数クラスが対象なら共通部分と非共通部分が別になるように分割
    2. 分割した手順をそれぞれメソッドに持つ Factory クラスを定義
       - 生成したいオブジェクトが複数種ある場合はそれ毎に Facotry クラスを定義
       - 必要であれば共通部分について抽象基底クラスを定義
    3. 生成用の関数を定義
       - 引数に与える Factory クラスのインスタンスに応じてオブジェクトの生成結果が異なる
       - Factory の抽象基底クラスを定義しない場合はダックタイピングを使うことになる

### Builder パターン

- 概要：Factory を用いた生成のためのクラスを定義
- 使い所：Factory を用いた生成で複数のケースが必要
- 使用方法：Builder を引数にもつ staticmethod を持つクラス(Director)を定義して使う

#### Prototype パターン

- 概要：生成コストが高いクラスはできるだけコンストラクタを使わずにインスタンスのコピーで生成
- 使い所：Python で copy.deepcopy を使うところそのもの。
- 備考：
  - np.ndarray.copy のようにコピーされる側がコピーするためのメソッドを定義してもよい

#### Singleton パターン

- 概要：インスタンスの生成が1度のみであればコンストラクタ等を隠蔽して classmethod でアクセス
- 備考：
  - モジュール同士の密結合を起こしかねないので注意
  - 使用するには単なるグローバル変数の使用との明確な差別化が必要

## その他

- [継承よりも委譲](https://qiita.com/kotetsu75/items/4b903023001f157554a4)
