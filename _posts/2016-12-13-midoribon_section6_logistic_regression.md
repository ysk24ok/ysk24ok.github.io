---
layout: post
title: みどりぼん 第6章 ロジスティック回帰
tags: [midoribon, GLM, Japanese]
type: article
description: "みどりぼん第6章のロジスティック回帰について"
---

[みどりぼん](http://hosho.ees.hokudai.ac.jp/~kubo/ce/IwanamiBook.html)第6章のロジスティック回帰についてまとめた。

<!-- more -->

# 二項分布

二項分布の確率分布は以下の式で表される。

$$p(y|N,q)={}_{N}C_{y} q^{y}(1-q)^{N-y}=\binom{N}{y} q^{y}(1-q)^{N-y}$$

$p(y\|N,q)$は事象の正規確率が$q$であるときに$N$個中の$y$個で事象が生起する確率である。

# ロジスティック回帰

個体$i$における生起確率$q\_{i}$はロジットリンク関数と線形予測子を使って以下のように表される。

$$\log \cfrac{q_{i}}{1-q_{i}}=\beta_{1}+\beta_{2}x_{i}+\beta_{3}f_{i}$$

ロジット関数の逆関数であるロジスティック関数を使うと、生起確率$q\_i$は

$$q_{i}=\cfrac{1}{1+\exp(-z_{i})}\quad(z_{i}=\beta_{1}+\beta_{2}x_{i}+\beta_{3}f_{i})$$

と表される。

尤度関数は

$$L(\{\beta_{j}\})=\prod_{i} \binom {N_{i}}{y_{i}}q_{i}^{y_{i}}(1-q_{i})^{N_{i}-y_{i}}$$

となり、対数尤度関数は

$$\log L(\{\beta_{j}\})=\sum_{i} \left( \log\binom {N_{i}}{y_{i}} + y_{i} \log q_{i} + (1-y_{i})\log (1-q_{i}) \right)$$

となる。


オッズ比（種子が生存する確率/種子が生存しない確率）は

$$\begin{align}
\cfrac{q_{i}}{1-q_{i}}
&=\exp \left( \beta_{1}+\beta_{2}x_{i}+\beta_{3}f_{i} \right)  \\
&=\exp(\beta_{1})\exp(\beta_{2}x_{i})\exp(\beta_{3}f_{i})
\end{align}$$

となり、説明変数が1単位増加するとオッズは何倍になる、と表すことができる。

# ロジスティック回帰と勾配降下法

ここでは記号を変え、はじパタ6.4に基づく。

訓練サンプル$i(0 \leq i \leq N)$の特徴ベクトルを$\boldsymbol{x}\_{i}$、ラベルを$t\_{i}$とすると、  
負の対数尤度関数は以下の式で表される。

$$\mathcal{L}(\pi_{1},\cdots,\pi_{N})=-\ln L(\pi_{1},\cdots,\pi_{N})=-\sum_{i=1}^{N} \left( t_{i} \ln \pi_{i} + (1-t_{i})\ln (1-\pi_{i}) \right)$$

ただし、$\pi$は二項分布のパラメータであり、sigmoid関数と係数ベクトル$\boldsymbol{\omega}$と$\boldsymbol{x}$を用いて、

$$\pi_{i}=\sigma(\boldsymbol{x}_{i})=\cfrac{1}{1+\exp(-\boldsymbol{\omega}^{T}\boldsymbol{x}_{i})}$$

と表される。

$\boldsymbol{\omega}$の成分$j$で$\mathcal{L}$を偏微分すると、

$$\cfrac{\partial \mathcal{L}}{\partial \omega_{j}}=-\sum_{i=1}^{N} \left( \cfrac{t_{i}}{\pi_{i}}\cfrac{\partial \pi_{i}}{\partial \omega_{j}} - \cfrac{1-t_{i}}{1-\pi_{i}}\cfrac{\partial \pi_{i}}{\partial \omega_{j}} \right)$$

$\frac{d\sigma(t)}{dt}=\sigma(t)\left(1-\sigma(t)\right)$なので、$\phi=\boldsymbol{\omega^{T}}\boldsymbol{x}_{i}$とすると、

$$\begin{align}
\cfrac{\partial \pi_{i}}{\partial \omega_{j}}
&=\cfrac{\partial \pi_{i}}{\partial \phi} \cdot \cfrac{\partial \phi}{\partial \omega_{j}} \\
&=\pi_{i}(1-\pi_{i}) \cdot x_{ij}
\end{align}$$

<!-- この式変形合ってる？ -->

よって、

$$\begin{align}
\cfrac{\partial \mathcal{L}}{\partial \omega_{j}}
&=-\sum_{i=1}^{N} x_{ij} \left(\cfrac{t_{i}}{\pi_{i}} \pi_{i}(1-\pi_{i}) - \cfrac{1-t_{i}}{1-\pi_{i}} \pi_{i}(1-\pi_{i}) \right)  \\
&=\sum_{i=1}^{N} x_{ij} \left( \pi_{i}-t_{i} \right)
\end{align}$$

$\boldsymbol{\omega}$の全成分で偏微分すると

$$\cfrac{\partial \mathcal{L}}{\partial \boldsymbol{\omega}}=\sum_{i=1}^{N} \boldsymbol{x}_{i} \left( \pi_{i}-t_{i} \right)$$


最急降下法による更新式は

$$\boldsymbol{\omega} \leftarrow \boldsymbol{\omega} - \eta \sum_{i=1}^{N} \boldsymbol{x}_{i} (\pi_{i}-t_{i})$$

確率的勾配降下法による更新式は

$$\boldsymbol{\omega} \leftarrow \boldsymbol{\omega} - \eta \boldsymbol{x}_{i} (\pi_{i}-t_{i})$$

# 生存種子数のモデリング

[本書で使用されていたサンプルデータ](http://hosho.ees.hokudai.ac.jp/~kubo/stat/iwanamibook/fig/binomial/data4a.csv)を使って、生存種子数をモデリングする。  
体サイズと施肥処理の有無をベースの説明変数とし、

* 交互作用項なし
* 交互作用項あり

の2つのモデルを比較したところ、交互作用項ありのモデルの方がAICが悪化した。  
このことから、交互作用項を加えてもモデルが複雑になるだけで予測性能は向上しないことがわかる。

<script src="https://gist.github.com/ysk24ok/9d6a6420a1ed679cbe93dc26273e3743.js"></script>

## まとめ

* 「$N$個の観察対象のうち$k$個で反応が見られた」というデータは二項分布で表され  
  ロジットリンク関数と線形予測子を組み合わせたロジスティック回帰でモデリングする
* 交互作用項はむやみに使うべきではない
  - 交互作用項を含んだモデルがAIC最良になることもあるが、  
    ニセの交互作用で辻褄合わせをしているだけの可能性もあるので  
    「個体差」「場所差」の効果を表せるGLMを使う

## 参考文献・サイト

* [データ解析のための統計モデリング入門](http://hosho.ees.hokudai.ac.jp/~kubo/ce/IwanamiBook.html) 第6章
* [はじめてのパターン認識](https://www.morikita.co.jp/books/book/2235) 6.4
* [第18回　ロジスティック回帰：機械学習 はじめよう｜gihyo.jp … 技術評論社](http://gihyo.jp/dev/serial/01/machine-learning/0018)
* [第19回　ロジスティック回帰の学習：機械学習 はじめよう｜gihyo.jp … 技術評論社](http://gihyo.jp/dev/serial/01/machine-learning/0019)
* [https://nbviewer.jupyter.org/gist/mitmul/9283713](http://nbviewer.jupyter.org/gist/mitmul/9283713)
