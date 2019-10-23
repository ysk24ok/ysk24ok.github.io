---
layout: post
title: ログレベル回帰と対数リンク線形回帰の違い
tags: [GLM, Japanese]
type: article
description: ""
---

[計量経済学の第一歩](http://www.yuhikaku.co.jp/books/detail/9784641150287)を読んでいて目的変数を対数変換するログレベル回帰が話に出てきたが、  
リンク関数がlogの線形回帰とどう違うのか分からなかったので、その違いについてまとめた。

<!-- more -->

正直、[対数変換と一般化線形モデル - DTAL（旧RCEAL）留学記録](http://d.hatena.ne.jp/mrkm-a/20140513/p1)のほうがわかりやすいのでこの記事を読むべき。

# 違い

$\alpha$を傾き、$\beta$を切片、$\epsilon$を誤差項とする。

## ログレベル回帰 (log-level regression)

$$\ln{y} = \alpha x + \beta + \epsilon$$

ログレベル回帰では目的変数$y$を対数変換し、$\ln{y}$と$\alpha x + \beta$の差を最小化する。  
このとき、誤差項$\epsilon$は右辺に存在する。

$y$をオリジナルスケールに戻すと、

$$y = \exp^{\alpha x + \beta + \epsilon}$$

となる。  
つまり、誤差項は指数変換した正規分布(=対数正規分布)にしたがう。

## 対数リンク線形回帰 (log-link linear regression)

$$\ln{(y + \epsilon)} = \alpha x + \beta$$

対数リンク関数を使用した線形回帰では、誤差項$\epsilon$は左辺に存在する。

$y$をオリジナルスケールに戻すと、

$$y = \exp^{\alpha x + \beta} + \epsilon$$

となり、誤差項は正規分布にしたがう。

## 使い分け

オリジナルスケールに戻したときの誤差構造によると言える。  
つまり、誤差が正規分布にしたがうと仮定しているなら対数リンク線形回帰、  
誤差が対数正規分布にしたがうと仮定しているならログレベル回帰を使用する。

# statsmodelsで比較

本書で使用されている5\_1\_income.csvを使用する。  
このcsvには

* `yeduc`: 教育年数
* `income`: 収入
* `lincome`: `yeduc`を対数変換したもの
* `lyeduc`: `income`を対数変換したもの

の4つのカラムが含まれている。

教育年数から収入を説明するモデルを、  

* ログレベル回帰 (`yeduc`で`lincome`を説明する)
* 対数リンク線形回帰 (`yeduc`で`income`を説明する)

の2パターンで作成する。


<script src="https://gist.github.com/ysk24ok/48e0ead26db35b1615011cee331586d0.js"></script>

推定した回帰パラメータの値は微妙に異なっており、  
ログレベル回帰と対数リンク線形回帰は別物であることがわかる。

# 参考

* [対数変換と一般化線形モデル - DTAL（旧RCEAL）留学記録](http://d.hatena.ne.jp/mrkm-a/20140513/p1)
* [Interpret Regression Coefficient Estimates - {level-level, log-level, level-log &amp; log-log regression} - Curtis Kephart](http://www.cazaar.com/ta/econ113/interpreting-beta)
