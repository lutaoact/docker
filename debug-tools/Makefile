.PHONY: all

all:
	docker build -t reg.qiniu.com/lutaoact/debug-tools -f debug-tools.dockerfile .
	docker push reg.qiniu.com/lutaoact/debug-tools

run:
	test $(c)
	docker run -it --rm --pid=container:$(c) --net=container:$(c) --cap-add all reg.qiniu.com/lutaoact/debug-tools bash
