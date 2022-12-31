IMAGE := ysk24ok/ysk24ok.github.io
YYYYMMDD := $(shell date "+%Y%m%d")

.PHONY: build
build:
	@rm -f Gemfile.lock
	@docker build --no-cache -t $(IMAGE):$(YYYYMMDD) .
	@docker tag $(IMAGE):$(YYYYMMDD) $(IMAGE)

.PHONY: new
new:
	@bin/new $(TITLE)

.PHONY: serve
serve:
	@docker run \
		--rm \
		-v ${PWD}:/blog \
		-p 4000:4000 \
		$(IMAGE) \
		bundle exec jekyll serve --host 0.0.0.0
