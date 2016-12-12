---
layout: post
title: みどりぼん 第3章 ポワソン回帰
tags: [midoribon, GLM, Japanese]
type: article
description: "みどりぼん第3章を読んで自分の理解をまとめた。"
---

[みどりぼん](http://hosho.ees.hokudai.ac.jp/~kubo/ce/IwanamiBook.html)第3章を読んで自分の理解をまとめた。

<!-- more -->

使用したデータは[こちら](http://hosho.ees.hokudai.ac.jp/~kubo/stat/iwanamibook/fig/poisson/data3a.csv)。
また、jupyter notebookは[こちら](/notebooks/midoribon_section3.ipynb)。

## 観測データの概要を調べる

```python
%matplotlib inline

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.font_manager as fm

data = pd.read_csv('~/Downloads/data3a.csv')
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
Data columns (total 3 columns):
y    100 non-null int64
x    100 non-null float64
f    100 non-null object
dtypes: float64(1), int64(1), object(1)
memory usage: 2.4+ KB

y           x
count  100.000000  100.000000
mean     7.830000   10.089100
std      2.624881    1.008049
min      2.000000    7.190000
25%      6.000000    9.427500
50%      8.000000   10.155000
75%     10.000000   10.685000
max     15.000000   12.400000
```

散布図

```python
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
ax.scatter(data.x[data.f=='C'], data.y[data.f=='C'], label='C', c='w')
ax.scatter(data.x[data.f=='T'], data.y[data.f=='T'], label='T')
ax.legend(loc='upper left')
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_title('図 3.2', fontproperties=fp)
fig.show()
```

![png](/assets/images/midoribon/03/output_2_1.png)

箱ひげ図

```python
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
ax.boxplot([data.y[data.f=='C'], data.y[data.f=='T']])
ax.set_xticklabels(['C', 'T'])
ax.set_title('図 3.3', fontproperties=fp)
fig.show()
```

![png](/assets/images/midoribon/03/output_3_1.png)

ヒストグラム

```python
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
ax.hist(data.y)
ax.set_xlabel('y')
ax.set_ylabel('number')
ax.set_title('fig. 2')
fig.show()
```

![png](/assets/images/midoribon/03/output_4_1.png)

このヒストグラムや、

* 種子数$y\_{i}$は非負
* 種子数$y\_{i}$の下限は0だが、上限は未知
* 平均と分散が一致していそう

などの理由から、本では種子数$y\_{i}$のばらつきがポワソン分布にしたがうと仮定している。


## ポワソン回帰

観測データがポワソン分布にしたがうと仮定しているため、  
個体ごとの平均種子数$\lambda\_{i}$を目的変数、体サイズ$x$や施肥処理$f$を説明変数として  
ポワソン回帰であてはめる。

* 「個体ごとの」と言っているのは、  
  恐らく体サイズ$x$や施肥処理$f$などの個体ごとに異なる説明変数を考慮しているため
* 第2章では具体的な説明変数は考えていないので、「全個体共通の」平均と言っていると思われる

種子数が$y\_{i}$である確率$p(y\_{i}\|\lambda\_{i})$はポワソン分布にしたがっており、

$$p(y_{i}|\lambda_{i})=\cfrac{\lambda_{i}^{y_{i}}\exp(-\lambda_{i})}{y_{i}!}$$

で表される。


ポワソン回帰では平均種子数$\lambda\_{i}$は対数リンク関数と線形予測子を使って以下のように表される。

$$\log \lambda_{i} = \beta_{1}+\beta_{2}x_{i}$$

つまり、$\lambda$を説明変数$x, f$で説明するモデルになる（$y$を説明するのではない）。

対数尤度関数は、

$$\log L(\beta_{1},\beta_{2})=\sum_{i}\log(p(y_{i}|\lambda_{i}))$$

## 正規分布回帰

正規分布回帰では、分布のパラメータは平均$\mu$と標準偏差$\sigma$である。  
種子数が$y\_{i}$である確率$p(y\_{i}\|\mu\_{i}, \sigma\_{i})$はポワソン分布にしたがっており、

$$p(y_{i}|\mu_{i}, \sigma_{i})=\cfrac{1}{\sqrt{2\pi \sigma_{i}^{2}}}\exp\left(-\cfrac{(y_{i}-\mu_{i})^{2}}{2\sigma_{i}^{2}}\right)$$

で表される。

対数尤度関数は、

$$\log L(\mu_{i}, \sigma_{i})=-\cfrac{1}{2}\sum_{i}\log(2\pi\sigma_{i}^{2})-\cfrac{1}{2\sigma^{2}}\sum_{i}(y_{i}-\mu_{i})$$

ここで、標準偏差$\sigma\_{i}$はサンプルによらず一定とすると、

$$\log L(\mu_{i})=-\sum_{i}(y_{i}-\mu_{i})$$

恒等リンク関数と線形予測子を使って$\mu\_{i}=\beta_{1}+\beta_{2}x_{i}$と表すと、

$$\log L(\beta_{1},\beta_{2})=-\sum_{i}(y_{i}-(\beta_{1}+\beta_{2}x_{i}))$$

となり、結果的に$y$を説明変数が説明する形になるが、本来は説明変数は分布のパラメータを説明する。



## 説明変数に体サイズ$x$, 施肥処理の有無$f$を用いた場合

* 正規分布(恒等リンク関数)
* ポワソン分布(対数リンク関数)

の2パターンで回帰させてみる。


```python
fit_gaussian= smf.glm(formula='y ~ x + f', data=data, family=sm.families.Gaussian())
fit_poisson = smf.glm(formula='y ~ x + f', data=data, family=sm.families.Poisson())
print('- Gaussian(identity)')
print(fit_gaussian.fit().summary())
print()
print('- Poisson(log)')
print(fit_poisson.fit().summary())

xrange = np.arange(min(data.x), max(data.x), (max(data.x) - min(data.x)) / 100)
fig = plt.figure()
ax1 = fig.add_subplot(2, 1, 1)
ax1.scatter(data.x[data.f=='C'], data.y[data.f=='C'], label='C', c='w')
ax1.plot(xrange, 1.6169 + 0.6284 * xrange, label='Gaussian')
ax1.plot(xrange, np.exp(1.2631 + 0.0801 * xrange), label='Poisson')
ax1.legend(loc='upper left', fontsize=10)
ax1.set_xlabel('x')
ax1.set_ylabel('y')
ax1.set_title('fig. 4')
ax2 = fig.add_subplot(2, 1, 2)
ax2.scatter(data.x[data.f=='T'], data.y[data.f=='T'], label='T')
ax2.plot(xrange, 1.6169 + 0.6284 * xrange - 0.2538, label='Gaussian')
ax2.plot(xrange, np.exp(1.2631 + 0.0801 * xrange -  0.032), label='Poisson')
ax2.legend(loc='upper left', fontsize=10)
ax2.set_xlabel('x')
ax2.set_ylabel('y')
fig.show()
```

```bash
- Gaussian(identity)
                 Generalized Linear Model Regression Results                  
==============================================================================
Dep. Variable:                      y   No. Observations:                  100
Model:                            GLM   Df Residuals:                       97
Model Family:                Gaussian   Df Model:                            2
Link Function:               identity   Scale:                   6.65220528379
Method:                          IRLS   Log-Likelihood:                -235.12
Date:                Sun, 30 Oct 2016   Deviance:                       645.26
Time:                        17:13:38   Pearson chi2:                     645.
No. Iterations:                     4                                         
==============================================================================
                 coef    std err          z      P>|z|      [95.0% Conf. Int.]
------------------------------------------------------------------------------
Intercept      1.6169      2.653      0.610      0.542        -3.582     6.816
f[T.T]        -0.2538      0.537     -0.472      0.637        -1.307     0.800
x              0.6284      0.268      2.345      0.019         0.103     1.154
==============================================================================

- Poisson(log)
                 Generalized Linear Model Regression Results                  
==============================================================================
Dep. Variable:                      y   No. Observations:                  100
Model:                            GLM   Df Residuals:                       97
Model Family:                 Poisson   Df Model:                            2
Link Function:                    log   Scale:                             1.0
Method:                          IRLS   Log-Likelihood:                -235.29
Date:                Sun, 30 Oct 2016   Deviance:                       84.808
Time:                        17:13:38   Pearson chi2:                     83.8
No. Iterations:                     7                                         
==============================================================================
                 coef    std err          z      P>|z|      [95.0% Conf. Int.]
------------------------------------------------------------------------------
Intercept      1.2631      0.370      3.417      0.001         0.539     1.988
f[T.T]        -0.0320      0.074     -0.430      0.667        -0.178     0.114
x              0.0801      0.037      2.162      0.031         0.007     0.153
==============================================================================
```

![png](/assets/images/midoribon/03/output_6_2.png)

## まとめ

* どの分布を使用するかについて
  - 例えばサンプルの分布に正規分布を仮定するということは、  
    回帰値のまわりのばらつき方(残差)が正規分布に従うということ
  - なぜなら回帰値は観測サンプルの平均だから
  - その他の分布もまたしかり
  - そのため、実データの応答変数$y$の構造をよく考えて分布を選ぶことが重要
  - なんでも正規分布を仮定して直線回帰させれば良いというものではない

* どのリンク関数を使用するかについて
  - 分布関係なく、恒等リンク関数を用いた場合$y$の回帰値の集合は直線に、  
    対数リンク関数を用いた場合は指数関数となる
  - ちなみに、正規分布の正準リンク関数は恒等リンク関数、  
    ポワソン分布は対数リンク関数である
  - 恒等リンク関数を使った場合、各説明変数の回帰値への効果が加算で表され、  
    対数リンク関数を使った場合は乗算で表される

* 目的変数が種子数のようなカウントデータの場合はポワソン回帰を用いるとあるが、  
  平均値が大きくサンプルサイズが十分ある場合は正規分布にしたがうとしてもよい
  - 中心極限定理により、平均値(あるいは合計値)の分布は正規分布に近づくため
  - 事実、ポワソン分布でも$\lambda$が大きくなると分布の形は正規分布に近づく
  - 種子数は平均値が小さく、ポワソン回帰が適していたと思われる
  - 詳しくは[こちらのサイト](http://www.anlyznews.com/2013/09/blog-post_2173.html)を参照

* 疑問
  - 本によるとポワソン分布で対数リンク関数を使う理由は  
    「推定計算に都合よく」かつ「わかりやすい」からとあるが、  
    理論的な理由があるのか？
  - 正規分布で対数リンク関数を使うなど、  
    正準リンク関数ではないリンク関数を使う場面は存在するのか？
      + $x$が増加すると$y$は指数的に増加し、ばらつきは一定であるような場合？
      + [このサイト](http://d.hatena.ne.jp/mrkm-a/20140513/p1)によると$y=a e^{bx}+\epsilon$のような指数関数で  
        正規分布+対数リンク関数を使っている


## 参考文献・サイト

* [データ解析のための統計モデリング入門](http://hosho.ees.hokudai.ac.jp/~kubo/ce/IwanamiBook.html) 第3章
* [一般化線形 (混合) モデル (1) - 確率分布，最尤推定，ポアソン回帰](http://hosho.ees.hokudai.ac.jp/~kubo/stat/2013/ou1/kubostat2013ou1.pdf)
* [一般化線形モデルとは何か - 講義のページにようこそ](http://d.hatena.ne.jp/tomsekiguchi/20140209/1391944929)
* [Pythonで「データ解析のための統計モデリング入門」：第3章](http://imaimamu.com/archives/1928)
* [対数変換と一般化線形モデル - DTAL（旧RCEAL）留学記録](http://d.hatena.ne.jp/mrkm-a/20140513/p1)
* [今さら人に聞けない「重回帰分析の各手法の使い分け」 - 六本木で働くデータサイエンティストのブログ](http://tjo.hatenablog.com/entry/2013/09/18/235052)
* [「使い分け」ではなく「妥当かどうか」が大事：重回帰分析＆一般化線形モデル選択まわりの再まとめ - 六本木で働くデータサイエンティストのブログ](http://tjo.hatenablog.com/entry/2013/09/23/232814)
* [銀座で働くデータサイエンティストのモデル選択について: ニュースの社会科学的な裏側](http://www.anlyznews.com/2013/09/blog-post_2173.html)
* [ポアソン回帰で推定しているモノはλの式 -  餡子付゛録゛](http://uncorrelated.hatenablog.com/entry/20130919/1379599682)
