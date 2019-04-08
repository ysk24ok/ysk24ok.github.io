---
layout: post
title: reserve price最適化のpaperまとめ
tags: [paper, reserve price optimization, Japanese]
type: article
description: "reserve price最適化のpaperまとめ"
---

reserve price(floor price)最適化の論文をいくつか読んだので内容をメモ。

<!-- more -->

これまでに読んだreserve price最適化の論文のメモをまとめる。  
これ以降も読んだ論文が増えれば内容を追加していく予定だが、  
昔のpostを編集しつづけるのもブログっぽくない気がするのでいずれどこかにまとめ直すかも。


# Revenue Optimization with Approximate Bid Predictions

http://papers.nips.cc/paper/6782-revenue-optimization-with-approximate-bid-predictions  
NIPS2017 poster

## 概要

最適なreserve priceをsquared lossの回帰モデルとして推定することができる？らしい。  
理論の論文なので読めてません。。。


# Optimal Reserve Price for Online Ads Trading Based on Inventory Identification

https://dl.acm.org/citation.cfm?id=3124749.3124760  
ADKDD'17

## 概要

DSPが高額で入札してきている在庫についてreserve priceを高く設定することでseller側の収益を上げる。

## 提案手法

モデルはwinning bucket predictionとprice separation predictionの2stageをcascadingさせ、  
各stageではboostingで弱学習器をアンサンブルしている。

* winning bucket prediction (high value detection)
  - DSPの高額入札を特定する
  - 訓練データの1st priceをそのpriceのレンジに応じていくつかのbucketに離散化し、  
    あるオークションについて1st priceがどのbucketに属するかを予測するモデルを作る

* price separation prediction
  - 訓練データの1st priceと2nd priceの差を、  
    ある閾値以上であればpositive、それ以下であればnegativeとしてニ値化し、  
    あるオークションについて1stと2ndの価格差が閾値以上に大きいかどうかを予測するモデルを作る

cascadingでは複数stageのうち1つでもnegativeと判定すればモデル全体としてnegativeと判定するため、
false positive rateを下げることができる。
reserve priceがbid priceを上回ってしまうと落札されずrevenueは0になってしまうので、
cascadingを使うことで確実にbid price > reserve priceとなるオークションのみに適用できるようにする。

## 実験結果

Yahoo ads exchangeのデータからrandom samplingしたデータに対してシミュレーションした結果、  
DSPが高額入札してくる割合は多くないにも関わらず、全体で3.5%の収益増となった。

productionで少量のトラフィックを流して試しており、  
false positive率を減らすために収益の増加は抑え気味にしている。

## コメント

* 弱学習器として具体的に何を使用しているかは書いていないような？
* オークションに対してDSPが高額入札するかどうかを予測する部分について書いてはあるものの、具体的にreserve priceをいくらで設定するかは書いていないような？
* conclusionにも書いているが、DSPの高額入札に対してreserve priceを高く設定するため  
  DSP側が高額で入札するときに支払いが増えていることに気付き、高額での入札をやめる可能性がある。  
  そのため短期的には収益が上がっても長期的に見るとどうなんだろうというのはある。


# Data-Driven Reserve Prices for Social Advertising Auctions at LinkedIn

https://dl.acm.org/citation.cfm?id=3124749.3124759  
ADKDD'17

## 概要

ユーザ単位で求めたreserve priceからセグメント単位のreserve priceを推定し、  
advertiser experinceとpublisherの収益の上昇を図る。

## 提案手法

入札者の評価値を対数正規分布を仮定した線形回帰でモデリングする。  
このときの$X$はオークション数xユーザのfeature数の行列、$y$は入札価格(1st price？)の対数である。  
これによりユーザごとにreserve priceを求めることができる。  

ユーザごとのreserve priceはpublicにせず、  
これを使い式(6)によってcampaign単位(ユーザセグメント単位？)でreserve priceを計算している。  
入札額が低い傾向にある新興国のユーザセグメントか入札額が比較的高くなる傾向にある先進国のユーザセグメントかによって  
式(6)の$p$の値を調整している。

## 結果

実際にシステムに実装して実データで実験した。  
reserve price最適化によって収益が上がったかどうかを測るrevenue-related metric、  
advertiserへの影響（campaignの新規作成率や停止率）を測るadvertiser-centric metricの2種類を使用した。  
結果、revenueは増加し、advertiserへの悪影響も見られなかった。

## コメント

* 対数正規分布を仮定した線形回帰による入札者の評価値のモデリングがシンプルで使えるかも
* 実験時にadvertiserのcampaignの新規作成率や停止率も評価しているのが良い。  
  reserve priceを最適化すると入札者からすると支払いが増え、  
  入札数が減るなどの対応がなされることが考えられるため。


# Real-Time Optimization of Web Publisher RTB Revenues

https://dl.acm.org/citation.cfm?id=3098150  
KDD'17

## 概要

1st priceと2nd priceが打ち切られる可能性のある状況でも最適なreserve priceをオークションごとに予測する。

## 前提

1st priceを$b_{1}$、2nd priceを$b_{2}$、reserve priceを$r$としたとき、

1. $b_{1} < r$のとき、fully censored (1st, 2ndともに観測できない)
2. $b_{2} < r \leq b_{1}$のとき、half censored (1stのみ観測できる)
3. $r \leq b_{2}$のとき、not censored (1stも2ndも観測できる)

上2つは$b_{1}$あるいは$b_{2}$の上限が分かっているためleft censoredである。

## 提案手法

上記の通りbid priceは打ち切られるケースがあるため、  
打ち切りデータにも対応できるモデルとして生存解析を利用する。  
まず、1st priceの分布のモデリングを考える(2nd priceの場合も基本的に同じ)。

生存時間関数の横軸は通常時間であり、  
ハザード関数は時間$t$までイベントが起こらなかった条件の下で時間$t+\Delta t$にイベントが起こる確率である。  
1st priceのモデリングでは横軸は価格となり、  
ハザード関数$\lambda$はbid priceが$\Delta p$だけ上昇した時にそのbid priceが観測される確率となる。

ここで、観測した全オークション$n$を1st price順に$K$個のグループに離散化する。  
1番目のグループは1st priceが最も低いオークションの集合となり、  
逆に$K$番目のグループは1st priceが最も高いオークションの集合となる。  

ここで$k$番目のグループを取り出し、行列$C_{k} \in \mathcal{R}^{U \times P}$を考える。  
この行列の各要素には、あるユーザ$u$・ある枠$p$で観測したオークションにおいて  
1st priceが観測されていれば1、打ち切られていれば0が入る。  
この行列をmatrix factorizationを使って2つの潜在行列$M \in \mathcal{R}^{U \times L}$と$N \in \mathcal{R}^{P \times L}$に分解し、  
ハザード関数をモデリングする。  
ハザード関数が求まれば累積密度関数も求めることができるため、収益を計算することができる。

## 実験結果

まだ読んでません。。

## コメント

* 線形回帰で直接確率を推定しているようだが、  
  ハザード関数の推定には線形確率モデルを使うものなんだろうか
* オークションが成約しないとbid priceが観測されないという状況がまずよく分からなかった。オークショニアは全買い手のbid priceを観測できるはずなので。ad exchangeは別業者がやっている場合でのSSP目線の話なんだろうか。
