---
title: JVM 言語 メモ
---

## Java Native Interface

- [JNI の型とデータ構造](https://tinyurl.com/yea545gs)
- インスタンスのやり取り：ポインタを long でキャストしてやりとり
  - [C++ クラスのインスタンスを Java/Kotlin に](https://tinyurl.com/yhck3ah3)
  - [Java/Kotlin の Mat インスタンスを C++ に](https://tinyurl.com/yjxam8k3)

## Kotlin

- 再代入
  - val (value)：final 変数・immutable reference
  - var (variable)：mutable reference
- [Null 安全](https://tinyurl.com/yzh2dn27)
  - Type?：Nullable
  - Type!!：強制アンラップ
  - エルビス演算子
  - lateinit
