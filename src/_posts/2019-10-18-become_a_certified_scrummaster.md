---
layout: post
title: 認定スクラムマスターになりました
tags: [ScrumMaster, CSM]
type: article
description: "認定スクラムマスターになったので、認定スクラムマスター研修で学んだことをまとめてみます。"
---

認定スクラムマスターになったので、認定スクラムマスター研修で学んだことをまとめてみます。

<!-- more -->

{% linkpreview https://www.odd-e.jp/training/course-detail/59 %}

10/2-4に秋葉原でおこなわれたOdd-e Japanの認定スクラムマスター研修に同僚と一緒に参加しました。トレーナーは[Alan Cyment](https://twitter.com/acyment)というアルゼンチンの方で、今回のトレーニングのために30時間かけて（！）来日されたそうです。10/18にオンラインの筆記テストを受けて合格し、無事にScrum Allianceの認定スクラムマスターになりました。

# CSM研修を受けた理由

今年の5月から所属チームでスクラムを始めて、スクラムマスターと開発メンバーの兼任を半年弱ほど続けてきました。ある程度スクラムの経験がたまってきたので、学び直しの意味も込めて申し込もうと思いました。

# 学び

## agileではなくadaptiveという名前になるはずだった

アジャイルという単語のせいで「アジャイル開発=速い」という勘違いをされることが多いですが、得たフィードバックを元に計画を修正するのがアジャイル開発なので、「アジャイル開発=適応」と言ったほうが適切です。

アジャイルマニフェスト作成時、agileではなくadaptiveにするという案がありましたが、アジャイルマニフェスト署名者の1人であるJim HighSmith氏がAdaptive Software Developmentという本を出版しているのでフェアではないという理由でagileになったそうです。

このあたりの話は[Mike Beedle氏のwikipediaの記事](https://en.wikipedia.org/wiki/Mike_Beedle)にも記載があります。

> "I can tell you I came up with that word (Agile) because I was familiar with the book Agile Competitors and Virtual Organisations. We had proposed Adaptive, Essential, Lean and Lightweight. We did not want to use Adaptive because Jim Highsmith had given this to one of his works. Essential sounded overly proud. Lean had already been taken. Nobody wanted to be a lightweight. We did this late in the second day and it took only a few minutes to decide on this.)"

この発言を見るとadaptive以外にessentialやleanなども候補に上がっていたようですね。いずれにせよ、「アジャイル開発=速い」というのは間違いと言って良さそうです。

## illusion of control

[wikipedia](https://en.wikipedia.org/wiki/Illusion_of_control)によると、

> The illusion of control is the tendency for people to overestimate their ability to control events; for example, it occurs when someone feels a sense of control over outcomes that they demonstrably do not influence.

と説明されています。

プロダクト開発において、初期に立てた計画通りに進めることはillusion of controlを生む原因になります。計画通りに進めても顧客への価値提供はコントロールできないためです。  
そこでアジャイルでは、顧客から得たフィードバックをもとに計画を適宜修正していくことでillusion of controlを防ぎます。

## mechanicalなプロダクト開発とorganicなプロダクト開発

これはトレーニング中に多用されていた対比で、例えば木を作るときに、

- 葉・幹・根を別々に作って最後にくっつけるやり方がmechanical
- 種から育てていくのがorganic

恐らくウォーターフォールとアジャイルの比喩になっているのだと思います。mechanicalな開発ではpredictabilityとefficiencyは向上しますが、organicな開発ではlearningとadaptabilityが向上します。どちらかが良いという話ではなく、解決しようとしている問題に応じて適切に選択する必要があります。

## varnishedなスクラムになっていないか？

これもトレーニング中に多用されていた表現で、mechanicalなプロダクト開発が適した領域でスクラムをしている、組織の構造を変えずにスクラムをしているなど、スクラムのメッキがついている(varnished)だけで、メッキを剥がすとこれまでと同じ、といったことになっていないか注意しないといけません。

## outputではなくoutcomeを重視する

開発した機能の数ではなく、開発した機能が顧客にもたらした価値を重視しなくてはいけません。プロダクトオーナーの仕事はoutputを最小化し、outcomeを最大化することです。

## ベロシティを重視しすぎない

アジャイル開発は顧客のフィードバックを受けて計画を修正するので、そもそも見通しは立てづらいです。ベロシティをあまりにも重視しすぎているのであれば、間違った領域にスクラムを適用しているのではないかと疑うべきです。

## スクラムマスターはハチである

これには2つ意味があります。  
まず1つはスクラムマスターは壁にとまったハチのような存在感であれ、ということ。スクラムマスターはメンバーの前に出てチームの世話をしたり指示出しをしたりせず、一歩引いてコーチングやファシリテーションに注力します。  
もう1つは、スクラムマスターは組織を変革するために組織の意思決定者をチクチク刺す存在であれ、ということ。スクラムマスターはスクラムがうまく進むために組織を変革する役割を負っているので、組織に対して働きかける必要があります。

## 最初からスケールさせない

LeSSのような大規模スクラムでは、最初からスクラムをスケールさせようとせず、まず1チームで始めて、必要に迫られて初めてチームを増やします。

# 感想

3日間の研修のうち初日をまるまるアジャイルの原理原則の説明にあてていたのですが、これが特に有意義だったと感じます。  
アジャイルの原理を理解していないために間違ったスクラムになっている現場が非常に多いとトレーナーの方もおっしゃっており、僕も自チームのスクラムを振り返ってみるとスクラムのメッキがついているだけなのでは。。と気づきました。

また、スクラムマスターは組織変革のエージェントであるという言葉を強調されていて、耳が痛かったです。チームがスクラムを進めていけるように支援するだけでなく、組織に対しても働きかけるのがスクラムマスターであると聞いて、スクラムマスターの役割について理解が浅かったなと思いました。

認定スクラムマスターはスクラムあるいはアジャイルを「知っている」ことを示すだけなので、新たなスタート地点だと思ってこれからも精進していきたいと思います。
スクラム経験者でCSM研修をまだ受けたことが無い方は是非受けてみることをオススメします。新たな気付きや学びが得られると思います。
