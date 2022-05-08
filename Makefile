REPO=hyp0th3rmi4
IMAGE=checkstyle-markdown
VERSION ?= latest

.PHONY: image
image: 
	docker build -t $(REPO)/$(IMAGE):$(VERSION) .

.PHONY: test
test: image
	docker run -v
