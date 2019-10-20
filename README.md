ysk24ok.github.io
===

This blog is served at https://ysk24ok.github.io/ by [Github Pages](https://pages.github.com).

## Serving locally

Run `jekyll serve`.

```sh
$ docker run --rm -v ${PWD}:/blog -p 4000:4000 ysk24ok/ysk24ok.github.io \
  bundle exec jekyll serve --host 0.0.0.0
```

## Building

Run `jekyll build`.

```sh
$ docker run --rm -e JEKYLL_ENV=production -v ${PWD}:/blog \
  ysk24ok/ysk24ok.github.io bundle exec jekyll build
```

Copy built files to the root directory before `git commit`.

```sh
$ cp -r _site/* ./
```
