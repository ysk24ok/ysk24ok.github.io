---
layout: slide
title: Hadoop / Spark Conference Japan 2016参加報告
---

### Hadoop / Spark Conference Japan 2016参加報告


---
### 講演・LTのプログラム
- - -

http://hadoop.apache.jp/hcj2016-program/

---
### 基調講演
- - -

* ご挨拶、Hadoopを取り巻く環境2016
* Hadoopの現在と未来
* Yahoo!Japanのデータプラットフォームの  
  全体像と未来

---
### 基調講演
- - -

* <span style="color:red">ご挨拶、Hadoopを取り巻く環境2016</span>
* Hadoopの現在と未来
* Yahoo!Japanのデータプラットフォームの  
  全体像と未来

---
### 今回のhcj
- - -

* Hadoop10周年
* Hadoop Conference Japan 6回目、7年目
* 1347人が参加、そのうち63%が初参加
* Spark Conference初開催

---
### 多様化するHadoop
- - -

* 多数のディストリビューション・周辺ミドルウェア
  - 今はHadoopにとって過渡期

* かつてはLinuxも同じ状況だった
  - 徐々に収束していくはず

---
### 基調講演
- - -

* ご挨拶、Hadoopを取り巻く環境2016
* <span style="color:red">Hadoopの現在と未来</span>
* Yahoo!Japanのデータプラットフォームの  
  全体像と未来

---
### Hadoopの過去
- - -

* Hadoopとは？
  - 複数のサーバを束ねてひとつの処理システムとして透過的に扱うシステム
  - 従来はHDFS+MapReduce
* Hadoopを皮切りに他にも様々な分散処理系が登場
  - e.x. Spark, Hive, Storm ...
* 昔はHadoop≒MapReduce

---
### Hadoopの現在
- - -

* YARN
  - リソース管理のミドルウェア
  - MapReduceもYARN上で動作する一処理系でしかなくなる
  - 得意な処理系が得意なタスクをやる
* 今はHadoop≒YARN

---
### Hadoopの未来
- - -

* 現在の分散処理ミドルウェアは  
  従来のハードウェアを想定
  - CPU, メモリ, HDD

* 新しいハードウェアの登場
  - CPU => GPU, FPGA
    + Google TensorFlow, Microsoft Project Catapult
  - メモリ => NVM
  - HDD => SSD
    + Apache Kudu

* YARNも様々な計算リソースに対応する  
  データセンターOSとして進化を遂げていく

---
### 基調講演
- - -

* ご挨拶、Hadoopを取り巻く環境2016
* Hadoopの現在と未来
* <span style="color:red">Yahoo!Japanのデータプラットフォームの  
  全体像と未来</span>

---
### Yahoo!Japanのデータプラットフォームの全体像と未来
- - -

* 現在の構成
  - Hadoopクラスタ: 6000ノード・120PB
  - Percona, Oracle, Teradata, Cassandra, ...

* これからの構成
  - Presto, Spark, LLAP, ...

* Our Issues = データ需要の指数関数的増大
  - データ量は4倍/年
  - 3000台のHadoopクラスタを8ヶ月で使い切る

* Hortonworksと技術提携し、使う側から作る側へ

---
### 聴講した発表
- - -

* さくらインターネットが構築した、  
  Apache Sparkによる原価計算システムの  
  仕組みとその背景
* SparkによるGISデータを題材とした時系列データ処理
* Hive On Sparkを活用した高速データ分析
* 次世代アーキテクチャから見たHadoop/Sparkの位置づけ

---
### 聴講した発表
- - -

* <span style="color:red">さくらインターネットが構築した、  
  Apache Sparkによる原価計算システムの  
  仕組みとその背景</span>
* SparkによるGISデータを題材とした時系列データ処理
* Hive On Sparkを活用した高速データ分析
* 次世代アーキテクチャから見たHadoop/Sparkの位置づけ


---
### さくらインターネットについて
- - -

* 主なサービスは「ハウジング」と「ホスティング」

* データセンターは東京・大阪・北海道石狩の3ヶ所

* 事業のポイント
  - 垂直統合型経営
    + 土地から建物(データセンター)からサーバまで
  - 持つ経営
  - 規模の追求
    + エネルギー効率、面積効率、回線効率などの追求
    + いわゆる規模の経済

---
### 背景
- - -

* 「持つ経営」の成長=資産が増える
  - 原価計算が重要
  - 投下した資本は回収できているか？
  - サービスの提供にどのくらいのコストがかかるか？

* 以前はExcelで人手で集計
  - 時間がかかる
  - 入力ミスの発生

---
### 目標
- - -

* 原価計算の精緻化と迅速化
* データの整備と社員の意識向上
* 分散処理基盤の知見を積む

---
### やり方
- - -

* ノーチラステクノロジーズと協力
  - Asakusa FrameworkとSpark

* 土地・建物などの資産をノードとしてツリー構造で表す
  - 最終的にバッチができる

---
### 聴講した発表
- - -

* さくらインターネットが構築した、  
  Apache Sparkによる原価計算システムの  
  仕組みとその背景
* <span style="color:red">SparkによるGISデータを題材とした時系列データ処理</span>
* Hive On Sparkを活用した高速データ分析
* 次世代アーキテクチャから見たHadoop/Sparkの位置づけ


---
### IHIにおけるデータ収集・データ解析
- - -

* データ収集
  - 製品のセンサデータ
    + e.x. 圧力・温度・流量, ...
    + メンテナンス・設計へのフィードバック
  - GISデータ
    + e.x. 経度・緯度・速度
    + 新サービス開発

* IHIには独自のメトリクス収集・監視システムが存在
  - 分析にはPythonやRを使用

* 実用的な処理時間・柔軟性などから  
  HadoopやSparkに注目

---
### 目標
- - -

* 港湾の混雑予測にGISデータを活用する

---
### 問題設定
- - -

* GISデータ
  - 動的な情報
    + データ受信時刻、座標、速度
  - 静的な情報
    + 移動体id、目的地、到着予想時刻

* 移動体の座標や速度から  
  ある時点での港湾内の移動体の数を予測

---
### 課題
- - -

* GISデータなどの多変量時系列データは  
  データの並び順が重要

* Sparkのいくつかの処理(shuffleなど)は  
  データの並び順を保証しない

---
### 解決策
- - -

* 移動体ごとの時系列データを  
  レコードとしてひとまとめにする
  - 長所
    + 各移動体のレコードはランダムにならないので  
      時系列データを元の並び順で扱える
  - 短所
    + 移動体ごとのレコードの長さが異なるため  
      スケーラビリティが出づらい？

* 移動体ごとのレコード長比較、  
  レコード長の偏りの有無における  
  スケーラビリティを調査


---
### 聴講した発表
- - -

* さくらインターネットが構築した、  
  Apache Sparkによる原価計算システムの  
  仕組みとその背景
* SparkによるGISデータを題材とした時系列データ処理
* <span style="color:red">Hive On Sparkを活用した高速データ分析</span>
* 次世代アーキテクチャから見たHadoop/Sparkの位置づけ

---
### 課題
- - -

* Hiveが遅い
  - クエリのデバッグ
  - データ量の増加による実行時間の増大

---
### SQL on Hadoop
- - -

* Hive
  - Hive on MapReduce <= 以前はこれ
  - Hive on Spark
  - Hive on Tez

* Spark
  - SparkSQL
  - Dataframe

* Impala
* Apache Drill
* Presto

---
### Hive on Spark導入の理由
- - -

* クエリの書き換え不要

* 学習コストの低さ
  - HiveクエリとSpark運用知識があれば

---
### 聴講した発表
- - -

* さくらインターネットが構築した、  
  Apache Sparkによる原価計算システムの  
  仕組みとその背景
* SparkによるGISデータを題材とした時系列データ処理
* Hive On Sparkを活用した高速データ分析
* <span style="color:red">次世代アーキテクチャから見たHadoop/Sparkの位置づけ</span>

---
### 日本市場にHadoopは合わない
- - -

* Hadoopは100ノード以上の大規模クラスタが対象
  - 障害対策
    + 頻繁な同期
    + チェックポイントの設定
    + 中間データを複製・ディスクに書き込み

* 日本のユーザ層は数ノード〜数十ノードが多数
  - 数ノードで障害は顕在化しない
  - 障害対策のせいでノード数の割には遅い

---
### これからのアーキテクチャ
- - -

* ムーアの法則の終了
  - メニーコア化
  - メモリーバスの強化
  - ストレージIOの低減

* サーバクラスタの凝集化
  - RSA(Intel), TheMachine(HP), Firebox(AMPLab)

* 日本市場にはこちらの方が合う？
  - Asakusa Frameworkの方向性もこちら

---
### 個人的感想
- - -

* さらに進化するHadoop
  - 新しいハードウェアへの対応

* さらに浸透するHadoop
  - Web系企業のみならず  
    某小売り店や某メーカーにおける導入事例など

* その一方Hadoopでカバーできないケースも

* HadoopはLinuxの夢を見るか？

---
### 参考URLなど
- - -

* ご挨拶、Hadoopを取り巻く環境2016
  - 濱野さん (日本Hadoopユーザー会、NTTデータ)
  - [発表資料](http://www.slideshare.net/hadoopconf/hadoop-conference-japan-2016-keynote-hamano)

* Hadoopの現在と未来
  - 鯵坂さん、小沢さん (Hadoopコミッタ)
  - [発表資料](http://www.slideshare.net/hadoopconf/hadoop-conferencejapan2016-keynote-ozawa-ajisaka)

* Yahoo!Japanのデータプラットフォームの  
  全体像と未来
  - 遠藤さん (Yahoo!Japan)
  - [参考記事](http://www.publickey1.jp/blog/16/yahoo_japan_hadoop_spark_conference_japan_2016.html)

---
### 参考URLなど
- - -

* さくらインターネットが構築した、  
  Apache Sparkによる原価計算システムの  
  仕組みとその背景
  - 須藤さん (さくらインターネット)
  - [参考記事](http://www.publickey1.jp/blog/15/post_99.html)
* SparkによるGISデータを題材とした時系列データ処理
  - 鈴木さん (IHI), 土橋さん (NTTデータ)
  - [発表資料](http://www.slideshare.net/hadoopconf/apache-spark-gis-timeseries-data-ihi-nttdata-hadoop-spark-conference-japan-2016)

---
### 参考URLなど
- - -

* Hive On Sparkを活用した高速データ分析
  - 加嵜さん (DMM.comラボ)
  - [発表資料](http://www.slideshare.net/knagato/hive-on-spark-hadoop-spark-conference-japan-2016)
* 次世代アーキテクチャから見たHadoop/Sparkの位置づけ
  - 神林さん (ノーチラステクノロジーズ)
  - [参考記事](http://ascii.jp/elem/000/001/085/1085916/)
