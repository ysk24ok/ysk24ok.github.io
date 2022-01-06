---
layout: post
title: 「みずほ銀行システム統合、苦闘の19年史」を読んだ
tags: [book review, Japanese]
type: article
description: 「みずほ銀行システム統合、苦闘の19年史」を読んだので感想を書きます。
---

「みずほ銀行システム統合、苦闘の19年史」を読んだので感想を書きます。

<!-- more -->

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
      <a href="https://www.nikkeibp.co.jp/atclpubmkt/book/20/277410/" target="_blank">
          <img src="https://cdnshop.nikkeibp.co.jp/0000/catalog/277410/277410_thumb_pc.jpg" />
      </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://www.nikkeibp.co.jp/atclpubmkt/book/20/277410/" target="_blank">みずほ銀行システム統合、苦闘の19年史</a>
        </h2>
        <div class="jekyll-linkpreview-description">ついに完成した「IT業界のサグラダファミリア」、その裏側に迫るみずほフィナンシャルグループ（FG）が2011年から進めてきた「勘定系システム」の刷新・統合プロジェクトが2019年7月、ついに完了した。富士通、日立製作所、日本IBM、NT</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//www.nikkeibp.co.jp" target="_blank">www.nikkeibp.co.jp</a>
    </div>
  </div>
</div>

みずほ銀行の新しい勘定系システムMINORIの開発プロジェクトについて、過去に起こした障害も振り返りながら詳述している本です。
著者はみずほ内部の方ではなく日経クロステックや日経コンピュータの方なので暴露本ではありません。
調査報告書などに記載された事実を元に書かれており書き方として非常に淡々としている一方、基本的にMINORIの開発については好意的な立場を取っているような印象を受けました。

なお、2021年にはみずほ銀行は計9回の障害を起こして金融庁から業務改善命令も受けており、システムを刷新した結果状況が好転したわけではなさそうです。

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
      <a href="https://www.fsa.go.jp/news/r3/ginkou/20211126/20211126.html" target="_blank">
          <img src="https://www.fsa.go.jp/images/title_j_t.png " />
      </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://www.fsa.go.jp/news/r3/ginkou/20211126/20211126.html" target="_blank">みずほ銀行及びみずほフィナンシャルグループに対する行政処分について</a>
        </h2>
        <div class="jekyll-linkpreview-description"></div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//www.fsa.go.jp" target="_blank">www.fsa.go.jp</a>
    </div>
  </div>
</div>

とはいえ、[Googleでも数年単位でコードが書き直される](https://www.infoq.com/jp/news/2019/11/google-software-engineering/)という話もありますし、システムを一から作り直すというのは英断だったのではと思います。
SoAを採用したり業務フローを一から見直したり、作り直す際にしかできない抜本的な改善をおこなうことができるので。

細かい点として、第一部がMINORIの開発プロジェクトについてで第二部と第三部が過去の障害についてなのですが、先に障害の話をしてからシステムの刷新に移ったほうが読む順番と時系列が合致するのでよかったのにと思いました。
