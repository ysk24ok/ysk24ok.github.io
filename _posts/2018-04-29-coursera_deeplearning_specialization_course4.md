---
layout: post
title: Coursera Deep Learning Specialization course4受講メモ
tags: [Coursera, deep learning, Japanese]
type: article
description: "Coursera Deep Learning Specializationのcourse4受講メモ"
---

[Coursera Deep Learning Specializaton](https://www.coursera.org/specializations/deep-learning)の[course4: Convolutional Neural Networks](https://www.coursera.org/learn/convolutional-neural-networks)を修了したのでメモを残しておく。


<!-- more -->

# Week1

## Convolutional Neural Network

* convolutional layer
  + 畳み込みによってedge detectionなどができる
  + padding
    - valid: paddingしない
    - same: inputとoutputのサイズが同じになるようにpaddingする
  + stride: filterの移動幅
  + 入力が縦x横xチャネルの3次元だった場合、filterも3次元に、出力は2次元になる
* pooling layer
  + max pooling, average pooling
  + convolutional layerと異なり、入力が3次元のとき出力も3次元のままになる
* Why convolutions?
  - parameter sharing
    + ある特徴で学習したこと(edge detectionなど)を他の特徴に活かせる
  - sparsity of connections
    + 出力のunitは入力のごく一部のunitとしかつながっておらず、  
      パラメータ数を削減できる

# Week2

## Case studies

* classic networks
  - Lenet-5, AlexNet, VGG-16, etc
* ResNet
  - ある層の出力を、先にある層の(activation関数に通す前の)出力に加える (skip connection)
    + $a^{[l+2]}=g(z^{[l+2]}+a^{[l]})$
  - plainなネットワークでは層数を増やすとtraining errorが悪化するが、  
    residual blockを使うと層数を増やしてもtraining errorは悪化しない
  - residual blockが何も学習しなかった場合は重みは0になり、  
    identity functionに等しくなるので、学習が容易(?)
  - residual blockの入力と出力の次元は同じなのでsame convolutionである
* Inception network (GoogLeNet)
  - 1x1, 3x3, 5x5のfilter、poolingによるconvolution結果をchannel方向にstackさせる
  - 3x3、5x5 filterによるconvolutionは、まず1x1 filterによって次元数を減らしてからおこなう


## Practical advices for using ConvNets

* transfer learning
  - 出力層だけ入れ替える
  - 最初の層の重みは固定し、後ろの層を学習する
  - 単に初期化のためだけに使い、全層で学習をおこなう
* data augmentation
  - mirroring (上下or左右を反転する)
  - random cropping (元画像の一部を切り出す)
  - color shifting (色を変える)
  - 画像をディスクから読み出す->上のような加工を施す->NNに入力する

# Week3

## Detection algorithms

* classificationでは画像の中に含まれるobjectがどのラベルにあたるかを知るだけでよかったが、
  object detectionではそれに加えてlocalizationが必要になる
  - localizationとは、画像のどの位置にobjectがあるかを特定すること
  - 例えばNNの出力層にbounding boxの位置に関するユニットを加える
    + bounding boxの中心の座標、幅、高さなど
* より一般的なケースでは、landmarkの座標をNNに出力させる
  - face recognitionでは、目や口の両端など
* sliding window detection
  - 画像を入力してそこにobjectが写っているか否かを識別するConvNetを作れば、  
    1つの大きな画像から小さな画像を切り出す->forwardprop->windowを移動させて別の小さな画像を切り出す  
    ということを繰り返していく
  - しかしsliding window detectionはforwardpropの回数が増えるため計算量も増える
  - ConvNetの実装を工夫すれば一度のforwardpropで全windowを識別できる
* YOLO
  - 画像を複数のcellに区切る
  - objectが複数のcellにまたがっている場合でも、objectの中心が位置するcellがラベルを1にするcellになる
  - 1つ目のvideoで見たように、classificationとlocalizationを1つのConvNetで学習する
  - Convolutional implementationにより複数のcellの学習を1NNでおこなうことができる
* IoU (Intersection over Union)
  - bouding boxの評価指標
  - 正しいboxと予測したboxがオーバーラップしている割合
* Non-max Suppression
  1. objectが含まれる確率が閾値以下のcellを除外する
  1. 残ったcellの中で最もobjectが含まれる確率の高いcellを出力とする
  1. 上のステップで出力としたセルとのIoUが0.5以上の
  - 2と3のステップを繰り返す？
    + 3のステップ後に残るのは、2で出力としたcellと、そのcellほど確率は高くないがオーバーラップしていないcell？
* anchor boxes
  - ここまでで紹介した方法では1つのセルに複数objectが含まれていても識別できない
  - 歩行者用、車用など、あらかじめanchor boxをクラスごとに用意しておき、  
    IoUの最も高いboxにアサインする
    + つまり複数オブジェクトは属するcellは同じだが、属するboxが異なる  
  - 出力層のユニットもanchor box数分用意する
* R-CNN
  - objectが写っている領域の候補をCNNに入力することで画像をセグメント化することができる？

# Week4

## Face Recognition

* face verification vs. face recognition
  - 前者は、ある人の画像と名前orIDを入力してその画像がその名前の人と一致するかを判定する
    + 1:1
  - 後者は、ある人の画像を入力するとデータベースを検索して一致する人を取り出す
    + 1:K
* One Shot Learning
  - 1人につき1枚の画像しかない状態でtrainingしてもNNはうまく動かない
  - 画像の類似度を計算するような関数を考え、verificationをおこなう
* Siamese Network
  - 画像$x_{i}$を入力してforwardpropさせると出力層で128次元のベクトル$f(x_{i})が得られ、  
    $||f(x_{i})-f(x_{j})||$で類似度を計算できるようにNNを学習する
  - loss関数にはtriplet lossを用いる
  - アンカー画像とポジティブ画像とネガティブ画像を用意する必要があるため、    
    訓練データには同じ人の画像が複数枚存在する必要がある
* Triplet lossを用いる以外には、2枚の画像をベクトル化してelement-wiseに類似度を計算したものを特徴量として
  ロジスティック回帰に入力し、同じ人か否かを二値分類する手法もある

## Neural Style Transfer

* cost functionはcontent cost functionとstyle cost functionの線形結合で表す
  - content cost functionはVGGなどの既存の事前学習済のnetworkを使い、
    浅すぎず深すぎない位置にある層のactivation値が、元画像と生成画像で似ているかどうかで表す
  - style cost functionは、スタイル画像と生成画像の異なるchannel間のactivation値が似ているかどうかで表す
* 


