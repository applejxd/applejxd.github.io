---
title: 競技プログラミング Tips
---

## リンク

- [C++ STL メモ](STL.md)

## リソース関連

- 計算量
  - AtCoder の計算量の足切りは 1e+8 程度
  - おおよそ {1e+4}_C_2 程度
- メモリ
  - AtCoder ではメモリ上限は 1024MB
  - 大容量のメモリはローカル変数ではなく[static変数・グローバル変数で確保](https://nanoseeing.hatenablog.com/entry/2021/02/01/173812)
  - int (4bytes)・long long (8 bytes) なら 1e+8 個程

## 文字列処理

char と int 間の変換は [ASCII コードのオフセットを利用](https://marycore.jp/prog/c-lang/convert-or-cast-char-to-int/)して実施。

```cpp
int num_int = 5;
// '5' = 5 + 48
char num_char = num_int + '0';

num_char = '5';
// 5 = '5' - 48
num_int = num_char - '0';
```

[文字・文字列の宣言には注意。](https://programming.pc-note.net/c/mojiretsu.html)
シングルクォーテーションで囲まれた文字は文字リテラルとして認識される。
ダブルクォーテーションで囲まれた文字・文字列はそのリテラルが格納された文字列の先頭アドレスになる。

```cpp
// そのまま文字リテラルとして認識
char num_char = '8';
// 137 という文字列型の先頭アドレスを指す
std::string num_string = "137";
```

正規表現には[std::regex](https://cpprefjp.github.io/reference/regex.html)を利用。

```cpp
std::regex re("[0-9]");
// 文字リテラルの判定であればシングルクォーテーションでリテラル表記
bool is_match = std::regex('8', re);
```
