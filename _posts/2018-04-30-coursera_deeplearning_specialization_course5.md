---
layout: post
title: Coursera Deep Learning Specialization course5受講メモ
tags: [Coursera, deep learning, Japanese]
type: article
description: "Coursera Deep Learning Specializationのcourse5受講メモ"
---

<!-- more -->

# Week1

## Recurrent Neural Networks

* Why not a standard network ?
  - training sampleが文章のときなど、異なるサンプルでinputとoutputの長さが異なる
  - ある特徴から学習したことを他の特徴に活かせない
* RNN
  - 前のタイムステップのunitからの出力と現タイムステップのデータを入力として受け付けて  
    次のタイムステップのunitに向けて出力する
  - backpropagation through time
  - 離れたタイムステップに依存関係がある場合、vanishing gradientが問題になる
* いろいろなRNN
  - ここまで例として挙げられていたname entity recognitionは  
    inputとoutputの長さが同じ(many-to-many)だが、  
    他にもone-to-many (ex. music generation)、many-to-one (sentiment classification)などのアーキテクチャが存在する
  - many-to-manyの中にはdecoderとencoderに分かれているものがある
  - attentionベースのアーキテクチャはこの分類に当てはまらない
* language model
  - language modelとは文を入力すると確率を返すようなモデル
  - training時はユニットへの入力はその位置のwordであるのに対し、
    sampling時は前ユニットで予測したwordになる
* GRUとLSTM
  - 遠い位置にある依存関係も学習することができる
  - $\Gamma\_{r}=0$と簡略化しても、$\Gamma\_{u}=0$であれば$c^{i}$と$c^{i-1}$には依存関係ができるので  
    vanishing gradientは起こらない
* Bidirectional RNN
  - 通常のRNNでは前からしか学習できない
  - 前向きと後ろ向きのforwardpropによってシーケンス全体から学習することができる。
* Deep RNN
  - CNNほど深い階層を持ったRNNは見られない
  - 1層のRNNでもtime方向にはつながっているし、計算量も増えるし

# Week2

## Introduction to Word Embeddings

* word embeddings
  - bag-of-wordsのようにone-hot表現で単語を表すのではなく、  
    単語そのものをベクトル化することで単語同士の近さを表現することができる
  - one-hot表現よりも比較的低次元のベクトルで表せる
  - embeddingと呼ばれる所以は、ベクトル空間に単語を埋め込むから
* word embeddingsの利点
  - transfer learningができる、多数のNLPタスクにおいて有利
  - ただし言語モデリングや機械翻訳など、それ用の大規模なデータがある場合は別
  - CNNでも画像のencodingを獲得でき、任意の画像を入力することができるが、  
    word embeddingでは固定サイズの語彙しか対応できない

## Learning Word Embeddings: Word2Vec & GloVe

* Word2Vec
  - embedding matrixを学習する
  - inputは単語のone-hot表現
  - softmaxが重たいのでnegative samplingを使う
* GloVe
  - 単語cのコンテキストに単語tが出てきた回数が要素に格納された行列をモデリングする
      + コンテキストが単語cの前後の場合$X$は対称行列になる
  - $f(X\_{ij})$は頻繁に出てくる単語には小さな重みを与え、レアな単語には大きな重みを与える？
* これらの手法で得られるembendding matrixにおいて、次元の意味するものは必ずしも解釈可能ではない
  - GloVe word vectorsの後半でその理由が述べられているが、よく理解できていない

## Applicatons using Word Embeddings

* sentiment classification
  - ラベル付きの大規模な訓練データが無いことが多い
  - シンプルな解法としては、レビューに出てくる単語のベクトルの平均を取る
  - ただしこの方法では"Completely lacking in good taste and good service"のようなレビューの場合、  
    goodが複数回出てくるので好意的なレビューと判断してしまう
  - そこで単語ベクトルを入力とするRNNを使って前後の文脈を学習に使用する
* debiasing word embeddings
  - computer programmerは男性っぽい、homemakerは女性っぽいのように単語ベクトルにバイアスが含まれてしまうことがある
  - バイアスが定義に含まれていない単語（grandmotherは女性という定義である）についてバイアスを取り除く
  - バイアスを取り除いた後、girl,boyといったペアについてそれらの単語への距離を等しくする

# Week3

## Various sequence to sequence architectures

* Seq2Seq
  - フランス語の文章を入力した後(encoder)、英語の文章を出力する(decoder)
  - 最も確率の高い単語をgreedy searchで1つずつ出力するlanguage modelと違い、  
    seq2seqではbeam search最も確率の高い文章を出力する
* beam searchでは次の単語を探索する系列の候補をbeam width分だけに限定する
  - vocab sizeが10,000でbeam widthが3のとき、確率の高いトップ3の系列を保持しておき、  
    その3つについて次の単語を探索するので、1ステップあたり3x10,000で済む
  - length normalizationをおこなう
  - ground-truthな文章と実際にNNが出力した文章の生成確率を比較し、  
    前者のほうが大きい場合beam searchに、後者のほうが大きい場合NNに問題があるとして  
    error analysisをおこなう
* Bleu Score
  - 出力文のn-gramフレーズがreference(正解例)に数が多いほどスコアが上がる
  - referenceよりも短い出力文の場合ペナルティが与えられる
* Attention Model
  - Seq2Seqではinputが長いと全部encodeし終わってからでないと出力できないが、  
    attentionモデルでは

## Speech Recognition

* Speech recognition
  - audio clipを入力してtranscriptを出力する
* CTC cost
  - inputの特徴の長さほどoutputが長くないとき、  
    characterを連続して出力し、文字の区切りにblankを出力し、単語の区切りにspaceを出力する
