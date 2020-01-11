.PHONY: build

BUILD_TIME=$(shell date +%Y%m%d%H%M%S)
PWD=$(shell pwd)
DOCKER_IMAGE=ubuntu-1804-base-image

build:
	docker build -t $(DOCKER_IMAGE):latest .

push: build
	docker tag $(DOCKER_IMAGE):latest stag-reg.llsops.com/algorithm/$(DOCKER_IMAGE):latest
	docker push stag-reg.llsops.com/algorithm/$(DOCKER_IMAGE):latest
	docker tag $(DOCKER_IMAGE):latest stag-reg.llsops.com/algorithm/$(DOCKER_IMAGE):$(BUILD_TIME)
	docker push stag-reg.llsops.com/algorithm/$(DOCKER_IMAGE):$(BUILD_TIME)
