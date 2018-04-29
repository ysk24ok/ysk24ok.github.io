ysk24ok.github.io
===

This blog is generated by [Github Pages](https://pages.github.com) using:

* [jekyll](https://jekyllrb.com/)
* [reveal.js 3.1.0](https://github.com/hakimel/reveal.js/)
* [bootstrap 3.3.5](http://getbootstrap.com/)

## Using docker

Generate docker image.

```sh
$ docker build -t ysk24ok.github.io ./
```

A server will run at http://localhost:4000.

```sh
$ docker run -it -v `pwd`:/blog/src -p 4000:4000 ysk24ok.github.io:latest
```

## Not using docker

Install dependent gems.

```sh
$ sudo apt-get install ruby-dev   # if Debian
$ sudo gem install bundler
$ bundle install --path vendor/bundle
```

A server will run at http://localhost:4000.

```sh
$ bundle exec jekyll serve
```
