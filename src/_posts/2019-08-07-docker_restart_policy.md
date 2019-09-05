---
layout: post
title: Dockerのrestart policyごとの違いを表でまとめてみる
tags: [Docker]
type: article
description: "Dockerのrestart policyごとの違いを表でまとめてみる。"
---

Dockerのrestart policyごとの違いが説明文だけだといまいちピンと来なかったので、実際に試した結果を表にまとめる。

<!-- more -->

{% linkpreview https://docs.docker.com/config/containers/start-containers-automatically/ %}

o=再起動する・x=再起動しないとして表にまとめると、

||no|on-failure|always|unless-stopped|
|:-:|:-:|:-:|:-:|:-:|
|コンテナが終了ステータス0で終了した場合|x|x|o|o|
|コンテナが終了ステータス0以外で終了した場合|x|o|o|o|
|コンテナのステータスがExitedの状態で<br>Docker daemonを再起動した場合|x|`Exited (0)`のときはx<br>それ以外のときはo|o|x|
|コンテナのステータスがExited以外の状態で<br>Docker daemonを再起動した場合|x|o|o|o|

となる。

`on-failure`と`always`の違いは終了ステータスが0のときも再起動するか否かで、終了ステータスが0のときは前者は再起動せず、後者は再起動する。

`always`と`unless-stopped`の違いはコンテナを`docker stop`で手動で止めた場合にDocker daemonを再起動した場合で、前者は再起動するが後者は再起動しない。

`on-failure`に設定したコンテナのstatusがExitedの状態でDocker daemonを再起動した場合、
終了ステータスが0のコンテナは再起動しないが、0以外のコンテナは再起動する。

---

`on-failure`に設定したコンテナのstatusがExitedの状態でDocker daemonを再起動した場合の確認手順を備忘録がてら載せておく。

1. `exit 0`するため再起動するコンテナ
2. `exit 1`で再起動中に`docker stop`で止めたコンテナ

の2つのコンテナを用意して試してみる。

```console
$ docker run -d --restart on-failure --name exited_with_0 centos:centos7 /bin/bash -c 'sleep 3; exit 0'
$ docker run -d --restart on-failure --name exited_manually centos:centos7 /bin/bash -c 'sleep 3; exit 1'
```

`exited_manually`コンテナはstopしておく。

```console
$ docker stop exited_manually
```

```console
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                      PORTS               NAMES
3d46d036d7aa        centos:centos7      "/bin/bash -c 'sleep…"   17 seconds ago      Exited (1) 3 seconds ago                        exited_manually
20f039939274        centos:centos7      "/bin/bash -c 'sleep…"   30 seconds ago      Exited (0) 25 seconds ago                       exited_with_0
```

`exited_manually`コンテナはステータスが`Exited (1)`、`exited_with_0`コンテナはステータスが`Exited (0)`になっている。

ここでDocker daemonを再起動した後に再度`docker ps -a`してみると、

```console
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                     PORTS               NAMES
3d46d036d7aa        centos:centos7      "/bin/bash -c 'sleep…"   5 minutes ago       Up 2 seconds                                   exited_manually
20f039939274        centos:centos7      "/bin/bash -c 'sleep…"   5 minutes ago       Exited (0) 5 minutes ago                       exited_with_0
```

`exited_manually`コンテナは再起動しているが、`exited_with_0`コンテナはCREATEDが5 minutes agoでSTATUSも5 minutes agoなので再起動していないことがわかる。
