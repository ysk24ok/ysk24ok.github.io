ysk24ok.github.io
===

This blog is served at https://ysk24ok.github.io/ by [Github Pages](https://pages.github.com).

## Building Docker image

Run `docker build`.

```console
$ docker build -t ysk24ok/ysk24ok.github.io:YYYYMMDD .
$ docker tag ysk24ok/ysk24ok.github.io:YYYYMMDD ysk24ok/ysk24ok.github.io
```

## Creating a new post

Run `bin/new_post` .

```console
$ bin/new_post new_post_about_something
```

This command creates `_posts/YYYY-MM-DD_new_post_about_something` .

## Serving locally

Run `bin/serve` .

```console
$ bin/serve
```
