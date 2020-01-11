.PHONY: build

BUILD_TIME=$(shell date +%Y%m%d%H%M%S)
PWD=$(shell pwd)
DOCKER_IMAGE=ubuntu-1804-shc

build:
	docker build -f shc.dockerfile -t $(DOCKER_IMAGE):latest .

push:
	docker tag $(DOCKER_IMAGE):latest stag-reg.llsops.com/algorithm/$(DOCKER_IMAGE):latest
	docker push stag-reg.llsops.com/algorithm/$(DOCKER_IMAGE):latest
	docker tag $(DOCKER_IMAGE):latest stag-reg.llsops.com/algorithm/$(DOCKER_IMAGE):$(BUILD_TIME)
	docker push stag-reg.llsops.com/algorithm/$(DOCKER_IMAGE):$(BUILD_TIME)

run:
	docker run -v /Users/taolu/docker/ubuntu-1804-shc:/my_mount --rm -it $(DOCKER_IMAGE) 2_data_kelly.txt
