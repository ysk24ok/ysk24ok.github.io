FROM debian
LABEL maintainer="yusuke.nishioka.0713@gmail.com"

ENV SRC_DIR /blog/src
ENV DEST_DIR /blog/dest
COPY Gemfile $DEST_DIR/
COPY Gemfile.lock $DEST_DIR/
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ruby \
    ruby-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && gem install bundler \
  && cd $DEST_DIR && bundle install --path ./vendor/bundle
WORKDIR $DEST_DIR
ENTRYPOINT bundle exec jekyll serve --host 0.0.0.0 -s $SRC_DIR
EXPOSE 4000
