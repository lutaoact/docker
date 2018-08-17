.PHONY: all

all:
	docker build -t reg.qiniu.com/lutaoact/debug-tools -f debug-tools.dockerfile .
	docker push reg.qiniu.com/lutaoact/debug-tools

run:
	if [ -z "$(c)" ]; then \
		docker run -it --rm -v /tmp:/tmp reg.qiniu.com/lutaoact/debug-tools; \
	else \
		docker run -it --rm -v /tmp:/tmp --pid=container:$(c) --net=container:$(c) --cap-add all reg.qiniu.com/lutaoact/debug-tools; \
	fi
