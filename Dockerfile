FROM debian
LABEL maintainer="yusuke.nishioka.0713@gmail.com"

ENV DIR /blog
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    zlib1g-dev \
    ruby \
    ruby-dev \
  && apt autoclean \
  && apt autoremove
# Install gems
COPY Gemfile $DIR/
COPY Gemfile.lock $DIR/
RUN gem install bundler \
  && cd $DIR \
  && bundle install
# Prevent Conversion error of Jekyll::Converters::Scss
# See https://github.com/jekyll/jekyll/issues/4268
RUN apt install -y locales
ENV LC_ALL C.UTF-8

WORKDIR $DIR
EXPOSE 4000
