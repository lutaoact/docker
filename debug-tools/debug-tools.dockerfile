FROM ubuntu:16.04

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

RUN apt-get update \
    && apt-get install -y telnet wget vim curl strace lsof net-tools dnsutils ca-certificates \
    && apt-get clean

ADD vimrc /root/.vimrc
