---
layout: post
title: 2020年の振り返り
tags: [retrospection, Japanese]
type: article
description: 2020年の振り返り
---

2020年を振り返ります。

<!-- more -->

# 仕事

去年に引き続き音声認識に携わっていました。
6月まではスクラムマスター兼開発者として音声認識の製品開発をしていて、gRPCでサーバーを書いたりRHEL8に対応したりMLバックエンドをChainerからPyTorchに移行したりしました。

ChainerからPyTorchに移行した話は弊社の技術ブログに投稿しました。

<div class="jekyll-linkpreview-wrapper">
  <p><a href="https://tech.retrieva.jp/entry/2020/08/11/123453" target="_blank">https://tech.retrieva.jp/entry/2020/08/11/123453</a></p>
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
<div class="jekyll-linkpreview-image">
  <a href="https://tech.retrieva.jp/entry/2020/08/11/123453" target="_blank">
    <img src="https://cdn.user.blog.st-hatena.com/default_entry_og_image/152952466/159479255596133" />
  </a>
</div>

      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://tech.retrieva.jp/entry/2020/08/11/123453" target="_blank">音声認識エンジンの深層学習フレームワークをChainerからPyTorchに移行しました - Retrieva TECH BLOG</a>
        </h2>
        <div class="jekyll-linkpreview-description">音声認識チームのソフトウェアエンジニアの西岡 @ysk24ok です。 弊社では音声認識エンジンを開発しており、これまでChainerを使って音声認識モデルの訓練・精度評価をおこなってきましたが、Chainer v7を最後に開発がストップすることが発表されたため、今回ChainerからPyTorchへの移行をおこないました。 本記事では、移行にあたってぶつかった問題や工夫した点について紹介します。</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="tech.retrieva.jp" target="_blank">tech.retrieva.jp</a>
    </div>
  </div>
</div>

7月以降は社内の体制変更があり、製品開発は一旦ストップして音声認識モデルの精度向上やモデル作成ワークフローの改善をおこないました。
また、チームリーダーということで小さめのマネジメントをしたりもしました。

会社全体でいうと、新型コロナの影響でフルリモートになり（自分は週1で出社しているが）、自宅にちゃんとした作業環境を作るまでは少し苦労しました。

# OSS活動

## pficommon

半分仕事ですが、pficommonのv4.0をリリースしました。
それまではほぼメンテナンスがされていない状態でしたが、社内のC++製品は程度の差こそあれpficommonに依存しているので、少しずつメンテナンスを進めていく必要があると考えたためです。

<div class="jekyll-linkpreview-wrapper">
  <p><a href="https://github.com/retrieva/pficommon/releases/tag/v4.0.0" target="_blank">https://github.com/retrieva/pficommon/releases/tag/v4.0.0</a></p>
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
<div class="jekyll-linkpreview-image">
  <a href="https://github.com/retrieva/pficommon/releases/tag/v4.0.0" target="_blank">
    <img src="https://avatars2.githubusercontent.com/u/22152462?s=400&amp;v=4" />
  </a>
</div>

      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://github.com/retrieva/pficommon/releases/tag/v4.0.0" target="_blank">Release pficommon 4.0.0 Release Notes · retrieva/pficommon</a>
        </h2>
        <div class="jekyll-linkpreview-description">pficommon 4.0.0 Release Notes
Date: 2020/11/27
Download
Download Link: https://github.com/retrieva/pficommon/releases/download/4.0.0/pficommon-4.0.0.tar.bz2
Overview
pficommon 4.0.0:

supports gcc ...</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="https://github.com" target="_blank">github.com</a>
    </div>
  </div>
</div>

新機能の追加は無く、C++03のサポートをdropしてC++11前提にするための変更が主でした。
また、CIを充実させる・ドキュメントのビルド環境を整えるなど足回りも整備しました。

## jekyll-linkpreview

ありがたいことにいくつかpull requestを頂いたので、それに対応する形でv0.3.0, v0.3.1, v0.3.2, v0.4.0をリリースしました。

<div class="jekyll-linkpreview-wrapper">
  <p><a href="https://github.com/ysk24ok/jekyll-linkpreview/releases/tag/v0.4.0" target="_blank">https://github.com/ysk24ok/jekyll-linkpreview/releases/tag/v0.4.0</a></p>
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
<div class="jekyll-linkpreview-image">
  <a href="https://github.com/ysk24ok/jekyll-linkpreview/releases/tag/v0.4.0" target="_blank">
    <img src="https://avatars2.githubusercontent.com/u/3449164?s=400&amp;v=4" />
  </a>
</div>

      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://github.com/ysk24ok/jekyll-linkpreview/releases/tag/v0.4.0" target="_blank">Release v0.4.0 · ysk24ok/jekyll-linkpreview</a>
        </h2>
        <div class="jekyll-linkpreview-description">New Features

Now this plugin is able to generate a page which does not have Open Graph protocol metadata by #23

Others

Contains refactoring by #25</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="https://github.com" target="_blank">github.com</a>
    </div>
  </div>
</div>

## ESPnet

warp-ctcのwheelがPyTorchのバージョンxCUDAのバージョンごとに別wheelになってしまって管理が煩雑だったので、[PEP440のlocal version identifiers](https://www.python.org/dev/peps/pep-0440/#local-version-identifiers)を使って `warpctc_pytorch` の1wheelにまとめました。

<div class="jekyll-linkpreview-wrapper">
  <p><a href="https://pypi.org/project/warpctc-pytorch/" target="_blank">https://pypi.org/project/warpctc-pytorch/</a></p>
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
<div class="jekyll-linkpreview-image">
  <a href="https://pypi.org/project/warpctc-pytorch/" target="_blank">
    <img src="https://pypi.org/static/images/twitter.90915068.jpg" />
  </a>
</div>

      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://pypi.org/project/warpctc-pytorch/" target="_blank">warpctc-pytorch</a>
        </h2>
        <div class="jekyll-linkpreview-description">Pytorch Bindings for warp-ctc maintained by ESPnet</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="https://pypi.org" target="_blank">pypi.org</a>
    </div>
  </div>
</div>

しかしこれは[別の問題](https://github.com/espnet/warp-ctc/issues/35)を引き起こしているので、早急に直さないといけない。

# その他

## Gaba

今年の1月から通い始めたのでもうすぐ1年になります。
フルリモートになるまでは週2、フルリモートになってからは週1のペースで通っていますが、英語を喋れるようになった実感があるかと言われると正直微妙。
自分の言いたいことを伝えるために、知っている単語+身振り手振りでどうにかする力は上がった気はしますが。

## LeetCode

<img src="/assets/images/retrospection_2020/leetcode_400+.png" width="35%">

コロナ禍の影響でDaily Challengeが始まり、なるべく1日1問を継続したところついに400問に到達しました。
大手テック企業のソフトウェアエンジニア職に合格するためにはLeetCode 400問が最低ラインらしいので、一応受けられる水準には達したのか？400問解いても解けない問題は解けないが...

## Kaggle

[MoAコンペ](https://www.kaggle.com/c/lish-moa)に参加してましたが、ちゃんと時間を割かなかったので惨憺たる結果でした。
時間を割いても大して変わらなかったかもしれん。厳しい。

# まとめ

今年はいろいろ手を出してしまった結果、どれも中途半端になってしまった1年でした。
時間は有限だし何より自分は所詮凡人なので、来年は何か新しいことを始めるのであれば別の何かを捨てることを意識したいと思います。

本年もお世話になりました。来年もよろしくお願いします。
