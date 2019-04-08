---
layout: post
title: jekyll-linkpreviewというJekyll pluginを書いた（がGitHub Pagesで使えなかったので使うために格闘した話）
tags: [Jekyll, gem, GitHub Pages]
type: article
description: "jekyll-linkpreviewというJekyll pluginを書いたもののGitHub Pagesで使えなかったので、使えるようにするためにあれこれ格闘した話を書きます。"
---

jekyll-linkpreviewというJekyll pluginを書いたもののGitHub Pagesで使えなかったので、使えるようにするためにあれこれ格闘した話を書きます。

<!-- more -->

# プラグインを自作しようと思った背景

このブログは[GitHub Pages](https://pages.github.com/)によってホストされている。GitHub Pagesでは[Jekyll](https://jekyllrb.com/)という静的サイトジェネレータが使われていて、YAML front matterのついたmarkdownをリポジトリにpushすると自動でビルドされてGitHub Pagesがサーブしてくれるので非常に便利なのだけれど、不満の1つが貼ったURLのプレビューを表示できないことだった。  
一応[jekyll_preview_tag](https://github.com/aleks/jekyll_preview_tag)というプラグインもあるものの、

- プレビューのデザインがイケてない
- デザインを直そうにも出力されたHTMLそのものがキャッシュされてしまう
- gemになっていない

などの問題があったので結局自分で自作することにした。

書いたプラグインはgemとしてリリースしてます。  
[https://rubygems.org/gems/jekyll-linkpreview](https://rubygems.org/gems/jekyll-linkpreview)

# 使い方とか特徴とか

プレビューを表示させたいURLを `linkpreview`コマンドに渡すと、

{% linkpreview https://github.com/ysk24ok/jekyll-linkpreview %}

のようにプレビューを表示してくれる。

そのページの[Open Graph protocol](http://ogp.me/)をfetchしてきてHTMLを出力するので、OGPタグが設定されていないページだとプレビューは表示されない。例えば阿部寛氏の公式HPだと

{% linkpreview http://abehiroshi.la.coocan.jp/ %}

とだけ表示される。

`jekyll build`のたびにそのページにアクセスしてOGPタグを取ってくると時間がかかるので、OGPタグをキャッシュしておくようにしている。先のプラグインと違って出力されたHTMLではなくOGPタグの値をキャッシュするので、後から出力するHTMLの形式を変えることができる。

# しかしGitHub Pagesで使うことができない

いざGitHub Pages上でも使おうとしてプラグインを追加してpushすると、 `The tag linkpreview is not a recognized Liquid tag.`というエラーがでてビルドできないことが判明。  
GitHubのサポートチームに問い合わせてみると、GitHub Pages上ではJekyllのサーバはsafeモードで起動するため利用可能なプラグインが限定されているらしい（利用可能なプラグインの一覧は[こちら](https://pages.github.com/versions/)で確認できる）。

確かに好き勝手にプラグインをインストールできてしまうとセキュリティ的にもまずいよなあと思いつつ、かといって使えないと作った意味がなくなってしまうのでどうしたらいいかサポートの方に聞いてみると、「ビルドした静的ファイルをリポジトリの `docs`ディレクトリに出力するようにして、そのディレクトリをpushするといいよ」と教えてもらった。

上でGitHub Pagesではgit pushしたソースファイルをJekyllが自動でビルドしてくれると先に書いたが、既にビルド済みの静的ファイルをpushしてそのままサーブしてもらうことも可能である。ただしどちらの場合でも[置き場所が決められていて](https://help.github.com/en/articles/configuring-a-publishing-source-for-github-pages)、

- `gh-pages`ブランチのルートディレクトリ
- `master`ブランチのルートディレクトリ
- `master`ブランチの `docs`ディレクトリ

の3つのいずれかの場所に置かないといけない。もともと `master`のルートディレクトリにソースファイルを置いていてそれがビルドされていたのだが、サポートされていないプラグインを今回新しく入れたためビルドができない。そこでGitHubのサポートの方はローカルでビルドしたファイルを `docs`ディレクトリに出力して、それをGitHub Pagesでサーブさせてはどうかと言ってくれたのだった。このとき、ビルドは必要ないので `.nojekyll`という名前の空ファイルを `docs`ディレクトリに置く必要がある（[こちら](https://github.blog/2009-12-29-bypassing-jekyll-on-github-pages/)を参照）。

しかしサポートの方に教えてもらった方法は問題があって、Org/Userページでは `docs`ディレクトリを使う方法は使えないのだった（Org/Userページが何かについては[こちら](https://help.github.com/en/articles/user-organization-and-project-pages)を参照）。ビルドもできない+ `docs`ディレクトリも使えないのでルートディレクトリにビルド済みの静的ファイルを置くしかない。。

# 結局

あれこれ試した結果、最終的に以下のようにした。

1. もともとルートディレクトリに置いていたソースファイルを `src/`に移動
1. `_site/`以下にビルドされたファイルを出力（ `_config.yml`に `source: src`を追加しておく ）
1. `_site/`以下のファイルをルートディレクトリにコピーしてきてgit pushする

新しくブログ記事を公開するとき、今まではmarkdownファイルをpushするだけでよかったのだが、ローカルであらかじめビルドしてさらにビルドされたファイルをコピーしてくるという手間のかかる感じになってしまった。自作プラグインを使うためにそこまでするかという感じだけど、さすがに自分の作ったものをドッグフーディングできないと直そうという気がなくなってしまうので、意地でも使えるようにした。

サクッとプラグインを書いてサクッとブログに導入するつもりだったのに、Rubyをまともに書くのがほぼ初めてだった+プラグインをブログに導入するのに手こずってしまい、時間をだいぶ溶かしてしまった。。

# 何はともあれ

Jekyllユーザの方には使ってみていただけると嬉しいです。バグ報告や要望などのフィードバックも[こちら](https://github.com/ysk24ok/jekyll-linkpreview/issues)でお待ちしております。
