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

# 安装nginx
ADD nginx.repo /etc/yum.repos.d/
RUN wget http://nginx.org/keys/nginx_signing.key
RUN rpm --import nginx_signing.key
RUN yum -y update && yum install -y nginx

# 安装mysql
RUN yum install -y mysql mysql-server mariadb-server

RUN usermod -a -G nginx nginx
ADD www.conf /etc/php-fpm.d/

ADD libdatrie-0.2.4.tar.gz /root/
WORKDIR /root

RUN yum install -y gcc
RUN cd libdatrie-0.2.4 && ./configure && make && make install

ADD php-5.6.30.tar.gz /root/
ADD sougu.tar.gz /root/php-5.6.30/ext/
WORKDIR /root/php-5.6.30/ext/sougu/

RUN phpize
RUN ./configure --with-php-config=/usr/bin/php-config && make && make install
RUN echo $'\n'extension=trie_filter.so >> /etc/php.ini

ADD libHLSWknl.so /usr/lib64/
RUN chmod +x /usr/lib64/libHLSWknl.so
RUN ln -s /usr/lib64/libssl.so.1.0.1e /usr/lib64/libssl.so.6
RUN ln -s /usr/lib64/libcrypto.so.1.0.1e /usr/lib64/libcrypto.so.6

ADD libHLUuid.so /usr/lib/
RUN chmod +x /usr/lib/libHLUuid.so

RUN ldconfig

WORKDIR /root/php-5.6.30/ext/
RUN ./ext_skel --extname=hluuid

WORKDIR /root/php-5.6.30/ext/hluuid
RUN sed -i '16,18s/^dnl //' config.m4
ADD hluuid.c /root/php-5.6.30/ext/hluuid/
RUN phpize
RUN ./configure --enable-hluuid=shared && make LDFLAGS=-lHLUuid && make install
RUN echo $'\n'extension=hluuid.so >> /etc/php.ini
RUN sed -i '889i date.timezone = PRC' /etc/php.ini

ADD freetds-patched.tar.gz /root/
WORKDIR /root/freetds-1.00.27
RUN ./configure --prefix=/usr/local/freetds --with-tdsver=7.2 --enable-msdblib && make && make install

WORKDIR /root/php-5.6.30/ext/pdo_dblib
RUN phpize
RUN ./configure --with-php-config=/usr/bin/php-config --with-pdo-dblib=/usr/local/freetds && make && make install
RUN echo 'extension=pdo_dblib.so' >> /etc/php.d/pdo_dblib.ini

RUN yum install -y php56w-odbc php56w-mysql
RUN sed -i '/\[mysqld\]/a max_allowed_packet=800m' /etc/my.cnf
RUN sed -i '/\[mysqld\]/a max_connections=20000' /etc/my.cnf

ADD antiword-0.37-17.el6.x86_64.rpm /root/
WORKDIR /root/
RUN rpm -i antiword-0.37-17.el6.x86_64.rpm

EXPOSE 80

ADD ht_poc.sql /root/

RUN sed -i '396s/128/4096/' /etc/php.ini

ADD oracle-instantclient11.2-*-11.2.0.4.0* /root/

RUN yum -y install libaio

RUN rpm -ivh oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm
RUN rpm -ivh oracle-instantclient11.2-devel-11.2.0.4.0-1.x86_64.rpm

RUN ln -s /usr/include/oracle/11.2/client64 /usr/include/oracle/11.2/client
RUN ln -s /usr/lib/oracle/11.2/client64 /usr/lib/oracle/11.2/client

ENV ORACLE_HOME /usr/lib/oracle/11.2/client64
ENV LD_LIBRARY_PATH $ORACLE_HOME/lib

RUN sed -i '12i env[LD_LIBRARY_PATH] = /usr/lib/oracle/11.2/client64/lib' /etc/php-fpm.conf
RUN sed -i '13i env[ORACLE_HOME] = /usr/lib/oracle/11.2/client64/lib' /etc/php-fpm.conf

WORKDIR /root
ADD PDO_OCI-1.0.tar.gz /root/
WORKDIR /root/PDO_OCI-1.0
RUN phpize
RUN ./configure --with-pdo-oci=instantclient,/usr,11.2 && make && make install

ADD pdo_oci.ini /etc/php.d/

ADD oci8-2.0.8.tgz /root/
WORKDIR /root/oci8-2.0.8
RUN phpize
RUN ./configure --with-oci8=shared,instantclient,/usr/lib/oracle/11.2/client64/lib && make && make install
ADD oci8.ini /etc/php.d/

ADD demo.gupws.com.conf /etc/nginx/conf.d/
ADD trunk/ /var/www/htpoc/trunk/

WORKDIR /var/www/htpoc/trunk/
RUN chmod -R 777 ./ && chown -R nginx:nginx ./

WORKDIR /var/www/htpoc/trunk/public/
