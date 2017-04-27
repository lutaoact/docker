FROM centos:6
MAINTAINER Lu Tao lutaoact
ENV REFERESHED_AT 2017-04-27

RUN yum install -y wget

# 安装阿里云的镜像源
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
RUN yum makecache

# 安装php56和php-fpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

RUN yum install -y php56w php56w-devel php56w-pdo php56w-opcache php56w-mbstring php56w-fpm
RUN php-fpm -t
RUN chkconfig --add php-fpm
RUN chkconfig php-fpm on

# 安装nginx
ADD nginx.repo /etc/yum.repos.d/
RUN wget http://nginx.org/keys/nginx_signing.key
RUN rpm --import nginx_signing.key
RUN yum -y update && yum install -y nginx
RUN chkconfig --add nginx
RUN chkconfig nginx on
EXPOSE 80

# 安装mysql
RUN yum install -y mysql mysql-server mariadb-server
RUN chkconfig --add mysqld
RUN chkconfig mysqld on

RUN usermod -a -G nginx nginx
ADD demo.gupws.com.conf /etc/nginx/conf.d/
ADD www.conf /etc/php-fpm.d/
