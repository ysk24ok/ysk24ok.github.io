---
layout: post
title: CourseraのDeep Learning Specializaton course3受講メモ
tags: [deep learning, coursera, Japanese]
type: article
description: "CourseraのDeep Learning Specializatonのcourse3受講メモ"
---

Courseraの[Deep Learning Specializaton](https://www.coursera.org/specializations/deep-learning)の[course3: Structuring Machine Learning Projects](https://www.coursera.org/learn/machine-learning-projects)を修了したのでメモを残しておく。

<!-- more -->

# Week1

## orthogonalization

* MLプロジェクトには以下のようにチューニングの項目がいくつかあるが、  
  それぞれ独立したチューニングとしておこなうことができる
  - training setにfitさせる
    + ネットワークサイズを大きくする、advancedなoptimizerを使う
  - dev setにfitさせる
    + 正則化、training setを大きくする
  - test setにfitさせる
    + dev setを大きくする
  - 実世界でうまく動く
    + dev/test setを現実のデータに近づける、cost functionを変える
* early stoppingを使うと各チューニング項目がorthogonalizeではなくなる

## evaluation metric

* evaluation metricは複数ではなく単一の実数値にする
  - e.x. precisionとrecall両方ではなくF1 scoreを使う
  - e.x. 地域ごとの精度ではなく全地域での平均を使う
* 単一のmetricにするのが難しい場合は、  
  1つをoptimizing metric、残りをsatisficing metricとする
  - accuracyをoptimizing metric、running timeをsatisficing metric

## training / dev / test set

* dev setとtest setは必ず同じ分布から得られたデータにする
  - `Choose a dev set and test set to reflect data you expect to get in the future  
    and consider important to do well on`
  - e.x. dev setはUSから得られたデータ、  
    test setはそれ以外の地域から得られたデータという分割方法ではなく、  
    予測するのは全地域のデータなのでdev/test setともに全地域のデータにする
* size of training sets
  - データ量がそう多くない（e.x. 100or1000or10000）昔は60/20/20程度に分割していた
  - データ量が多い（e.x. 1,000,000）昨今では98/1/1のように  
    training setを多くする
  - 特にdeep learningには大量のtrainingデータが必要になるので
  - deep learningではない古典的なMLアルゴリズムでもこの分割割合は適用されるのだろうか？
* size of test set
  - `Set your test set to be big enough to give high confidence  
    in the overall performance of your system`
  - test setを用意しないということもできるが、おすすめはしない
* dev/test setsやevaluation metricが適切でないと気付いた時点ですぐに変える
  - 新しいmetricを考え、その新しいmetricに対してモデルを最適化する
  - 新しいdev/test setsを作って、その新しいdev/test setsに対して最適化する
  - その新しく定義したmetricやdev/test setsもあまり良くなくて変えたい場合も変えてよい
 - 問題なのはmetricやdev/test setsが定まっていない状態が長く続いてしまうこと

## improving model performance

* human-level errorはBayes optimal errorの代わりになり得る
  - Bayes optimal errorとは、端的に言うとこれ以上下げようがないerror rateのこと
* human-level errorとtraining errorの差をavoidable biasと呼び（ただし一般的な名前ではない）、  
  training errorとdev errorの差がvariance problemを表す
  - avoidable biasがvarianceと比べて大きい場合、
    + より大きなネットワークにする
    + よりadvancedなoptimization algorithmにする
  - varianceがavoidable biasと比べて大きい場合
    + データを増やす
    + regularizationを加える

# Week2

* error analysis
  - モデルの精度を高めていくために次にどの問題に取り組むべきかを調べる
  - 手順
    + 縦軸に誤認識したサンプル、横軸にerror categoryをとった表を作る
    + dev setにおいて誤認識したサンプルを100-500ほど人手で調べ、  
      どのerror categoryに属するかをチェックする
      * e.x. 猫認識アプリケーションにおいて、
        犬を猫と誤認識した、画像がぼやけているなど
    + どのerror categoryが多いかを明らかにすることで行動の指針になる
      * 最も割合の大きいerror categoryに取り組むべきということではない
* ラベル付けが間違っているサンプルが含まれている場合
  - training setにラベル付けが間違っているサンプルが含まれている場合
    + deep learningはtraining setのrandom errorには頑健なので、  
      ラベル付けの間違いに規則性が無い場合は特に問題ない
      * ただし一貫して白い犬を間違って猫とラベル付けしてしまっているような場合、  
        モデルは白い犬を猫と学習してしまう
    + training setについてはラベル付けを直す重要性は低い
      * training setはdev/test setsよりも量が多いので直すのも一苦労
      * 直さないことでdev/test setsと分布が多少異なってしまうが、問題ない
      * week2のquizでは`You should not correct incorrectly labeled data in the training set as well so as to avoid your training set now being even more different from your dev set.`が正解となっており、直すと分布が変わることになっているがむしろ逆なのでは。。？
  - dev/test setsにラベル付けが間違っているサンプルが含まれている場合
    + error analysis時にチェック、dev set error全体に占める割合が大きいときのみラベル付けを直す
    + ラベル付けを直す場合はdev/test sets両方に対しておこなう
      * ともに同じ分布からなるという前提を維持するため
    + 誤認識したサンプルだけでなく正しく認識されたサンプルについてもおこなう
      * ラベル付けの間違ったサンプルをさらに誤認識して結果正しいと判定されただけかもしれず、
        誤認識したサンプルについてのみ直すのはアルゴリズムに有利に働いてしまう
      * ただアルゴリズムの精度が高いほど見つけるのは難しくなる
* Build your first system quickly, then iterate
  - 解決するポイントはまず山ほどあるが、まずdev/test setsとmetricsを決めて、シンプルなシステムを作ることから始める
  - bias/variance analysisやerror analysisをもとに次に何をするかを決める

## data mismatch problem

* training setとdev/test setsの分布が異なる場合
  - 猫認識アプリケーションにおいて、  
    Webからクローリングしてきた猫の画像が200,000枚、  
    ユーザがアップロードした猫の画像が10,000枚のとき、  
    training setは前者200,000+後者5,000の計205,000枚、  
    dev/test setsはともに後者の2,500枚ずつにする
  - このアプリケーションにおいてケアすべきなのは後者の画像のため、  
  - 結果training setとdev/test setsの分布が異なる
* training setとdev/test setの分布が異なる場合、  
  bias/variance analysisのためにtraining-dev setを用意する
  - training-dev setに対してのerrorは低いがdev setに対してのerrorが高くなっている場合、data mismatchが原因であると分かる
* data mismatchの対策
  - まず、training setとdev/test setsの違いを特定する
    - (test setに最適化するのを防ぐため、dev setのみについて確認するのが望ましい)
    - e.x. dev setのほうがノイズが多い等
  - 次に、データを集めてtraining setの分布ををdev/test setsの分布に近づける
    + 人工的にデータを合成してtraining setを増やす
      * e.x. 人の声とノイズを合成する

## Learning from multiple tasks

* transfer learning
  - 先にtask Aでネットワークをpre-trainingしておき、  
    そのネットワークをtask Bのtrainingに流用する
    + e.x. task A = 普通の画像認識タスク、task B = 放射線診断
  - output layerをtask Bのものに入れ替え、task Bのデータで再びtrainingする
  - transfer learningが使える条件
    + task Aとtask Bの入力データの種類が同じであること
      * e.x. ともに画像、ともに音声
    + task Aに用いるデータの方がtask Bのそれよりもずっと多いこと
    + task Aで学習した物体の境界などのlow-level featureがtask Bでも使えること
* multi-task learning
  - 通常1つのネットワークで1つのtaskを担当するところを、
    1つのネットワークで複数taskをおこなう
    + e.x. 画像の中の複数種類の物体を認識する
  - 1つのサンプルが複数ラベルを持つので、output layerにも複数node存在する
  - ラベルに欠損があっても使える
  - multi-task learningが使える条件
    + そのネットワークで学習したlow-level featureをtask間で共有することができる
    + 各taskが持つデータがだいたい同じくらいである
    + 十分に大きいNNを構成することができる
      * Rich Caruana曰く、別々のネットワークでtrainingする場合と比べてmulti-task learningが劣るのはネットワークサイズが小さいとき

## end-to-end deep learning

* データXから目的変数Yを求めるとき、通常複数ステージからなるパイプラインを作る必要がある
  - e.x. 音声データからMFCCでfeatureを生成、featureからMLでphonemeを取り出し、phonemeからwordを認識、、最後にtranscriptを生成する
* end-to-end deep learningでは、これら複数のステージを1つのNNで置き換えることができる
* pros
  - 人間の先入観にもとづいて前処理をするより、データの特徴を捉えることができる可能性がある
  - パイプラインのステージ数を減らすことができる
* cons
  - 大量のデータが必要になる
  - 人間の知識をNNに与えることができない
* 実際には、end-to-endではなく複数のsubproblemに分割するほうがうまくいくことも多いため、  
  どこにend-to-end deep learningを適用するかよく考えるべき
  - e.x. face recoginitionにおいて、画像から直接顔を認識させるのではなく、  
    まず画像から顔をcropしてから認識させるという2つのステージに分けたほうがうまくいく

# 関連リンク

* [Deep Learning \| Coursera](https://www.coursera.org/specializations/deep-learning)
* [Improving Deep Neural Networks: Hyperparameter tuning, Regularization and Optimization \| Coursera](https://www.coursera.org/learn/deep-neural-network)
