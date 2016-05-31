---
layout: slide
title: 個人的gitベストプラクティス
---

### 個人的gitベストプラクティス


---
### 概要
- - -

* コミット履歴を綺麗に保ち  
  他人がレビューしやすくするための個人的tips

* branch運用についての話ではありません

---
### 用語の統一
- - -

* privateブランチ
  - 個々人が作業するブランチ
* publicブランチ
  - privateブランチでの変更を取り込む先のブランチ
  - masterやreleaseブランチなど  
    複数人が作業する可能性のあるブランチを指す

---
### 1. commitメッセージ
- - -

* [How to Write a Git Commit Message](http://chris.beams.io/posts/git-commit/)
  - 日本語訳は[こちら](http://rochefort.hatenablog.com/entry/2015/09/05/090000)

* 提案
  - commitメッセージは日本語でも英語でもよいが  
    なるべく英語で書く
  - 英語で書く場合は  
    先頭は大文字、命令形、ピリオド不要
  - どちらの言語で書く場合も長すぎない長さで

---
### 2. commitの単位(1)
- - -

* どこまでを一区切りとしてcommitするか？

* 提案
  - 1commitに1開発単位を対応させる
  - 例
    + 管理画面にフラグ追加
    + フラグを更新するバッチ追加
    + cronに追加
  - 単位の粒度は個々人の裁量
  - 他人が見ても分かりやすい単位で

---
### 2. commitの単位(2)
- - -

* Fix bug、Fix typo、bugfixedなどの  
  無駄commitを作らないために

* 提案
  - privateブランチでの作業時は  
    commit --amendやrebase -iでcommitをまとめる
    + 他者テストにより指摘された修正は  
      commitを分ける
  - publicブランチでは1commit作る
    + publicブランチでの履歴改変はNGなので
    + commitメッセージに  
      何のバグを直したのかちゃんと書く

---
### 3. publicブランチの変更を取り込む(1)
- - -

* publicブランチの変更を  
  privateブランチに取り込む場合
  - publicブランチのcommitが履歴の先頭に来て  
    privateブランチのcommitが後ろになってしまう

* 提案
  - publicブランチの変更を  
    privateブランチに取り込む場合は  
    mergeではなくrebaseを使う

---
### 3. publicブランチの変更を取り込む(2)
- - -

* rebaseは過去のコミットを書き換えて  
  新しいコミットを作る
  - すでにpushしていると弾かれる

* 提案
  - privateブランチの場合は注意深くpush -fする
  - publicブランチではrebaseしない

---
### 4. publicブランチに変更を取り込む
- - -

* rebaseを使うと履歴が1本化されてしまう
  - 履歴は確かに綺麗になるが  
    別branchからmergeされた変更だと示すことも重要

* 提案
  - publicブランチに変更を取り込む場合は  
    rebaseではなくmergeを使う
  - fast forwardマージにしたくない場合は  
    merge --no-ffを使う？

---
### 5. publicブランチに変更を取り込む
- - -

* Merge branch of 'master' ...コミットが発生する
  - ローカルのpublicブランチを最新にせずに  
    privateブランチをmerge
  - push時に弾かれるのでpullしてからpush

* 提案
  - ローカルのpublicブランチは最新にしてから  
    privateブランチの変更をmergeする
  - もし先にmergeしてしまった場合
    + fetch -> reset --hard origin/masterで戻す
    + pullではなくpull --rebaseする

---
### 個人的な考え
- - -

* privateブランチに対しては  
  極端な話何をしてもよい
  - rebaseで履歴を書き換えてもpush -fしても
  - 他者テストやpull requestのことも考えて  
    他人が見たときの分かりやすさを優先
* publicブランチに対しては  
  何の変更が加わったのかを分かりやすくする
  - privateブランチをrebaseではなくmerge
  - 当然履歴は書き換えない
  - Fix typoなどの小さいcommitでも  
    ちゃんと1commit作るべき

---
### 参考文献・URL
- - -

* [How to Write a Git Commit Message](http://chris.beams.io/posts/git-commit/)
  - [Gitコミットメッセージの7大原則](http://rochefort.hatenablog.com/entry/2015/09/05/090000) (日本語訳)
* [綺麗で使いやすいcommit履歴にするために](http://developer-blog.finc.co.jp/post/133039251857/%E7%B6%BA%E9%BA%97%E3%81%A7%E4%BD%BF%E3%81%84%E3%82%84%E3%81%99%E3%81%84commit%E5%B1%A5%E6%AD%B4%E3%81%AB%E3%81%99%E3%82%8B%E3%81%9F%E3%82%81%E3%81%AB)
* [gitコミットの歴史を改変する](http://tkengo.github.io/blog/2013/05/16/git-rebase-reference/)
