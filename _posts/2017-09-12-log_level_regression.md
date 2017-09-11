---
layout: post
title: ログレベル回帰と対数リンク線形回帰の違い
tags: [scikit-learn, feature hashing]
type: article
description: ""
---

ログレベル回帰と対数リンク線形回帰の違いについてまとめた。

<!-- more -->

使用したnotebookは[こちら](https://gist.github.com/ysk24ok/48e0ead26db35b1615011cee331586d0)。  
$\alpha$を傾き、$\beta$を切片、$\epsilon$を誤差項とする。

## ログレベル回帰

$$\ln{y} = \alpha x + \beta + \epsilon$$

ログレベル回帰では目的変数$y$を対数変換し、$\ln{y}$と$\alpha x + \beta$の差を最小化する。  
このとき、誤差項$\epsilon$は右辺に存在する。

$y$をオリジナルスケールに戻すと、

$$y = \exp^{\alpha x + \beta + \epsilon}$$

となる。  
つまり、誤差項は指数変換した正規分布（= 対数正規分布）にしたがう。

## 対数リンク線形回帰

$$\ln{(y + \epsilon)} = \alpha x + \beta$$

対数リンク関数を使用した線形回帰では、誤差項$epsilon$は左辺に存在する。

$y$をオリジナルスケールに戻すと、

$$y = \exp^{\alpha x + \beta} + \epsilon$$

となり、誤差項は正規分布にしたがう。

## 使い分け

オリジナルスケールに戻したときの誤差構造によると言える。  

## statsmodelsで比較

[計量経済学の第一歩](http://www.yuhikaku.co.jp/books/detail/9784641150287)の例5.1で使用されている5\_1\_income.csvを使用する。

* ログレベル回帰

```py
>>> results = smf.glm('lincome ~ yeduc', data=df, family=sm.families.Gaussian()).fit()
>>> results.summary()
                 Generalized Linear Model Regression Results
==============================================================================
Dep. Variable:                lincome   No. Observations:                 4327
Model:                            GLM   Df Residuals:                     4325
Model Family:                Gaussian   Df Model:                            1
Link Function:               identity   Scale:                  0.786466860044
Method:                          IRLS   Log-Likelihood:                -5619.1
Date:                Fri, 08 Sep 2017   Deviance:                       3401.5
Time:                        08:13:19   Pearson chi2:                 3.40e+03
No. Iterations:                     2
==============================================================================
                 coef    std err          z      P>|z|      [0.025      0.975]
------------------------------------------------------------------------------
Intercept      4.3852      0.100     43.716      0.000       4.189       4.582
yeduc          0.0652      0.007      9.086      0.000       0.051       0.079
==============================================================================
```

* 対数リンク線形回帰

```py
>>> results = smf.glm('income ~ yeduc', data=df, family=sm.families.Gaussian(sm.families.links.log)).fit()
>>> results.summary()
                 Generalized Linear Model Regression Results
==============================================================================
Dep. Variable:                 income   No. Observations:                 4327
Model:                            GLM   Df Residuals:                     4325
Model Family:                Gaussian   Df Model:                            1
Link Function:                    log   Scale:                   28968.5915375
Method:                          IRLS   Log-Likelihood:                -28366.
Date:                Fri, 08 Sep 2017   Deviance:                   1.2529e+08
Time:                        08:14:11   Pearson chi2:                 1.25e+08
No. Iterations:                    13
==============================================================================
                 coef    std err          z      P>|z|      [0.025      0.975]
------------------------------------------------------------------------------
Intercept      4.1558      0.076     54.645      0.000       4.007       4.305
yeduc          0.1010      0.005     19.505      0.000       0.091       0.111
==============================================================================
```

パラメータの値が微妙に違っていることがわかる。

## 参考

* [対数変換と一般化線形モデル - DTAL（旧RCEAL）留学記録](http://d.hatena.ne.jp/mrkm-a/20140513/p1)
* [Interpret Regression Coefficient Estimates - {level-level, log-level, level-log &amp; log-log regression} - Curtis Kephart](http://www.cazaar.com/ta/econ113/interpreting-beta)
