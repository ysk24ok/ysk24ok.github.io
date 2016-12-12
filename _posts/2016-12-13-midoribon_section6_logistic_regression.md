---
layout: post
title: みどりぼん 第6章 ロジスティック回帰
tags: [midoribon, GLM, Japanese]
type: article
description: "みどりぼん第6章のロジスティック回帰について"
---

[みどりぼん](http://hosho.ees.hokudai.ac.jp/~kubo/ce/IwanamiBook.html)第6章のロジスティック回帰についてまとめた。

<!-- more -->

使用したデータは[こちら](http://hosho.ees.hokudai.ac.jp/~kubo/stat/iwanamibook/fig/binomial/data4a.csv)。
また、jupyter notebookは[こちら](/notebooks/midoribon_section6_logistic_regression.ipynb)。

## ロジスティック回帰

二項分布の確率分布は以下の式で表される。

$$p(y|N,q)={}_{N} C_{y}q^{y}(1-q)^{N-y}=\binom {N}{y}q^{y}(1-q)^{N-y}$$

$p(y\|N,q)$はある個体において$N$個の種子の中で$y$個が生存していた確率(生起確率)である。

尤度関数は

$$L=\prod_{i} \binom {N_{i}}{y_{i}}q_{i}^{y_{i}}(1-q_{i})^{N_{i}-y_{i}}$$

対数尤度は

$$\begin{align}
\log L
&=\sum_{i} \left( \log\binom {N_{i}}{y_{i}} + \log q_{i}^{y_{i}} + \log (1-q_{i})^{N_{i}-y_{i}} \right) \\
&=\sum_{i} \left( y_{i} \log q_{i} + (N_{i}-y_{i}) \log (1-q_{i}) \right)
\end{align}$$

個体$i$における生起確率$q\_{i}$はロジットリンク関数と線形予測子を使って以下のように表される。

$$\log \cfrac{q_{i}}{1-q_{i}}=\beta_{1}+\beta_{2}x_{i}+\beta_{3}f_{i}$$

なお、$z\_{i}=\beta\_{1}+\beta\_{2}x\_{i}+\beta\_{3}f\_{i}$。

ロジット関数の逆関数がロジスティック関数であり、生起確率$q\_i$は

$$q_{i}=\cfrac{1}{1+\exp(-z_{i})}$$

という、ロジスティック回帰の説明でよく見かける式で表される。

オッズ比(種子が生存する確率/種子が生存しない確率)は

$$\begin{align}
\cfrac{q_{i}}{1-q_{i}}
&=\exp \left( \beta_{1}+\beta_{2}x_{i}+\beta_{3}f_{i} \right)  \\
&=\exp(\beta_{1})\exp(\beta_{2}x_{i})\exp(\beta_{3}f_{i})
\end{align}$$

となり、説明変数が1単位増加するとオッズは何倍になる、と表すことができる。


## 観測データの概要

```python
%matplotlib inline

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.font_manager as fm

data = pd.read_csv('~/Downloads/data4a.csv')
fp = fm.FontProperties(fname='/Library/Fonts/Yu Gothic Medium.otf', size=12)
```

```python
data.info()
print()
print(data.describe())
```

```bash
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 100 entries, 0 to 99
Data columns (total 4 columns):
N    100 non-null int64
y    100 non-null int64
x    100 non-null float64
f    100 non-null object
dtypes: float64(1), int64(2), object(1)
memory usage: 3.2+ KB

           N           y           x
count  100.0  100.000000  100.000000
mean     8.0    5.080000    9.967200
std      0.0    2.743882    1.088954
min      8.0    0.000000    7.660000
25%      8.0    3.000000    9.337500
50%      8.0    6.000000    9.965000
75%      8.0    8.000000   10.770000
max      8.0    8.000000   12.440000
```

```python
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
ax.scatter(data.x[data.f=='C'], data.y[data.f=='C'], label='C', c='w')
ax.scatter(data.x[data.f=='T'], data.y[data.f=='T'], label='T')
ax.legend(loc='upper left')
ax.set_xlabel('植物の体サイズ x', fontproperties=fp)
ax.set_ylabel('生存種子数 y', fontproperties=fp)
ax.set_title('散布図', fontproperties=fp)
fig.show()
```

![png](/assets/images/midoribon/06/output_2_1.png)


## ロジスティック回帰でfitting

* statsmodelsで交互作用項なし
* statsmodelsで交互作用項あり
* scikit-learnで交互作用項なし

の3パターンでfittingさせてみる。

```python
# statsmodelsでロジスティック回帰
import statsmodels.api as sm
import statsmodels.formula.api as smf
# 交互作用項なし
# Rだとformula=cbind(y, N-y) ~ x + fと書くが、statsmodelsだと以下のように書く
glm = smf.glm(
    formula='y + I(N - y) ~ x + f', data=data, family=sm.families.Binomial())
res = glm.fit()
print('aic: {}'.format(res.aic))
print(res.summary())
# 交互作用項あり
glm_with_interaction = smf.glm(
    formula='y + I(N - y) ~ x * f', data=data, family=sm.families.Binomial())
res_with_interaction = glm_with_interaction.fit()
print('aic: {}'.format(res_with_interaction.aic))
print(res_with_interaction.summary())
```

```bash
aic: 272.2111292852234
                 Generalized Linear Model Regression Results                  
==============================================================================
Dep. Variable:      ['y', 'I(N - y)']   No. Observations:                  100
Model:                            GLM   Df Residuals:                       97
Model Family:                Binomial   Df Model:                            2
Link Function:                  logit   Scale:                             1.0
Method:                          IRLS   Log-Likelihood:                -133.11
Date:                Sat, 10 Dec 2016   Deviance:                       123.03
Time:                        17:26:18   Pearson chi2:                     109.
No. Iterations:                     8                                         
==============================================================================
                 coef    std err          z      P>|z|      [95.0% Conf. Int.]
------------------------------------------------------------------------------
Intercept    -19.5361      1.414    -13.818      0.000       -22.307   -16.765
f[T.T]         2.0215      0.231      8.740      0.000         1.568     2.475
x              1.9524      0.139     14.059      0.000         1.680     2.225
==============================================================================
aic: 273.61059672597395
                 Generalized Linear Model Regression Results                  
==============================================================================
Dep. Variable:      ['y', 'I(N - y)']   No. Observations:                  100
Model:                            GLM   Df Residuals:                       96
Model Family:                Binomial   Df Model:                            3
Link Function:                  logit   Scale:                             1.0
Method:                          IRLS   Log-Likelihood:                -132.81
Date:                Sat, 10 Dec 2016   Deviance:                       122.43
Time:                        17:26:18   Pearson chi2:                     109.
No. Iterations:                     8                                         
==============================================================================
                 coef    std err          z      P>|z|      [95.0% Conf. Int.]
------------------------------------------------------------------------------
Intercept    -18.5233      1.886     -9.821      0.000       -22.220   -14.827
f[T.T]        -0.0638      2.704     -0.024      0.981        -5.363     5.235
x              1.8525      0.186      9.983      0.000         1.489     2.216
x:f[T.T]       0.2163      0.280      0.772      0.440        -0.333     0.765
==============================================================================
```

交互作用項をいれたことでAICが低下している。

```python
# scikit-learnでロジスティック回帰
from sklearn.linear_model import LogisticRegression
from sklearn.feature_extraction import DictVectorizer

dv = DictVectorizer(sparse=False)
x = []
y = []
for idx, row in data.iterrows():
    d = {'x': row['x'], 'f': row['f']}
    pos_samples = row['y']
    neg_samples = N - pos_samples
    for i in range(0, pos_samples):
        x.append(d)
        y.append(1)
    for i in range(0, neg_samples):
        x.append(d)
        y.append(0)
X = dv.fit_transform(x)
lr = LogisticRegression()
lr.fit(X, np.array(y))
print('切片: {}'.format(lr.intercept_[0]))
print('係数: {}'.format(
    ['{}: {}'.format(dv.feature_names_[i], lr.coef_[0][i])
     for i in range(0, len(lr.coef_[0]))]
))
```

```bash
切片: -6.712913691186477
係数: ['f=C: -3.9713121050258526', 'f=T: -2.741601586160561', 'x: 1.0855867430923245']
```

statsmodelsでfittingさせた結果と異なっている。

```python
N = 8
xrange = np.arange(min(data.x), max(data.x), (max(data.x) - min(data.x)) / 100)
# 施肥処理なし (f=C)
f = np.array(['C' for i in range(0, len(xrange))])
x_test = pd.DataFrame({'x': xrange, 'f': f})
x_test_for_sklearn = dv.transform(
    [{'x': xrange[i], 'f': f[i]} for i in range(0, len(xrange))]
)
y_test = res.predict(x_test)
y_test_with_interaction = res_with_interaction.predict(x_test)
y_test_for_sklearn = np.array([r[1] for r in lr.predict_proba(x_test_for_sklearn)])
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
ax.scatter(data.x[data.f=='C'], data.y[data.f=='C'], c='w')
# 1 / (1 + np.exp(-(-19.5361 + 1.9524 * x)))
ax.plot(xrange, y_test * N, c='g', label='交互作用項なし')
# 1 / (1 + np.exp(-(-18.5233 + 1.8525 * x)))
ax.plot(xrange, y_test_with_interaction * N, c='b', label='交互作用項あり')
# 1 / (1 + np.exp(-(-6.7129 + 1.0856 * x - 3.9713)))
ax.plot(xrange, y_test_for_sklearn * N, c='y', label='交互作用項なし(sklearn)')
ax.set_xlabel('植物の体サイズ x', fontproperties=fp)
ax.set_ylabel('生存種子数 y', fontproperties=fp)
ax.legend(loc='best', fontsize=10, prop=fp)
ax.set_title('施肥処理なし f=C', fontproperties=fp)
fig.show()
# 施肥処理あり (f=T)
f = np.array(['T' for i in range(0, len(xrange))])
x_test = pd.DataFrame({'x': xrange, 'f': f})
x_test_for_sklearn = dv.transform(
    [{'x': xrange[i], 'f': f[i]} for i in range(0, len(xrange))]
)
y_test = res.predict(x_test)
y_test_with_interaction = res_with_interaction.predict(x_test)
y_test_for_sklearn = np.array([r[1] for r in lr.predict_proba(x_test_for_sklearn)])
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
ax.scatter(data.x[data.f=='T'], data.y[data.f=='T'], c='w')
# 1 / (1 + np.exp(-(-19.5361 + 1.9524 * x + 2.0215)))
ax.plot(xrange, y_test * N, c='g', label='交互作用項なし')
# 1 / (1 + np.exp(-(-18.5233 + 1.8525 * x - 0.0638 + 0.2163 * x)))
ax.plot(xrange, y_test_with_interaction * N, c='b', label='交互作用項あり')
# 1 / (1 + np.exp(-(-6.7129 + 1.0856 * x - 2.7416)))
ax.plot(xrange, y_test_for_sklearn * N, c='y', label='交互作用項なし(sklearn)')
ax.set_xlabel('植物の体サイズ x', fontproperties=fp)
ax.set_ylabel('生存種子数 y', fontproperties=fp)
ax.legend(loc='lower right', fontsize=10, prop=fp)
ax.set_title('施肥処理あり f=T', fontproperties=fp)
fig.show()
```

![png](/assets/images/midoribon/06/output_5_1.png)
![png](/assets/images/midoribon/06/output_5_2.png)

## まとめ

* 「$N$個の観察対象のうち$k$個で反応が見られた」というデータは二項分布で表され  
  ロジットリンク関数と線形予測子を組み合わせたロジスティック回帰でモデリングする
* 交互作用項はむやみに使うべきではない
  - 交互作用項を含んだモデルがAIC最良になることもあるが、  
    ニセの交互作用で辻褄合わせをしているだけの可能性もあるので  
    「個体差」「場所差」の効果を表せるGLMを使う

## 参考文献・サイト

* [データ解析のための統計モデリング入門](http://hosho.ees.hokudai.ac.jp/~kubo/ce/IwanamiBook.html) 第6章
