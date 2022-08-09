---
layout: post
title: 「レガシーソフトウェア改善ガイド」を読んだ
tags: [book review, Japanese]
type: article
description: 「レガシーソフトウェア改善ガイド」を読んだので感想を書きます。
---

「レガシーソフトウェア改善ガイド」を読んだので感想を書きます。

<!-- more -->

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
      <a href="https://www.shoeisha.co.jp/book/detail/9784798145143" target="_blank">
          <img src="https://www.shoeisha.co.jp/static/book/og_image/9784798145143.jpg" />
      </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://www.shoeisha.co.jp/book/detail/9784798145143" target="_blank">レガシーソフトウェア改善ガイド | 翔泳社</a>
        </h2>
        <div class="jekyll-linkpreview-description">単なる延命策ではない、進化させるという発想！

コードがレガシーになるのはなぜでしょう。その要因を特定し、
コードベースの品質を上げるためには、なにをすればいいのでしょう。

本書はこれらの古くて新しい質問に真摯に答えてくれるでしょう。

単純な（でも難解な）クラスやメソッドレベルのリファクタリングから、
モジュールあるいはコンポーネント全体を視野に入れた、広い範囲のリファクタリング。
また、最終手段としてのリライトに関するノウハウ（機能低下の予防方法や回避方法、
各種データのスムーズな移行など）を示します。

また、単に手を動かすだけではなく、いつもソフトウェアをフレッシュにしておくべく、
自動化のための方法論や、そのインフラストラクチャの作り方を詳解します。

「動いているものは触るな」が鉄則のソフトウェアを、それでも要請に応じて
よりレスポンシビリティの高い、そして新機能を盛り込まれた、
メンテナンスしやすいソフトウェアへと進化させるためのノウハウを学んでください。

【目次】
第1部：はじめに
  第1章：レガシープロジェクトの難題を理解する
  第2章：スタート地点を見つける

第2部コードベース改良のためのリファクタリング
  第3章：リファクタリングの準備
  第4章：リファクタリング
  第5章：リアーキテクティング
  第6章：ビッグ・リライト

第3部リファクタリングの先へ― プロジェクトのワークフローと基盤を改善する
  第7章：開発環境を自動化する
  第8章：テスト、ステージング、製品環境の自動化
  第9章：レガシーソフトウェアの開発／ビルド／デプロイを刷新する
  第10章：レガシーコードを書くのはやめよう！</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//www.shoeisha.co.jp" target="_blank">www.shoeisha.co.jp</a>
    </div>
  </div>
</div>

タイトルの通りレガシーソフトウェアとの戦い方について述べた本ですが、
[レガシーコード改善ガイド](https://www.shoeisha.co.jp/book/detail/9784798116839)と違ってコードのリファクタリングに留まらず、
リアーキテクティングや開発・本番環境の作成の自動化、Infrastructure as Codeなど、
ソフトウェア全体を通した取り組みについて書かれているのが特徴です。
実際、ソフトウェアはコードだけで成り立っているわけではないので、より実践的な内容になっているかなと思いました。
テストのないレガシーコードをテスタブルにする手法について知りたい場合はレガシーコード改善ガイドを読んだほうがよいです。
サンプルコードはJavaで登場するツールもJavaのものが多いですが、
Javaに詳しくなくても読み進められると思います。
