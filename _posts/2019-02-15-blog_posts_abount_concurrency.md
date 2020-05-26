﻿---
layout: post
title: NII佐藤先生の並行処理に関するブログ記事をまとめる
tags: [Japanese]
type: article
description: "NII佐藤先生の並行処理に関するブログ記事をまとめる"
---

最近並行処理について調べていた時に見つけたNII佐藤一郎先生のブログ記事をまとめます。
やっていることはkazunori279さんの[こちらの記事](https://kazunori279.hatenablog.com/entry/20100301/1267405275)と同じですが、何年何月何日の内容なのかリンクがある状態でまとめておきたかったので、、

<!-- more -->

[2010年2月26日](http://home.att.ne.jp/sigma/satoh/diary/diary100331.html#20100226)

> 最近、興味深いのはオブジェクト指向言語のScalaやErlangが話題を集めていることでしょうか。どちらもActor Modelをベースにしているそうですが、オブジェクト指向言語の歴史でいうと、Actor Modelなどの並行処理用オブジェクト指向言語の研究が盛んになったのは1985年からの6,7年ぐらいだと思います(Actor Model自身はもっと古いですが)。そして1990年後ぐらいから議論されてきた話題のひとつは、各オブジェクトは高々のひとつの実行スレッドとするシングルスレッド実行モデルと、一つのオブジェクトでも複数同時処理を許すマルチスレッド実行モデルのどちらがいいかというもの。

> さてシングルスレッド実行モデルとマルチスレッド実行モデルは何が違うかというと、前者は各オブジェクトは能動的に処理してもよい、つまり各オブジェクトに高々一つのスレッドを割り当てるが、オブジェクト内部的には逐次プログラムですから、オブジェクト内部で排他実行や同期をしなくてもいいので、オブジェクトのプログラミングは楽になります。一方、マルチスレッド実行モデルでは各オブジェクトは能動的に処理されますし、各オブジェクトにも複数のスレッドが割り当てられます。このため処理効率はあがりますが、オブジェクト内部で排他実行や同期する必要が出てきます。どちらもメリットとデメリットがあるのですが、シングルスレッド実行モデルの代表格というのが前述のActor Modelでした。

[2010年2月27日](http://home.att.ne.jp/sigma/satoh/diary/diary100331.html#20100227)

> 当時の並行オブジェクト指向で議論されていた話題に並行処理の定義方法があります。ちょっと歴史を説明しないといけないのですが、ひとつのプログラム内に並行処理をいれると効率的な処理ができる一方で、前述のように排他制御や同期処理をしないといけないのでプログラミングがたいへんになります。初期のUnixはそれを嫌って、各プロセスに割り当てるスレッドは高々一つと制限しました。そのうえ並行処理を行うときはプロセス自身を複製(fork)するという方法をとって、並行実行単位間の共有変数を排除。この結果としてはUnix向けプログラミングは簡単化させて、Unixの普及の要因の一つになったと思います。ここで興味深いのはUnixの前身のMulticsではプログラムの並行実行、つまりマルチスレッド実行を許していたので、Unixはプログラミングのシンプルさ・容易さのために、あえて低機能化させたといえます。

[2010年2月28日](http://home.att.ne.jp/sigma/satoh/diary/diary100331.html#20100228)

> ちなみに昨日、ErlangにはCSP的なガード記述があると書きましたが、これはErlangの歴史を考えれば当然。詳しくは設計者の一人がErlangの歴史に関する論文を書いているので、そちらをご覧いただければいいのですが、せっかくなので当時の状況などを少々。

> 通信プロトコルの開発では、OSI的な世界では、まず仕様をきっちり決める。きっちり決めると言っても自然言語で仕様を書くと解釈にブレが出るので、数学的に裏付けられた方法で定義をする。そうした定義方法のひとつが形式仕様記述言語。簡単に言えば数学的に定義されている言語を使ってプロトコルを定義するという方法。その形式仕様記述言語にはいろいろあったのですが(過去形)、そのなかにCSPにデータ構造を導入したような形式仕様記述言語Estelleがあって、そのEstelleにより記述したプロトコル仕様を実装するためにEricssonはConcurrent Pascalを作っていた。ErlangはそのEricsson版のConcurrent Pascalの影響を受けたというか、それを拡張して実装したはず。なんでこんな事情を知っているかというとEstelleを含む通信仕様記述言語のISO委員だから(Estelleの拡張版の規格化では多少の貢献があったりします、ちょっと自慢してみたり)。まぁ、当方の話はどうでもいいのですが、ErlangがCSP的な記述ができるのは当然というか、Erlangの前身の言語がCSP的な記述の実装言語ということ。

[2010年11月16日](http://home.att.ne.jp/sigma/satoh/diary/diary101231.html)

> ScalaやErlangのおかげでActorが流行っていますね。正直いって20年間のデジャヴーを見ているよう(といっても正確には20年前は知らないけど)。最近の論調だと、Actorだと並行プログラムが書きやすいということになっていますが、Actorというのは並行オブジェクト(各オブジェクトが能動的に動く)の中でもシングルスレッドオブジェクトと呼ばれるタイプ。つまりオブジェクト内のスレッドが高々一つ。ちなみにオブジェクト内のスレッドが複数あるオブジェクトをマルチスレッドオブジェクトといいます。

> 20年前のシングルスレッドオブジェクト派の研究者とマルチスレッドオブジェクト派の研究者で散々議論がされたのですが、結果としてはマルチスレッドオブジェクトが優勢となりました。その理由のひとつは例外処理のしやすさ。シングルスレッドオブジェクトは綺麗にプログラムが書けるのですが、例外処理もシングルスレッドで処理しようとするとオブジェクト間連携が複雑になるのです。いまはマルチスレッドオブジェクトからシングルスレッドオブジェクトへの揺り戻しが起きていますが、歴史が繰り返すならば再びマルチスレッドオブジェクトにもどる可能性もあります。

togetterで当時の佐藤先生のツイートがまとめられていたのでそちらも貼っておきます。  
[航空機の話題からAda,Java,並列オブジェクトへ - Togetter](https://togetter.com/li/6948)


個人的に興味深かったのが、今起きているのは（2010年頃には既に起きているようですが）マルチスレッド実行モデルからシングルスレッド実行モデルへの揺り戻しだという部分。

`シングルスレッドオブジェクトは綺麗にプログラムが書けるのですが、例外処理もシングルスレッドで処理しようとするとオブジェクト間連携が複雑になるのです。`とありますが、シングレスレッドの並行処理をあまり書いたことがないのでピンと来ていない。。