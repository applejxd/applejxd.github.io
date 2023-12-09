--- 
title: LightGBM で時系列データ分析
---

- [LightGBM 公式](https://lightgbm.readthedocs.io/en/latest/)
- [原論文](https://papers.nips.cc/paper/6907-lightgbm-a-highly-efficient-gradient-boosting-decision-tree.pdf)
- [GBDTの解説](https://copypaste-ds.hatenablog.com/entry/2019/09/05/184947)

## CSV ファイルの読み込み

```python
import pandas as pd

# 学習・バリデーションデータの読み込み
train =  pd.read_csv('/path/to/training/data.csv')
# 説明変数(target カラム以外)
train_x = train.drop(['target'], axis=1)
# 目的変数(targetカラム)
train_y = train['target']

# 予測データの読み込み
test_x = pd.read_csv('/path/to/est/data.csv')
```

## 前処理

数値変数は欠損値処理・標準化等行わないでそのままでOK.
カテゴリ変数は label encoding する.

```python
from sklearn.preprocessing import LabelEncoder

# カテゴリ変数のカラム名
cat_cols = {"Category_hoge", "Category_fuga"}

for c in cat_cols:
    le = LabelEncoder()
    # 学習データに基づいて定義する
    le.fit(train_x[c])
    train_x[c] = le.transform(train_x[c])
    test_x[c] = le.transform(test_x[c])
```

## バリデーションデータの用意

1例として時期を4分割してクロスバリデーションする場合

```python
import numpy as np

# 分割数
n_fold = 4

# 時間に沿って変数periodを設定
# 学習・バリデーションデータ：0~3, 予測データ：4
train_x['period'] = np.arange(0, len(train_x)) // (len(train_x) // n_fold)
train_x['period'] = np.clip(train_x['period'], 0, n_fold-1)
test_x['period'] = n_fold

# 1 のバリデーションに 0を
# 2 のバリデーションに 0,1 を, ...
va_period_list = list(range(1, n_fold))
for va_period in va_period_list:
    # bool：学習データかどうか
    is_tr = train_x['period'] < va_period
    # bool：バリデーションデータかどうか
    is_va = train_x['period'] == va_period
    # 学習データとバリデーションデータに分離
    tr_x, va_x = train_x[is_tr].copy(), train_x[is_va].copy()
    tr_y, va_y = train_y[is_tr].copy(), train_y[is_va].copy()

    # 以降でモデル定義とバリデーションを実施
```

## モデル定義と予測

- 基本

    ```python
    import lightgbm as lgb
    from sklearn.metrics import mean_absolute_error

    # 特徴量と目的変数をlightgbmのデータ構造に変換する
    lgb_train = lgb.Dataset(tr_x, tr_y)
    lgb_eval = lgb.Dataset(va_x, va_y)

    # ハイパーパラメータの設定
    # 回帰タスク, MAE を指標に最適化. 再現性のために seed を指定.
    params = {'objective': 'regression', 'metrics': 'mae',
             'seed': 71, 'verbose': 0}
    num_round = 100

    # 学習の実行
    # カテゴリ変数をパラメータで指定
    # バリデーションデータもモデルに渡し、スコアがどう変わるかモニタリング
    model = lgb.train(params, lgb_train, num_boost_round=num_round,
                      categorical_feature=cat_cols,
                      valid_names=['train', 'valid'],
                      valid_sets=[lgb_train, lgb_eval])

    # バリデーションデータでのスコアの確認
    va_pred = model.predict(va_x)
    score = mean_absolute_error(va_y, va_pred)
    print(f'MAE: {score:.4f}')

    # 予測
    pred = model.predict(test_x)
    ```

- 複数の目的変数への対応：scikit-learn インターフェイスで [MultiOutputRegressor](https://qiita.com/katsuki104/items/71c7581cce60f0e303f3)

## 特徴量エンジニアリング

- 特徴量作成：[featuretools](https://qiita.com/Hyperion13fleet/items/4eaca365f28049fe11c7)
- 特徴量評価：[feature_importance](https://qiita.com/studio_haneya/items/e70e835c26524d506e19)

    ```python
    import pandas as pd
    imporetance = pd.DataFrame(model.feature_importance, 
        index=train_x.columns.values, columns=["importance"])
    print(importance)
    ```

## ハイパーパラメータの調整

- [パラメータの説明](https://lightgbm.readthedocs.io/en/latest/Parameters.html)
- [LightGBM Tuner](https://tech.preferred.jp/ja/blog/hyperparameter-tuning-with-optuna-integration-lightgbm-tuner/)
：単一のタスクで自動調整

    ```python
    import optuna.integration.lightgbm as lgb

    # 最適パラメータ・探索履歴を保存
    best_params, tuning_history = dict(), list()
    booster = lgb.train(params, dtrain, valid_sets=dval,
                    verbose_eval=0,
                    best_params=best_params,
                    tuning_history=tuning_history)
    ```

- [hyperopt](https://amalog.hateblo.jp/entry/data-analysis-snippets)
：複数のタスクを組み合わせて調整
