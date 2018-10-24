FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN echo 'deb http://mirrors.163.com/ubuntu/ xenial main restricted universe multiverse\n\
deb http://mirrors.163.com/ubuntu/ xenial-security main restricted universe multiverse\n\
deb http://mirrors.163.com/ubuntu/ xenial-updates main restricted universe multiverse\n\
deb http://mirrors.163.com/ubuntu/ xenial-proposed main restricted universe multiverse\n\
deb http://mirrors.163.com/ubuntu/ xenial-backports main restricted universe multiverse\n\
deb-src http://mirrors.163.com/ubuntu/ xenial main restricted universe multiverse\n\
deb-src http://mirrors.163.com/ubuntu/ xenial-security main restricted universe multiverse\n\
deb-src http://mirrors.163.com/ubuntu/ xenial-updates main restricted universe multiverse\n\
deb-src http://mirrors.163.com/ubuntu/ xenial-proposed main restricted universe multiverse\n\
deb-src http://mirrors.163.com/ubuntu/ xenial-backports main restricted universe multiverse' > /etc/apt/sources.list

RUN apt-get update && apt-get install -y apt-transport-https

# 安装mongo的相关工具
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list
RUN apt-get update && apt-get install -y mongodb-org-shell mongodb-org-tools

# 安装redis-cli
ADD redis-cli /usr/local/bin/redis-cli

COPY localtime /etc/localtime
COPY timezone /etc/timezone

# 安装其它调试工具，每层单独安装，方便复用构建缓存
RUN apt-get update && apt-get install -y \
    ca-certificates \
    iputils-ping \
    telnet \
    wget \
    vim \
    curl \
    strace \
    lsof \
    net-tools \
    dnsutils \
    tcpdump \
    nethogs \
    mtr \
    traceroute \
    netcat \
    cron \
  && rm -rf /var/lib/apt/lists/*

ADD vimrc /root/.vimrc

CMD ["bash"]
