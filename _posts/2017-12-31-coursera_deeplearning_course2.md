---
layout: post
title: CourseraのDeep Learning Specializaton course2受講メモ
tags: [deep learning, coursera, Japanese]
type: article
description: "deeplearning.aiが提供するDeep Learning Specializatonのcourse2受講メモ"
---

[deeplearning.ai](https://www.deeplearning.ai/)が提供する[Deep Learning Specializaton](https://www.coursera.org/specializations/deep-learning)の[course2](https://www.coursera.org/learn/deep-neural-network)を受講したのでメモを残しておく。

<!-- more -->

# week1

## train / dev / test set

* サンプル数が非常に大きい場合、 dev / test setの割合は小さくてよい
  - サンプル数が小さい場合(e.x. 100-10000)、60/20/20くらいが良いとされていた
  - サンプル数が非常に大きい場合(e.x. million)、98/1/1くらいでも良い
* dev setとtest setは同じ分布からのサンプルにする
  - もちろんtraining / dev / test set全てが同じ分布から得られたデータであれば言うことは無いが、deep learningではデータが大量に必要になるためそれが難しいことが多い
  - そのためhyperparameterの最適化をおこなうdev setと評価をおこなうtest setは最低限同じ分布からのものにしましょう、ということだと思われる
  - 例えばユーザがアップロードした、ピントがずれているor対象がちゃんと写っていない画像を分類するapplicationの場合、Webからクローリングしてきた比較的高精度・対象がちゃんと写っている画像でtrainingするとしても、目的はユーザのアップロードした画像の分類なので、同じ分布で統一するとしてもWebからクローリングしてきた画像ではなくユーザのアップロードした画像で統一する

## bias-variance

* モデルがhigh biasの場合
  - = training setに対してすら精度が低い状態
  - 層数orユニット数を増やす等、ネットワークを大きくする
  - early stoppingはせず、trainingを長くする
* モデルがhigh varianceの場合
  - = training setに対しては精度が高いが、test setについては精度が低い状態
  - データを増やす
  - regularizationを加える
* deep learningではbiasとvarianceは必ずしもtradeoffではない
  - 古典的な機械学習ではbiasとvarianceはtradeoffの関係にあった
  - しかしdeep learningでは必ずしもそうではなく、片方を悪化させることなくもう片方を改善することができる

## regularization

* weight decay
  - いわゆるL2正則化
* (inverted) dropout
  - forward prop時にいくつかのユニットを計算から除外する
  - activationの計算時に残したユニット数の割合で割る
      + e.x. 80%のユニットを残した（=20%のユニットを除外した）場合、0.8で割る
* data augmentation
  - 画像であれば反転する、回転させる、歪ませるなどしてデータを増やす
* early stopping
  - 学習が進むにつれoverfittingの状態になるので、途中で学習を打ち切る
  - 長所: L2正則化のように異なる値で何度も学習をおこなう必要がない、1度だけでよい
  - 短所: underfitしないようにするフェーズとoverfitしないようにするフェーズが混ざってしまう

# week2

## optimizer

* Momentum SGD
  - SGDの更新式に慣性項を加えることで、oscillationを防ぐことができる
  - $\beta$が大きくなるほどより過去の勾配の影響を受けることになる
  - $\beta$は0.9が良いとされている
* RMSprop,Adam
  - Momentum SGDの進化系（雑
* learning rate decay
  - 学習が進むにつれlearning rateを小さくしていく

## local optima vs saddle points

* deep learningでlocal optimaに遭遇することはレア
  - local optimaとは、パラメータの全次元で凹の状態で勾配が0になっている点のことだが、deep learningでは次元数が非常に大きいため全次元で凹になる可能性は低い
  - 勾配が0になるのはsaddle pointsが多いと考えられている、つまりある次元では凹になるが、別の次元では凸になっているケース
* 勾配の緩やかなplateauになっている場合、学習が遅くなる
  - Adamなどのadavancedなoptimizerを使うことで早く抜け出すことができる

# week3

## hyperparameter tuning

* grid searchではなくrandom searchを使う
  - 探索するhyperparameterが2つあり、それぞれのhyperparameterについて5個ずつ合計25個の点をgrid searchで探索する場合、それぞれのhyperparameterについては5つの値しか探索することができない
  - しかしrandom searchの場合、同じ25個の点を探索するにしてもそれぞれのhyperparameterについて25個の値を探索することができる
* coarse to fineで探索範囲を狭めていく
  - 最初はパラメータ全体で探索し、探索範囲を狭め精度が高くなる範囲を重点的に探索するようにする
* 適切なscaleを考える
  - ユニット数や層数は一様乱数でよいが、学習率やmomentumはlog-scaleで探索する

```py
# learning rateの場合
r = np.random.rand()
learning_rate = 10 ** (-5 * r)  # 10^-5 ~ 1
# momentumの場合
r = np.random.rand()
beta = 1 - 10 ** (- r - 1)  # 0.9 ~ 0.99
```

* pandaよりもcavier
  - 1つのモデルのhyperparameterを少しずつ変えながら探索するのがpandaアプローチ
  - 異なるhyperparameterのモデルを並列して複数作成し、最適なhyperparameterを探索するのがcavierアプローチ
  - 計算資源が十分あるのならcavierアプローチのほうが良い

## batch normalization

* batch normalization
   - 入力層においてfeatureをnormalizeするのと同様に、隠れ層においてactivationの計算の前にnormalizeする

# 関連リンク

* [deeplearning.ai](https://www.deeplearning.ai/)
* [Deep Learning \| Coursera](https://www.coursera.org/specializations/deep-learning)
* [Improving Deep Neural Networks: Hyperparameter tuning, Regularization and Optimization \| Coursera](https://www.coursera.org/learn/deep-neural-network)
