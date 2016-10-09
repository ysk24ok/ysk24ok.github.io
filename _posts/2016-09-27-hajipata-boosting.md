---
layout: post
title: はじめてのパターン認識 第11章 boosting
tags: [hajipata, ensemble learning, Japanese]
type: article
description: "はじめてのパターン認識 第11章のboostingについてまとめた。"
---

<div class='post-img'>
  <img src="/assets/images/hajipata/cover.jpg" width="20%">
</div>

[はじめてのパターン認識](https://www.morikita.co.jp/books/book/2235) 第11章のboostingについてまとめた。

<!-- more -->

## boostingとは

複数の弱学習器を直列に並べ、  
前の学習器の結果を使って次の学習器で学習するという逐次的なプロセスで  
強学習器を作るアンサンブル学習の1種。

## 特徴

* baggingと異なり学習を並列化できないため時間がかかる。
* 過学習を起こしやすいため、弱学習器には小さな木が用いられる。
  - baggingでは各学習器に大きな木を使っても  
    過学習を抑えることができた

## AdaBoost

AdaBoostでは、前の弱学習器で誤って識別されたサンプルに対する重みを大きく、  
正しく識別されたサンプルに対する重みを小さくすることで、  
誤って識別されやすいサンプルを集中的に学習する。


### アルゴリズム

* 学習データ: $\mathbf{x}\_{i}\in \mathbb{R}^{d}, t\_{i}=\\{-1, +1\\}\quad(i=1,\cdots,N)$
* 弱識別器: $y_m(\mathbf{x})=\\{-1,+1\\}\quad(m=1,\cdots,M)$
* $m$番目の弱識別器における$i$番目のデータの重み: $w_{i}^{m}$

とすると、

1. 重みを$w_{i}^{1}=\frac{1}{N}\quad(i=1,\cdots,N)$に初期化する。
2. ステップ$m=1$から$M$まで以下をおこなう。
    - 重み付き誤差関数$E_{m}$が最小になるように学習する。
      + $$\begin{equation}
        \label{eq_11_21}
        E_{m}=\cfrac{\sum_{i=1}^{N} w_{i}^{m} I\left(y_{m}(\mathbf{x}_{i}) \ne t_{i}\right)}{\sum_{i=1}^{N} w_{i}^{m}} \tag{11.21}
        \end{equation}$$
      + $I\left(y\_{m}(\mathbf{x}\_{i}) \ne t\_{i}\right)$は識別器の出力がサンプルのラベルと一致したとき$0$、  
        一致しなかったとき$1$となる指示関数であるため、  
        $E_{m}$は誤ったサンプルの正規化された重みの和となる。
    - 弱識別器$y_{m}(\mathbf{x})$に対する重み$\alpha_{m}$を計算する。
      + $$\begin{equation}
        \label{eq_11_22}
        \alpha_{m}=\ln\left( \cfrac{1-E_{m}}{E_{m}} \right) \tag{11.22}
        \end{equation}$$
      + 弱識別器はランダム推定よりも性能が良いものを指すため  
        $E_{m}<\frac{1}{2}$となり、$\alpha_{m}>0$となる。  
        また、誤差が小さい識別器ほど大きな重みを与えられる。
    - 重み$w_{i}^{m}$を更新する。
      + $$\begin{equation}
        \label{eq_11_23}
        w_{i}^{m+1}=w_{i}^{m} \exp \left(\alpha_{m} I(y_{m}(\mathbf{x}_{i}) \ne t_{i})\right) \tag{11.23}
        \end{equation}$$
      + 誤分類したサンプルの重みが$\exp(\alpha_{m})>1$倍される。  
        正しく分類されたサンプルの重みは変更されないが、  
        $E_{m+1}$の計算で正規化されるため相対的に小さくなる。
3. 入力$\mathbf{x}$に対する識別結果を求める。
  - $$Y_{M}(\mathbf{x})=sign\left( \sum_{m=1}^{M} \alpha_{m} y_{m}(\mathbf{x})\right)$$
  - ここで、$sign(\alpha)$は符号関数であり、  
    $\alpha>0$で+1、$\alpha=0$で0、$\alpha<0$で1を出力する。

### 導出

#### 損失関数$E_{m}$の導出

指数誤差関数

$$E=\sum_{i=1}^{N}\exp(-t_{i}f_{m} \left( \mathbf{x}_{i}) \right)$$

を$m=1$から$M$まで逐次最小化することで導出できる。

$f_{m}(\mathbf{x})$は

$$f_{m}(\mathbf{x})=\cfrac{1}{2}\sum_{j=1}^{m}\alpha_{j}y_{j}(\mathbf{x})$$

で定義された、弱識別器$y_{j}(\mathbf{x})$の$j=1$から$m$までの線形結合である。  

$m$番目の識別器における誤差$E$を$y_{m}(\mathbf{x})$と$\alpha_{m}$に関して最小化する。

$$\begin{align}
E&=\sum_{i=1}^{N}\exp(-t_{i}f_{m} \left( \mathbf{x}_{i}) \right)\\
&=\sum_{i=1}^{N} \exp \left( -t_{i}f_{m-1}(\mathbf{x}_{i}) - \cfrac{1}{2}t_{i}\alpha_{m}y_{m}(\mathbf{x}_{i}) \right) \\
&=\sum_{i=1}^{N} w_{i}^{m} \exp \left(-\cfrac{1}{2}t_{i}\alpha_{m}y_{m}(\mathbf{x}_{i}) \right) \quad \left( w_{i}^{m}=\exp (-t_{i}f_{m-1}(\mathbf{x}_{i}) ) \right) \\
&=\exp\left(-\cfrac{\alpha_{m}}{2}\right) \sum_{i\in T_{c}}w_{i}^{m} +\exp\left(\cfrac{\alpha_{m}}{2}\right)\sum_{i\in T_{e}} w_{i}^{m} \\
&\quad\quad
  \left(\begin{cases}
    t_{i}y_{m}(\mathbf{x}_{i})=1 & (i \in T_{c}) \\
    t_{i}y_{m}(\mathbf{x}_{i})=-1 & (i \in T_{e})
  \end{cases}\right)  \\
&=\exp\left(-\cfrac{\alpha_{m}}{2}\right) \left(\sum_{i=1}^{n}w_{i}^{m} - \sum_{i\in T_{e}} w_{i}^{m}\right) +\exp\left(\cfrac{\alpha_{m}}{2}\right)\sum_{i\in T_{e}} w_{i}^{m} \\
&= \left(\exp\left(\cfrac{\alpha_{m}}{2}\right) - \exp\left(-\cfrac{\alpha_{m}}{2}\right)\right)\sum_{i=1}^{N} w_{i}^{m} I(y_{m}(\mathbf{x}_{i}\ne t_{i})) + \exp\left(-\cfrac{\alpha_{m}}{2}\right)\sum_{i=1}^{N}w_{i}^{m} \\
&=\left(\exp\left(\cfrac{\alpha_{m}}{2}\right) - \exp\left(-\cfrac{\alpha_{m}}{2}\right)\right)A+\exp\left(-\cfrac{\alpha_{m}}{2}\right)B \\
&\quad\quad\left( A=\sum_{i=1}^{N} w_{i}^{m} I(y_{m}(\mathbf{x}_{i}\ne t_{i})),B=\sum_{i=1}^{N}w_{i}^{m} \right)
\end{align}$$

（途中で$w_{i}^{m}=\exp (-t_{i}f_{m-1}(\mathbf{x}_{i}))$とおいて式変形をしているが、  
  なぜ重みをそう置くのかはよくわからない。。。）

$y_{m}(\mathbf{x})$に関する$E$の最小化は、$B$が定数なので$A$の最小化に等しい。  
$B$は訓練データの重みの総和なので$A$を割ることで正規化して

$$\cfrac{A}{B}=\cfrac{\sum_{i=1}^{N} w_{i}^{m} I(y_{m}(\mathbf{x}_{i}\ne t_{i}))}{\sum_{i=1}^{N}w_{i}^{m}}=E_{m}$$

となり、式(\ref{eq_11_21})に一致する。

#### $\alpha_{m}$の更新

$E$を$\alpha_{m}$に関して最小化することを考える、

$\cfrac{\partial E}{\partial \alpha_{m}}
=\left( \cfrac{1}{2}\exp\left(\cfrac{\alpha_{m}}{2}\right) +  \cfrac{1}{2}\exp\left(-\cfrac{\alpha_{m}}{2}\right) \right)A - \cfrac{1}{2}\exp\left(-\cfrac{\alpha_{m}}{2}\right)B = 0$

より、

$$\left( \exp\left(\cfrac{\alpha_{m}}{2}\right)+\exp\left(-\cfrac{\alpha_{m}}{2}\right) \right)A = \exp\left(-\cfrac{\alpha_{m}}{2}\right)B \\
A\exp\left(\cfrac{\alpha_{m}}{2}\right) = (B-A)\exp\left(-\cfrac{\alpha_{m}}{2}\right) \\
\exp(\alpha_{m})=\cfrac{B-A}{A}$$

よって、$\alpha\_{m}=\ln\left(\cfrac{1-\frac{A}{B}}{\frac{A}{B}}\right)=\ln\left(\cfrac{1-E\_{m}}{E\_{m}}\right)$となり、式(\ref{eq_11_22})と一致する。  

#### $w_{i}^{m}$の更新

$E=\sum_{i=1}^{N} w_{i}^{m} \exp \left(-\cfrac{1}{2}t_{i}\alpha_{m}y_{m}(\mathbf{x}_{i}) \right)$より、$i$番目の学習サンプルの重みの更新式は

$$\begin{align}
w_{i}^{m+1}&=\sum_{i=1}^{N} w_{i}^{m} \exp \left(-\cfrac{1}{2}t_{i}\alpha_{m}y_{m}(\mathbf{x}_{i}) \right) \\
&=\begin{cases}
w_{i}^{m}\exp\left(-\cfrac{\alpha_{m}}{2}\right) & (t_{i}y_{m}(\mathbf{x}_{i})=1) \\
w_{i}^{m}\exp\left(\cfrac{\alpha_{m}}{2}\right) & (t_{i}y_{m}(\mathbf{x}_{i})=-1)
\end{cases} \\
&=w_{i}^{m} \exp\left(\cfrac{\alpha_{m}}{2}\right) \exp\left(\alpha_{m}I(y_{m}(\mathbf{x}\ne t_{i}))\right)
\end{align}$$

となり、式(\ref{eq_11_23})と一致する。

## 前進逐次加法モデリング (forward stagewise additive modeling)

AdaBoostの出力関数$f(\mathbf{x})=\sum_{m=1}^{M}\alpha_{m}y_{m}(\mathbf{x};\gamma_{m})$は  
$f(\mathbf{x})$を基底関数$y_{m}(\mathbf{x};\gamma_{m})$で加法展開しているので、  
**加法モデル(additive model)**と呼ばれる。  
$m=1$のとき$f(\mathbf{x})=\alpha_{1}y_{1}$、  
$m=2$のとき$f(\mathbf{x})=\alpha_{1}y_{1}+\alpha_{2}y_{2}$、  
$m=3$のとき$f(\mathbf{x})=\alpha_{1}y_{1}+\alpha_{2}y_{2}+\alpha_{3}y_{3}$、...  
のように、$y_{m}$が$f(\mathbf{x})$に線形結合で加算されていくためである。  
なお、$\gamma_{m}$は誤差関数を最小にする識別器$m$のパラメータである。

また、各$y_{m}$において誤差関数を逐次的に最小化することでパラメータ$\gamma_{m}$を算出、加法モデルを求めていることから、  
**前進逐次加法モデリング(forward stagewise additive modeling)**と呼ばれる。


### アルゴリズム

* 学習データ: $\mathbf{x}\_{i}\in \mathbb{R}^{d}, t\_{i}=\\{-1, +1\\}\quad(i=1,\cdots,N)$  
* 基底関数: $y_m(\mathbf{x})=\\{-1,+1\\}\quad(m=1,\cdots,M)$
* 基底関数$y_{m}$にかける重み: $\alpha_{m}$
* 基底関数$y_{m}$のパラメータ: $\gamma$

1. $f_{0}=0$とおく
2. ステップ$m=1$から$M$まで以下をおこなう。
    - 誤差関数$L(t_{i},y_{m})$を$\alpha$, $\gamma$について最小化する
      + $$\begin{equation}
        \label{eq_11_34}
        \arg \min_{\alpha, \gamma} \sum_{i=1}^{N} L\left( t_{i}, f_{m-1}(\mathbf{x})+\alpha y_{m}(\mathbf{x}_{i};\gamma) \right) \tag{11.34}
        \end{equation}$$
    - $f(\mathbf{x})$を更新する
      + $$f_{m}(\mathbf{x})=f_{m-1}(\mathbf{x})+\alpha_{m}y_{m}(\mathbf{x};\gamma_{m})$$


## 勾配ブースティング (Gradient Boosting)

AdaBoostでは損失関数に指数誤差関数を使用したのに対し、  
Gradient Boostingは様々な微分可能な損失関数を使用できるように  
より一般化されている。

Gradient Boostingでは、式(\ref{eq_11_34})の最小化問題をsteepest descentで解くことで  
勾配の負の方向に$f(\mathbf{x})$を更新する。

$$f_{m}(\mathbf{x})=f_{m-1}(\mathbf{x})+\alpha_{m}\sum_{i=1}^{n}\nabla_{f} L(t_{i}, f_{m-1}(\mathbf{x}_{i}))$$

よって、$m$番目の弱識別器にかける重み$\alpha\_{m}$は  
勾配降下法におけるステップ幅とみなすこともできる。  
各弱識別器の誤差関数を$\nabla\_{f} L(t\_{i}, f\_{m-1}(\mathbf{x}\_{i}))$とすることで、  
ステップ幅$\alpha\_{m}$分だけ勾配の負の方向に$f(\mathbf{x})$を更新することができる。

### アルゴリズム

* 学習データ: $\mathbf{x}\_{i}\in \mathbb{R}^{d}, t\_{i}=\\{-1, +1\\}\quad(i=1,\cdots,N)$  
* 基底関数: $y_m(\mathbf{x})=\\{-1,+1\\}\quad(m=1,\cdots,M)$
* 基底関数$y_{m}$にかける重み: $\alpha_{m}$
* 基底関数$y_{m}$のパラメータ: $\gamma$
 
1. $f_{0}(\mathbf{x})=\arg \min_{\gamma} \sum_{i=1}^{N} L(t_{i}, \gamma)$となるように初期化する。$f_{0}(\mathbf{x})=\gamma$である。 
2. ステップ$m=1$から$M$まで以下をおこなう。
    - $i=1,2,\cdots,N$に対して次を計算する。
      + $$r_{im}=-\left[ \cfrac{\partial L(t_{i}, f(\mathbf{x}_{i}))}{\partial f(\mathbf{x}_{i})} \right]_{f(\mathbf{x})=f_{m-1}(\mathbf{x})}$$
    - $r_{im}$に学習器$y_{m}(\mathbf{x})$をfitさせる。
      + $$\gamma_{m}=\arg\min_{\gamma}\sum_{i=1}^{N}L(r_{im},y_m(\mathbf{x}_{i};\gamma))$$
    - line searchによりステップ幅$\alpha_{m}$に対して次を計算する。
      + $$\alpha_{m}=\arg \min_{\alpha}\sum_{i=1}^{n} L(t_{i}, f_{m-1}(\mathbf{x}_{i})+\alpha y_{m}(\mathbf{x}_{i};\gamma_{m}))$$
      + (勾配降下法におけるステップ幅あるいは学習率は  
 チューニングにより人間が決定するものかと思っていたが、  
 ここではline searchによる1次元探索で決定されるらしい？)
    - $f(\mathbf{x})$を更新する。
      + $$f_{m}(\mathbf{x})=f_{m-1}(\mathbf{x})+\alpha_{m}y_{m}(\mathbf{x})$$
3. $f_{M}(\mathbf{x})$を出力する。

## 勾配ブースティング木 (Gradient Tree Boosting)

特にGradient Boostingの弱学習器に決定木を用いたものを  
Gradient Tree Boosting, Gradient Boosting Decision Tree)などと呼ぶ。

各決定木の終端ノードを$R_{jm}(j=1,2,\cdots,J_{m})$とすると、  
出力関数$y_{m}$は以下のように表される。

$$y_{m}(\mathbf{x})=\sum_{j=1}^{J}b_{jm}I(\mathbf{x}\in R_{jm})$$

Gradient Boostingと同様に決定木を勾配$r_{im}$にfitさせるため、  
$b_{jm}$はノード$R_{jm}$に属する全$\mathbf{x}$の勾配の平均である。

各終端ノードにおいて勾配を求めるため、  
誤分類の多い(=誤差関数の値が大きい)ノードについては勾配が大きくなり  
よりgreedyにパラメータを更新できる。

ランダムサンプリングしたサンプルのみを用いる  
Stochastic Gradient Boostingというものも存在する。

### アルゴリズム

上のAdaBoost、Gradient Boostingの説明では$\gamma$は出力関数のパラメータであり、  
Gradient Tree Boostingでの$\gamma$も決定木のパラメータである。  
決定木のパラメータとはノード分割がおこなわれている特徴と  
その特徴平面上(特徴直線？)における点である。  
(決定木のパラメータを更新するというのがイメージできない。。。)

1. $\arg \min_{\gamma} \sum_{i=1}^{N} L(t_{i}, \gamma)$となるように初期化する。$f_{0}(\mathbf{x})=\gamma$である。 
2. ステップ$m=1$から$M$まで以下をおこなう。
    - $i=1,2,\cdots,N$に対して次を計算する。
      + $$r_{im}=-\left[ \cfrac{\partial L(t_{i}, f(\mathbf{x}_{i}))}{\partial f(\mathbf{x}_{i})} \right]_{f(\mathbf{x})=f_{m-1}(\mathbf{x})}$$
    - $r_{im}$を目的変数として回帰木を推定し、その終端ノードを$R_{jm}(j=1,2,\cdots,J_{m})$とする。
    - $j=1,2,\cdots,J_{m}$に対して次を計算する。
      + $$\gamma_{jm}=\arg \min_{\gamma}\sum_{\mathbf{x}_{i}\in R_{jm}} L(t_{i}, f_{m-1}(\mathbf{x}_{i})+\gamma)$$
    - $f(\mathbf{x})$を更新する。
      + $$f_{m}(\mathbf{x})=f_{m-1}(\mathbf{x}) + \sum_{j=1}^{J_{m}} \gamma_{jm}I(\mathbf{x}\in R_{jm})$$
3. $f_{M}(\mathbf{x})$を出力する。



## 参考文献・サイト

* [はじめてのパターン認識](https://www.morikita.co.jp/books/book/2235) 第11章
* [1.11. Ensemble methods — scikit-learn 0.17.1 documentation](http://scikit-learn.org/stable/modules/ensemble.html)
* [パッケージユーザーのための機械学習(12)：Xgboost (eXtreme Gradient Boosting) - 六本木で働くデータサイエンティストのブログ](http://tjo.hatenablog.com/entry/2015/05/15/190000)
* [AdaBoost - (主に)プログラミングのメモ](http://yoshihikomuto.hatenablog.jp/entry/20070823/1190044644)
* [Friedman, Jerome H. "Greedy function approximation: a gradient boosting machine." Annals of statistics (2001): 1189-1232.](http://statweb.stanford.edu/~jhf/ftp/trebst.pdf)
* [Friedman, Jerome H. "Stochastic gradient boosting." Computational Statistics & Data Analysis 38.4 (2002): 367-378.](https://statweb.stanford.edu/~jhf/ftp/stobst.pdf)
