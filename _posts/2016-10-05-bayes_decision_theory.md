---
layout: post
title: ベイズ決定理論
tags: [hajipata, bayes, Japanese]
type: blog
description: "はじめてのパターン認識におけるベイズ決定理論の説明が第3章と第4章にまたがっておりわかりづらく感じたため、まとめてみることにした。"
---


[はじめてのパターン認識](https://www.morikita.co.jp/books/book/2235)におけるベイズ決定理論の説明が  
第3章と第4章にまたがっておりわかりづらく感じたため、  
まとめてみることにした。

<!-- more -->

## ベイズの定理

$$P(C_{i}|\mathbf{x})=\cfrac{p(\mathbf{x}|C_{i})}{p(\mathbf{x})}P(C_{i})$$

* $P(C\_{i}\|\mathbf{x})$
  - 事後確率
  - あるサンプル$\mathbf{x}$が観測されたときにそれがクラス$C_{i}$に属している確率
* $p(\mathbf{x}\|C_{i})$
  - 尤度
  - クラスが与えられた下での観測サンプル$\mathbf{x}$の確率分布
  - $\mathbf{x}$がクラス$C_{i}$に属するのが尤もらしい
* $p(\mathbf{x})$
  - サンプル$\mathbf{x}$の生起確率
  - クラスとの同時確率$p(C_{i},\mathbf{x})$を$p(\mathbf{x})=\sum_{i=1}^{K}p(C_{i},\mathbf{x})$のように周辺化することで得られる
* $P(C_{i})$
  - 事前確率

## 事前にサンプルが得られている場合

事前にサンプルが得られており$p(\mathbf{x}|C_{i}), P(C_{i})$が計算できる場合、  
この識別問題はdeterministicなものとなる。

ベイズの識別規則は以下の式で与えられる。

$$\arg \max_{i}p(\mathbf{x}|C_{i})P(C_{i})$$

はじパタの3.1章の、喫煙と飲酒の有無から健康か否かを識別する問題がこれにあたる。

## サンプルが確率分布に従う場合

上のベイズの定理のクラス$C_{i}$をパラメータ$\theta$で置き換える。

$$P(\theta|\mathbf{x})=\cfrac{p(\mathbf{x}|\theta)}{p(\mathbf{x})}P(\theta)$$

### 連続確率分布の場合

正規分布を例にとる。  
はじパタの4.2章の説明がこれにあたる。

正規分布ではパラメータ$\theta$は平均$\mu$と分散$\sigma^{2}$になる。

パラメータ$\theta$の確率分布から$d$個の要素をもつサンプル$\mathbf{x}$が観測される確率密度分布$p(\mathbf{x}|\theta)$が  
$d$次元の多変量正規分布に従う場合、以下の式で表される。

$$N(\mathbf{x}|\mu,\Sigma)=\cfrac{1}{(2\pi)^{\frac{d}{2}}|\Sigma|^{\frac{d}{2}}}\exp\left(-\cfrac{1}{2}(\mathbf{x}-\mu)^{T}\Sigma^{-1}(\mathbf{x}-\mu)\right)$$

なお、$\mathbf{\mu}$は平均ベクトル、$\Sigma$は共分散行列である。

#### 識別関数

$i$番目のクラスのクラス条件付き確率$p(\mathbf{x}\|C_{i})$が正規分布に従うとき、  
事後確率$P(C_{i}\|\mathbf{x})$は

$$\begin{align}
P(C_{i}|\mathbf{x})
&=\cfrac{p(\mathbf{x}|C_{i})P(C_{i})}{p(\mathbf{x})} \\
&\propto 
\cfrac{P(C_{i})}{(2\pi)^{\frac{d}{2}}|\Sigma_{i}|^{\frac{d}{2}}}\exp\left(-\cfrac{1}{2}(\mathbf{x}-\mu_{i})^{T}\Sigma_{i}^{-1}(\mathbf{x}-\mu_{i})\right)
\end{align}$$

で表される。

対数をとり符号を反転させると、$i$番目のクラスから導かれる評価値は

$$g_{i}(\mathbf{x})=(\mathbf{x}-\mu_{i})^{T}\Sigma_{i}^{-1}(\mathbf{x}-\mu_{i})+\ln|\Sigma_{i}|-2\ln P(C_{i})$$

となるため、$g_{i}(\mathbf{x})$が最小となるクラスを選択すればよい。

#### 識別境界

クラス$i$とクラス$j$の識別境界$f_{ij}(\mathbf{x})$は

$$\begin{align}f_{ij}(\mathbf{x})
&=g_{i}(\mathbf{x}) - g_{j}(\mathbf{x})\\
&=\mathbf{x}^{T}(\Sigma_{i}^{-1}-\Sigma_{j}^{-1})\mathbf{x}+2(\mathbf{\mu}_{j}^{T}\Sigma_{j}^{-1}-\mathbf{\mu}_{i}^{T}\Sigma_{i}^{-1})\mathbf{x}  \\
&\quad+\mathbf{\mu}_{i}^{T}\Sigma_{i}^{-1}\mathbf{\mu}_{i}
      +\mathbf{\mu}_{j}^{T}\Sigma_{j}^{-1}\mathbf{\mu}_{j}
      + F  \\
&=\mathbf{\mu}^{T}\mathbf{S}\mathbf{\mu}+2\mathbf{c}^{T}\mathbf{x} + F \\
&=0
\end{align}$$

となり(スカラ$F$の定義は本と異なる)、2次曲面になる。

$\Sigma_{i}=\Sigma_{j}$のように2クラスの共分散行列が等しい場合、識別境界は

$$f_{ij}(\mathbf{x})=2\mathbf{c}^{T}\mathbf{x}+F=0$$

となり、線形識別関数になる。

さらに、$\Sigma_{i}=\sigma \mathbf{I}$のように2クラスの共分散行列が同じ等方性分散をもち、  
かつクラスの事前確率が等しく$P(C_{i})=P(C_{j})$であれば

$$f_{ij}(\mathbf{x})=(\mathbf{x}-\mathbf{\mu_{i}})^{T}(\mathbf{x}-\mathbf{\mu_{i}})-(\mathbf{x}-\mathbf{\mu_{j}})^{T}(\mathbf{x}-\mathbf{\mu_{j}})=0$$

となり、2つのクラスの平均ベクトルとのユークリッド距離の2乗が小さい方のクラスに識別される。  
これは最近傍法と同じになる。

### 離散確率分布の場合

後日追記予定。

## 参考文献・サイト
* [はじめてのパターン認識](https://www.morikita.co.jp/books/book/2235) 第3,4章
* [ベイズ決定理論](http://home.hiroshima-u.ac.jp/tkurita/lecture/prnn/node2.html)
