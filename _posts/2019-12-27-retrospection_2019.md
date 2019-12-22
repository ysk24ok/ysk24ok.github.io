---
layout: post
title: 2019年の振り返り
tags: [retrospection, Japanese]
type: article
description: "2019年の振り返り"
---

2019年を振り返ります。
書かないと何年か経ってこの年は何をやってたっけ？となりそうなので。。

<!-- more -->

# 仕事

2019年になってすぐ音声認識のチームに異動になりました。
開発リーダーとしてアサインされて、

* 開発メンバーにタスクの見積もりを出すようにお願いしたり
* 見積もりをもとにスケジュールを経営陣へ報告をしたり
* PoC作業をしたり

といったことをしていました。
アサインされてしばらくはコードは書いていませんでした（依存ライブラリをパッケージ化したりDockerfileを書いたりなどの足回りを整える作業はやってましたが）。

スクラムをやろうと提案したことでゴールデンウィーク明けからスクラムを始めることになり、僕はスクラムマスターと開発者を兼務することになりました。そこから徐々にコードも書き始め、チームも軌道に乗り始めて現在に至ります。

10月には研修を受けて認定スクラムマスターになりました。

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
        <a href="https://ysk24ok.github.io/2019/10/18/become_a_certified_scrummaster.html" target="_blank">
          <img src="https://ysk24ok.github.io/assets/images/profile.jpeg" />
        </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://ysk24ok.github.io/2019/10/18/become_a_certified_scrummaster.html" target="_blank">認定スクラムマスターになりました</a>
        </h2>
        <div class="jekyll-linkpreview-description">認定スクラムマスターになったので、認定スクラムマスター研修で学んだことをまとめてみます。</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//ysk24ok.github.io" target="_blank">ysk24ok.github.io</a>
    </div>
  </div>
</div>

スクラムは間に余計な人をいれずステークホルダーとチームが直接コミュニケーションするのが良いなと思っていたところ、
先日LINE横道さんのLINE DEVELOPER DAY 2019での発表がログミーで文字起こしされているのを読んで、
似た内容が書かれていたので紹介します。

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
        <a href="https://logmi.jp/tech/articles/322286" target="_blank">
          <img src="https://img.logmi.jp/article_covers/YHBdstQ7Qsu6w8mKKncGdw.jpg" />
        </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://logmi.jp/tech/articles/322286" target="_blank">LINEを支えるプロジェクトマネジメント＆アジャイルの専門家組織「Effective Team and Delivery室」の取り組みと戦略</a>
        </h2>
        <div class="jekyll-linkpreview-description">2019年11月20、21日の2日間、LINE株式会社が主催するエンジニア向け技術カンファレンス「LINE DEVELOPER DAY 2019」が開催されました。1日目は「Engineering」をテーマに、LINEの技術の深堀りを、2日目は「Production」をテーマに、Web開発技術やUI/UX、プロジェクトマネジメントなど、より実践的な内容についてたくさんのプレゼンテーションが行われました。「Project Management &amp; Agile全社横断組織の戦略と事例」に登壇したのはLINE Effective Team and Delivery室 室長の横道稔氏。LINEの全社横断組織「Effective Team and Delivery室」のミッションと、実際の取組みについて紹介しました。前半パートとなる今回は、チームの役割と、どのようなスタンスでプロジェクトにおける問題解決をサポートしているのかについて語りました。<a href="https://speakerdeck.com/line_devday2019/project-management-and-agile-strategies-and-examples-of-enterprise-wide-organization" target="_blank">講演資料はこちら</a></div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//logmi.jp" target="_blank">logmi.jp</a>
    </div>
  </div>
</div>

> まず1つ目に、すごく極端に言うと、私たちはプロジェクトマネージャーはいらないんじゃないかと考えています。ただ一方で、プロダクトをしっかりデリバリーするためには「プロジェクトマネジメント」という行為自体は非常に大事だと考えています。

> とくに、自己組織化といいますが、自律的に動くチームであれば、プロジェクトマネジメントの要素はよりチームの中に溶けているような状態になります。

僕も開発リーダーとしてアサインされたのでこの発表で言うところのプロジェクトマネージャーに近い役割でしたが、自分もこの意見に完全に同意で、進捗管理などのプロジェクトマネジメントは単一の個人でなくチームでやったほうが効率がよいと思っています。

僕の場合は別の開発プロジェクトにアサインされて進捗管理をやっていたのでそもそも難しいのはそうなんですが、そうでなくてもステークホルダーと開発者の間にプロジェクトマネージャーやリーダーが入ってコミュニケーションすることによってどうしても情報量が落ちますし、「持ち帰って開発者に確認します」などとやっていてはスピードも失われてしまいます。
それよりも、ステークホルダーと開発者が直接会話して進捗を共有したほうが情報量のロスもない上に、持ち帰る必要もないのでその場で判断できます。

もちろん開発規模によってはこれが最適ではない場合もあり得ますが、数人から数十人程度であればプロジェクトマネージャーを排除してチームが管理する方法で十分に機能するのではないでしょうか。

この「中間者を排除して当事者同士でやり取りする」というプラクティスはプロジェクトマネジメントに限らず、組織のいろんなところで適用できそう。
開発リーダーやスクラムマスターという立場を通じて、開発体制や組織構造ついていろいろ考えたり悩んだりしたのはよい経験になったと感じています。

ちなみに先ほどのログミーの後半の記事では、ボトルネックだった中間のマネージャー層を排して自己組織化されたチームに権限を移譲するというLINE NEWSでの取り組みが紹介されているので、よろしければこちらもどうぞ（LINEの回し者か？）。

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
        <a href="https://logmi.jp/tech/articles/322287" target="_blank">
          <img src="https://img.logmi.jp/article_covers/AT5cqJtdA4oERK11rHgYvM.jpg" />
        </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://logmi.jp/tech/articles/322287" target="_blank">マネージャー依存の構造をいかにして解決するか？　LINE NEWSの事例に学ぶ、プロジェクトマネジメントの知見と工夫</a>
        </h2>
        <div class="jekyll-linkpreview-description">2019年11月20、21日の2日間、LINE株式会社が主催するエンジニア向け技術カンファレンス「LINE DEVELOPER DAY 2019」が開催されました。1日目は「Engineering」をテーマに、LINEの技術の深堀りを、2日目は「Production」をテーマに、Web開発技術やUI/UX、プロジェクトマネジメントなど、より実践的な内容についてたくさんのプレゼンテーションが行われました。「Project Management &amp; Agile全社横断組織の戦略と事例」に登壇したのはLINE Effective Team and Delivery室 室長の横道稔氏。LINEの全社横断組織「Effective Team and Delivery室」のミッションと、実際の取組みについて紹介しました。後半パートとなる今回は、LINE NEWSにおけるプロジェクト支援事例と、実際に取り組んだ数々の施策について語りました。<a href="https://speakerdeck.com/line_devday2019/project-management-and-agile-strategies-and-examples-of-enterprise-wide-organization" target="_blank">講演資料はこちら</a></div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//logmi.jp" target="_blank">logmi.jp</a>
    </div>
  </div>
</div>

# jekyll-linkpreview

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
        <a href="https://ysk24ok.github.io/2019/04/09/release_jekyll_linkpreview.html" target="_blank">
          <img src="https://ysk24ok.github.io/assets/images/profile.jpeg" />
        </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://ysk24ok.github.io/2019/04/09/release_jekyll_linkpreview.html" target="_blank">jekyll-linkpreviewというJekyll pluginを書いた（がGitHub Pagesで使えなかったので使うために格闘した話）</a>
        </h2>
        <div class="jekyll-linkpreview-description">jekyll-linkpreviewというJekyll pluginを書いたもののGitHub Pagesで使えなかったので、使えるようにするためにあれこれ格闘した話を書きます。</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//ysk24ok.github.io" target="_blank">ysk24ok.github.io</a>
    </div>
  </div>
</div>

jekyll-linkpreviewというJekyllのプラグインを書きました。
リンクを `linkpreview` タグに渡すと、そのページのOpenGraphProtocolのmetaタグを取ってきてプレビューを表示してくれます。
Rubyをまともに書くのは初めてだったので結構時間を食ってしまいましたが、無事gemとしてリリースできてよかったです。

RubyよりPython派なんですが、Pythonでライブラリをリリースするより先にRubyでリリースすることになるとは夢にも思いませんでした。Pythonでも何か書きたい。

# ESPnetへのcontribute

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
        <a href="https://espnet.connpass.com/event/139753/" target="_blank">
          <img src="https://connpass-tokyo.s3.amazonaws.com/thumbs/cc/71/cc71d404a25da0f068e46fc252b155a1.png" />
        </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://espnet.connpass.com/event/139753/" target="_blank">ESPnet Hackathon 2019 @Tokyo Part 1 (2019/07/29 10:00〜)</a>
        </h2>
        <div class="jekyll-linkpreview-description">ESPnet (End-to-End Speech Processing Toolkit) ハッカソンの開催    * 第一部      * 日時：7/29（月） 10:00〜17:00     * 場所：株式会社レトリバ 東京都新宿区西新宿2-1-1 新宿三井ビル36階     * タイムテーブル ：        * 10:00 開場 / 受付開始       * 10:30 - 12:00 ESPnet 概要説明 (渡部)       * 12:00 - 13:00 お昼休憩       * 13:00 - 14:30 実践ESPnet (ESPnetチーム)       * 14...</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//espnet.connpass.com" target="_blank">espnet.connpass.com</a>
    </div>
  </div>
</div>

7月末に[ESPnet](https://github.com/espnet/espnet)という音声認識フレームワークの開発者が弊社でイベントをやって、その後数日ハッカソンが開催されたので参加しました。
[warp-ctc](https://github.com/espnet/warp-ctc/)というライブラリのパッケージングに取り組むことになり、ハッカソンの数日では終わらず結局1ヶ月ほどかかったものの、ESPnetのリリースノートに名前が載るなどしました。

ESPnet本体の開発にも関わりたい気持ちもありつつ、音声認識の知識が足らずちょっと手を出せていない感じです。

# PyTorchで音声認識を実装する

仕事で音声認識に関わるようになったわけですが、ブラックボックスで中身がよく分かっていないのはちょっとまずいなと思い、PyTorchで音声認識を実装し始めました。

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
        <a href="https://github.com/ysk24ok/speech-recognition" target="_blank">
          <img src="https://avatars2.githubusercontent.com/u/3449164?s=400&amp;v=4" />
        </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://github.com/ysk24ok/speech-recognition" target="_blank">ysk24ok/speech-recognition</a>
        </h2>
        <div class="jekyll-linkpreview-description">Implementation of end-to-end neural automatic speech recognition in PyTorch - ysk24ok/speech-recognition</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//github.com" target="_blank">github.com</a>
    </div>
  </div>
</div>

といっても現時点では音響モデルの部分しか書いていなくて、FSTのデコーディングを絶賛実装中です。早くend-to-endのモデルも実装したい。

# 1日1問感謝のLeetCode

2019年になってふとLeetCodeを再開しようと思ってちまちま解いていたのですが、ちまちますぎて解いた問題数が全く増えなかったことに加え、思い立って参加してみたLeetCode Contestで4問中最初の2問しか解けないことが何回か続いてショックを受けたので、1日1問必ず解くことにしました。

* 初見の問題をAC
* 既に解いた問題を違う解法でAC

のどちらかを1日1回やるというルールを課しています。

<img src="/assets/images/retrospection_2019/leetcode_activity.png" width="80%">

1日1問解き始めた11月後半からの進捗が著しい。。

1日1問という制約は個人的にはけっこう厳しいですが継続していきたいと思います。

# 読んだ本やPodcastなど

開発リーダーとしてアサインされた直後はアジャイルな見積もりと計画作りなどを読み、

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
        <a href="https://book.mynavi.jp/ec/products/detail/id=22141" target="_blank">
          <img src="https://book.mynavi.jp//files/topics/22141_ext_06_0.jpg" />
        </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://book.mynavi.jp/ec/products/detail/id=22141" target="_blank">アジャイルな見積りと計画づくり|マイナビブックス</a>
        </h2>
        <div class="jekyll-linkpreview-description">『アジャイルな見積りと計画づくり|マイナビブックス』</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//book.mynavi.jp" target="_blank">book.mynavi.jp</a>
    </div>
  </div>
</div>

スクラムをやることになった前後ではアジャイルサムライやSCRUM BOOT CAMPなどを読みました。

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
        <a href="https://shop.ohmsha.co.jp/shopdetail/000000001901/" target="_blank">
          <img src="https://shop19-makeshop.akamaized.net/shopimages/ohmsha/000000001901.gif" />
        </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://shop.ohmsha.co.jp/shopdetail/000000001901/" target="_blank">アジャイルサムライ――達人開発者への道-Ohmsha</a>
        </h2>
        <div class="jekyll-linkpreview-description">Jonathan Rasmusson 著／西村直人・角谷信太郎 監訳／近藤修平・角掛拓未 訳</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//shop.ohmsha.co.jp" target="_blank">shop.ohmsha.co.jp</a>
    </div>
  </div>
</div>

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
        <a href="https://www.shoeisha.co.jp/book/detail/9784798129716" target="_blank">
          <img src="https://www.seshop.com/static/images/product/15395/LL.jpg" />
        </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://www.shoeisha.co.jp/book/detail/9784798129716" target="_blank">SCRUM BOOT CAMP THE BOOK | 翔泳社</a>
        </h2>
        <div class="jekyll-linkpreview-description">はじめて「スクラム」をやることになったら読む本
高品質のソフトウェアをすばやく開発できる手法として、世界中で注目されている「スクラム」。実際の開発プロジェクトにどう適用すればよいのかをとにかくわかりやすく解説します。 これからスクラムをはじめたい人はもちろん、スクラムを導入してみたけどなんだか上手くいかないなぁ&hellip;&hellip;と思っている方にぜひ手にとっていただきたい一冊です。

  ・-
    人気の先生たちが書き下ろした理論だけで終わらない&ldquo;実践&rdquo;の手引き
  
  ・-
    実際のプラクティスを架空のプロジェクトをもとに詳細に解説！
  

</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//www.shoeisha.co.jp" target="_blank">www.shoeisha.co.jp</a>
    </div>
  </div>
</div>

スクラム以外の技術書ではClean ArchitectureやEffective Modern C++、レガシーコードからの脱却などを読みました。

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
        <a href="https://asciidwango.jp/post/176293765750/clean-architecture" target="_blank">
          <img src="https://66.media.tumblr.com/avatar_c63524fcb991_128.pnj" />
        </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://asciidwango.jp/post/176293765750/clean-architecture" target="_blank">Clean Architecture - asciidwango</a>
        </h2>
        <div class="jekyll-linkpreview-description">Clean Architecture ソフトウェアアーキテクチャのルールは、1946年にAlan Turingが最初のマシンコードを書いたときから何も変わっていない。1つだけ変わったのは、当時の我々はそのルールを知らなかったが、今は知っているということだ。そのルールこそが、本書に書かれているすべてだ！ Robert C. Martin 著 角 征典、髙木正弘...</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//asciidwango.jp" target="_blank">asciidwango.jp</a>
    </div>
  </div>
</div>

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
        <a href="https://www.oreilly.co.jp/books/9784873117362/" target="_blank">
          <img src="https://www.oreilly.co.jp/books/images/picture_large978-4-87311-736-2.jpeg" />
        </a>
      </div>
      <div class="jekyll-linkpreview-body">
        <h2 class="jekyll-linkpreview-title">
          <a href="https://www.oreilly.co.jp/books/9784873117362/" target="_blank">Effective Modern C++</a>
        </h2>
        <div class="jekyll-linkpreview-description">C++プログラマから絶大な支持を集めるC++界のカリスマ、スコット・メイヤーズが、優れたC++プログラムはどのように書けばよいのかを指南。C++をすみずみまで知り尽くした著者が、効果的かつ堅牢、移植性の高い優れたC++プログラムを書くノウハウを42項目にまとめています。さらに上を目指したい中上級者必携の一冊です。C++11/C++14対応。</div>
      </div>
    </div>
    <div class="jekyll-linkpreview-footer">
      <a href="//www.oreilly.co.jp" target="_blank">www.oreilly.co.jp</a>
    </div>
  </div>
</div>

<div class="jekyll-linkpreview-wrapper">
  <div class="jekyll-linkpreview-wrapper-inner">
    <div class="jekyll-linkpreview-content">
      <div class="jekyll-linkpreview-image">
        <a href="https://www.oreilly.co.jp/books/9784873118864/" target="_blank">
          <img src="https://www.oreilly.co.jp/books/images/picture_large978-4-87311-886-4.jpeg" />
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

技術書以外では[新1分間マネジャー](https://www.diamond.co.jp/book/9784478025253.html)や[ティール組織](http://www.eijipress.co.jp/book/book.php?epcode=2226)を読みました。

あとPodcastも今年から聞き始め（去年も聞いてたような気もする？）、[Software Engineering Radio](https://www.se-radio.net/)や[Fukabori.fm](https://fukabori.fm/)などを聞いています。SE radioは特定のトピックを専門家が基礎から喋ってくれるので、英語ですが比較的聞きやすいと思います。Fukabori.fmはiwashiさんの喋りが早口でテンポがよいので気に入っています。

# まとめ

仕事でもプライベートでもいろいろと新しいことに手を出した1年だったのかなと振り返ってみて思いました。
来年は新しいことを始めるよりも深めていく1年にしたい。
