---
layout: post
title: 2021年の振り返り
tags: [retrospection, Japanese]
type: article
description: 2021年を振り返ります。
---

2021年を振り返ります。

<!-- more -->

# 仕事

転職が今年一番のビッグイベントでした。

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
      <a href="https://ysk24ok.github.io/2021/08/17/quit_and_join_in_2021.html" target="_blank">
          <img src="https://ysk24ok.github.io/assets/images/profile.jpeg" />
      </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://ysk24ok.github.io/2021/08/17/quit_and_join_in_2021.html" target="_blank">株式会社レトリバを退職し、株式会社メルペイに入社しました</a>
        </h2>
        <div class="jekyll-linkpreview-description">入社から3ヶ月経ち試用期間を（恐らく）終えたので、退職エントリと入社エントリを書きます。</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//ysk24ok.github.io" target="_blank">ysk24ok.github.io</a>
    </div>
  </div>
</div>

メルペイのML Platformチームに所属し、社内に2チームある機械学習チームのシステム開発などのサポートが主な業務でした。来年からは異動して別のチームに所属するので、それについては別のエントリーに譲りたいと思います。

会社のエンジニアリングブログに投稿もしました。

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
      <a href="https://engineering.mercari.com/blog/entry/20211130-52e6d96087/" target="_blank">
          <img src="https://storage.googleapis.com/prd-engineering-asset/2021/11/f0bda8d9-screen-shot-2021-11-30-at-10.54.51.png" />
      </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://engineering.mercari.com/blog/entry/20211130-52e6d96087/" target="_blank">モブプログラミングを導入し、チーム一丸となってタスクに取り組むようになった話</a>
        </h2>
        <div class="jekyll-linkpreview-description">はじめにメルペイ ML Platformチームの@ysk24okです。この記事は、 Merpay Advent Calendar の4日目の記事です。本記事では自チームにモブプログラミングを導入し、チーム一丸となってタスクに取り組むようにな</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//engineering.mercari.com" target="_blank">engineering.mercari.com</a>
    </div>
  </div>
</div>

# OSS活動

前職の仕事の一環ですが、pficommonのRPCサーバーにtwo-phase terminationを導入したりCircleCIをGitHub Actionsでリプレースしたり

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
      <a href="https://github.com/retrieva/pficommon/pull/226" target="_blank">
          <img src="https://opengraph.githubassets.com/525bcf082bf88d0bc8e773c048ffd0deed98be02c8e4bc5e778ff62839365fcb/retrieva/pficommon/pull/226" />
      </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://github.com/retrieva/pficommon/pull/226" target="_blank">Apply two-phase termination to rpc_server by ysk24ok · Pull Request #226 · retrieva/pficommon</a>
        </h2>
        <div class="jekyll-linkpreview-description">Applied two-phase termination to pfi::network::rpc::rpc_server by adding start() stop() wait_until_stopped() methods().
The approach is to create an internal client which sends an exit message to t...</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//github.com" target="_blank">github.com</a>
    </div>
  </div>
</div>

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
      <a href="https://github.com/retrieva/pficommon/pull/227" target="_blank">
          <img src="https://opengraph.githubassets.com/a1ba71d6021689a35e651c641a2b18f455232c5ac8ea84607f180e34228f4875/retrieva/pficommon/pull/227" />
      </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://github.com/retrieva/pficommon/pull/227" target="_blank">Use GitHub Actions instead of CircleCI by ysk24ok · Pull Request #227 · retrieva/pficommon</a>
        </h2>
        <div class="jekyll-linkpreview-description">Co-authored-by: Eiichiro Iwata eiichiro.iwata+github@gmail.com
Co-authored-by: takei-yuya yuya.takei@retrieva.jp</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//github.com" target="_blank">github.com</a>
    </div>
  </div>
</div>

warp-ctcのパッケージをホストする場所をPyPIから移動したり、

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
      <a href="https://github.com/espnet/warp-ctc/pull/37" target="_blank">
          <img src="https://opengraph.githubassets.com/c40a6e5d9dac54a61f71139c4c3fedc9355a62484a3569425345153eb50e46eb/espnet/warp-ctc/pull/37" />
      </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://github.com/espnet/warp-ctc/pull/37" target="_blank">Add GitHub Actions by ysk24ok · Pull Request #37 · espnet/warp-ctc</a>
        </h2>
        <div class="jekyll-linkpreview-description">I&#39;ve decided to use GitHub Actions instead of Travis CI because

Travis CI set credit allotment for public repositories
we have to serve our wheels outside of PyPI to deal with #35

When new re...</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//github.com" target="_blank">github.com</a>
    </div>
  </div>
</div>

転職してからはFeastというfeature storeのOSSに触る機会があったので、pip-toolsを使って依存パッケージのバージョンを固定するようにしたり、

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
      <a href="https://github.com/feast-dev/feast/pull/2093" target="_blank">
          <img src="https://opengraph.githubassets.com/34d0864a9e54ed682d3db9dd665b2ab42c6db4b9f4b46a1698425d879c367a67/feast-dev/feast/pull/2093" />
      </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://github.com/feast-dev/feast/pull/2093" target="_blank">Use pip-tools to lock versions of dependent packages by ysk24ok · Pull Request #2093 · feast-dev/feast</a>
        </h2>
        <div class="jekyll-linkpreview-description">What this PR does / why we need it:
This PR introduces pip-tools to lock the version of dependent packages.
Other options are Poetry and Pipenv.
Using Poetry, we have to replace setup.py with pypro...</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//github.com" target="_blank">github.com</a>
    </div>
  </div>
</div>

あとAirflowやKubeflow Pipelinesも仕事で使うようになったのでドキュメントやエラーメッセージを直すなどの簡単なパッチを作ったりしました。

# まとめ

機械学習周りのソフトウェアエンジニアリング屋ということで引き続きやっていきます。

本年もお世話になりました。来年もよろしくお願いします。
