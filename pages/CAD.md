---
title: (Free)CAD メモ
---

FreeCAD のインストールは以下：

```powershell
winget install FreeCAD.FreeCAD
```

## 断面形状が一定の場合

次のいずれかで作れる：

1. 一定の断面が一方向に伸びるだけ → 「押し出し」を使用
2. 一定の断面がカーブ等を描く → 「パート」ベンチの「スイープ」

具体的な手順は以下：

1. 断面を Draft ワークベンチで作成
   1. どの断面を作図するかを決定：「押し出し」ならその断面。「スイープ」ならカーブ形状。
   2. [Draft_Line](https://wiki.freecad.org/Draft_Line) などで x-y 平面の形状を作図
   3. ワイヤ化：接続する線を全て選択し [Draft_Wire](https://wiki.freecad.org/Draft_Wire) を押して接続
      - `Draft_Upgrade` で作成したワイヤは[編集不可](https://wiki.freecad.org/Draft_Line)なので使ってはいけない
   4. 断面形状の作成：Draft 内で断面を作成し、90度回転させてどこかの断面として配置
2. 立体化：必ずソリッド化をしてプリント可能にする。（OFFだと体積0になる。）
   1. 「スイープ」
      1. 「パート」ベンチから「スイープ」を選択
      2. 断面を選択
      3. 「ソリッド化」をチェックしてから軌跡を Ctrl+Click で選択
      4. 実行
3. 「フィレット」：立体化してからのほうがフィレットしやすい
