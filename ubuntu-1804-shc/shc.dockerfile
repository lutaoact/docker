FROM stag-reg.llsops.com/algorithm/ubuntu-1804-base-image:20200111173555

RUN add-apt-repository ppa:neurobin/ppa && apt-get update && apt-get install -y --no-install-recommends \
        build-essential shc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/

# 采用先构建环境，然后生成结果，再将结果copy到镜像中的模式
COPY qshell-linux-x64-v2.4.1 /usr/bin/qshell
COPY update_token            /usr/bin/update_token

VOLUME /my_mount
WORKDIR /my_mount

ENTRYPOINT ["update_token"]
