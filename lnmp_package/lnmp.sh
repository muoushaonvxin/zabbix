#!/bin/bash
#

# cmake2.8.12
./bootstrap --prefix=/usr/local/cmake && make && make install
/usr/local/cmake/bin/cmake . -LAH

# mysql5.6
/usr/local/cmake/bin/cmake . -LAH
/usr/local/cmake/bin/cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DINSTALL_MYSQLDATADIR=/data/bdnfx/ -DMYSQL_DATADIR=/data/bdnfx/ -DSYSCONFDIR=/usr/local/mysql/etc -DWITH_INNOBASE_STORAGE_ENGINE=1 -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DMYSQL_TCP_PORT=5535 -DMYSQL_UNIX_ADDR=/usr/local/mysql/tmp/mysql.sock -DWITH_EXTRA_CHARSETS=all
make && make install 

# php5.4
./configure --prefix=/usr/local/php5 --with-config-file-path=/usr/local/php5/etc --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-pdo-mysql=/usr/local/mysql/ --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --enable-discard-path --enable-magic-quotes --enable-safe-mode --enable-bcmath --enable-shmop --enable-system --enable-inline-optimization --with-curl --enable-mbregex --enable-fastcgi --enable-fpm --enable-force-cgi-redirect --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --with-mime-magi
make && make install 

# nginx1.8.0
yum -y install pcre-devel
useradd nginx
./configure --user=nginx --group=nginx --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6
make && make install
