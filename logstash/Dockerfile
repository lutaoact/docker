FROM ubuntu:14.04
MAINTAINER Lu Tao lutaoact
ENV REFERESHED_AT 2015-12-03

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update
RUN apt-get -y install wget

RUN apt-get install -y python-software-properties
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get -y install oracle-java8-installer

RUN wget -O - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elastic.co/logstash/2.1/debian stable main" | sudo tee -a /etc/apt/sources.list
RUN apt-get update && apt-get -y install logstash
ADD logstash.conf /etc/
WORKDIR /opt/logstash

RUN touch /opt/logstash/sincedb-access
RUN chown logstash:logstash /opt/logstash/sincedb-access

# 缺失一个库，否则会报错
# NotImplementedError: stat.st_dev unsupported or native support failed to load dev_major at org/jruby/RubyFileStat.java:188
RUN ln -s /lib/x86_64-linux-gnu/libcrypt.so.1 /usr/lib/x86_64-linux-gnu/libcrypt.so

ENTRYPOINT [ "bin/logstash" ]
CMD ["--config=/etc/logstash.conf"]
