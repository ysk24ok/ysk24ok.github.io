ysk24ok.github.io
===

This blog is served at https://ysk24ok.github.io/ by [Github Pages](https://pages.github.com).

## Building Docker image

```console
$ make build
```

This command builds `ysk24ok/ysk24ok.github.io:YYYYMMDD` and `ysk24ok/ysk24ok.github.io:latest` images.

## Creating a new post

```console
$ make new TITLE=new_post_about_something
```

This command creates `_posts/YYYY-MM-DD-new_post_about_something.md`.

## Serving locally

```console
$ make serve
```
