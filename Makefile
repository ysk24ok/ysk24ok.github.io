.PHONY: deps
deps:
	bundle config set --local path vendor/bundle
	bundle install

.PHONY: build
build:
	bundle exec jekyll build $(OPTIONS)

.PHONY: new
new:
	@bin/new $(TITLE)

.PHONY: serve
serve:
	bundle exec jekyll serve $(OPTIONS)
