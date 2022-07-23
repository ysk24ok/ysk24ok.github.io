---
layout: post
title: 「レガシーコードからの脱却」を読んだ
tags: [book review, Japanese]
type: article
description: 「レガシーコードからの脱却」を読んだので感想を書きます。
---

「レガシーコードからの脱却」を読んだので感想を書きます。

<!-- more -->

<div class="jekyll-linkpreview-wrapper">
  <p><a href="https://www.oreilly.co.jp/books/9784873118864/" target="_blank">https://www.oreilly.co.jp/books/9784873118864/</a></p>
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
      <a href="https://www.oreilly.co.jp/books/9784873118864/" target="_blank">
          <img src="https://www.oreilly.co.jp/books/images/picture978-4-87311-886-4.gif" />
      </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://www.oreilly.co.jp/books/9784873118864/" target="_blank">レガシーコードからの脱却</a>
        </h2>
        <div class="jekyll-linkpreview-description">レガシーコードとは、バグを多く含み、壊れやすく拡張が難しいコードを指します。このようなコードの保守と管理には多大な労力がつぎ込まれることになります。しかも一度作ってしまったレガシーコードの質を上げるには、初めから質の高いコードを作るよりも膨大なコストがかかります。
本書では、ソフトウェア開発において、初めからレガシーコードを作りださないためのプラクティスを9つ挙げて解説します。プロダクトオーナーは目的を語り、やり方は開発者に任せること、小さなバッチで開発を進めること、継続的に統合すること、チームメンバーで協力することなど、日々の開発に取り入れる考え方と具体的な実践について各章で分かりやすく解説します。
信頼性や拡張性が高いソフトウェアをリリースしたい開発者、運用管理者、マネージャに必携の一冊です。</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//www.oreilly.co.jp" target="_blank">www.oreilly.co.jp</a>
    </div>
  </div>
</div>

以前に一度読んだことがあるのですが、何も覚えていなかったのであらためて読み直しました。

ソフトウェア業界全体で変更の難しいレガシーなソフトウェアが作られておりそれによって多大な損失を生み出していることに触れ、
この本ではエクストリームプログラミングに基づいた以下の9つのプラクティスを提案しています。

1. やり方より先に目的、理由、誰のためかを伝える
1. 小さなバッチで作る
1. 継続的に統合する
1. 協力しあう
1. 「CLEAN」コードを作る
1. まずテストを書く
1. テストで振る舞いを明示する
1. 設計は最後に行う
1. レガシーコードをリファクタリングする

「はじめに」でも触れられていますが、これらのプラクティスの背後にある原則の説明に重点が置かれており、
具体的にレガシーコードをどう改善するのかについては触れられていません。
その目的であれば[レガシーコード改善ガイド](https://www.shoeisha.co.jp/book/detail/9784798116839)を読むことをオススメします。

チームにこれらのプラクティスを導入したい開発者やマネージャーが、
なぜこれらのプラクティスを導入するのかチームや上層部に説明する際には有用だと思いました。
しかし既にこれらのプラクティスを実践できている人からすると当たり前のように感じてしまい
（恐らく自分が最初に読んだときにあまり記憶に残らなかったのもこれが原因）、
物足りなく感じるのではないかと思います。
