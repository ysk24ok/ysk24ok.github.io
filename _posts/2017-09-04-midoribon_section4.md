---
layout: post
title: みどりぼん 第4章 GLMのモデル選択
tags: [midoribon, GLM, Japanese]
type: article
description: "みどりぼん第4章 GLMのモデル選択を読んでまとめた。"
---

みどりぼん第4章 GLMのモデル選択を読んでまとめた。

<!-- more -->

* [data3a.csv](http://hosho.ees.hokudai.ac.jp/~kubo/stat/iwanamibook/fig/poisson/data3a.csv)
* [notebook](https://nbviewer.jupyter.org/gist/ysk24ok/4f057866adf7876a34d4541929186f0e)

## モデル選択規準AIC

|モデル|パラメータ数<br>$k$|最大対数尤度<br>$\log L^{\*}$|逸脱度<br>$-2\log L^{\*}$|残差逸脱度|平均対数尤度<br>$\log L^{\*}-k$|AIC<br>$-2(\log L^{\*}-k)$|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|null model|1|-237.64|475.29|89.51|-238.64|477.29|
|$x$|2|-235.39|470.77|84.99|-237.39|474.77|
|$f$|2|-237.63|475.25|89.48|-239.63|479.25|
|$x + f$|3|-235.29|470.59|84.81|-238.29|476.59|
|full model|100|-192.89|385.78|0|-292.89|585.78|

### 最大対数尤度

* $\log L^{\*}$
* 観測データに対する統計モデルの当てはまりの良さ

### 逸脱度 (deviance)

* $D=-2\log L^{\*}$
* 観測データに対する統計モデルの当てはまりの悪さ
* -2を掛けているのはカイ二乗検定との対応関係が良くなるかららしい

### 最小逸脱度・最大逸脱度

* $D\_{min}, D\_{max}$
* 最小逸脱度はfull modelの逸脱度、最大逸脱度はnull modelの逸脱度

### 残差逸脱度 (residual deviance)

* $D-D\_{min}$
* 最小逸脱度を基準とした逸脱度
* statsmodelsのGLMresults.devianceで表示されるのは残差逸脱度

### 平均対数尤度

* $\log L^{\*}-k$
* 統計モデルの平均的な当てはまりの良さ
* たとえ無意味なパラメータでも増やせば増やすほど最大対数尤度は良化するので、  
  パラメータ数をバイアスとして補正する

### AIC

* $-2(\log L^{\*}-k)$
* 統計モデルの平均的な当てはまりの悪さ
* バイアス補正した逸脱度とも言える？

## まとめ

* AICはネストしているモデル間の比較に有用
  - 追加したパラメータが説明力があればAICは低下する
  - 追加したパラメータが無意味であればAICは増加する
* ネストしていない複数のモデル間でAICによるモデル選択は可能か？
  - 「たぶん問題ないだろうといった理由で使われているのが現状です」とある
  - 本当は使えないんだけど使われてしまっている、の意？
* データ数が少ない場合は、真のモデルよりパラメータ数の少ない単純なモデルのほうが  
  予測能力が高い可能性がある
* AIC以外のモデル選択規準には交差検証法やブートストラップ情報量規準などがある


## 参考文献・サイト

* [データ解析のための統計モデリング入門](http://hosho.ees.hokudai.ac.jp/~kubo/ce/IwanamiBook.html) 第4章
