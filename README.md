# 安装zabbix3.0

<br>

<br>

使用编译安装 Nginx + zabbix + mysql + cmake + php 安装完成监控搭建

<br>

### 编译安装cmake
```shell
[root@zhangyz ~]# tar zxvf cmake-2.8.12.tar.gz -C /usr/src
[root@zhangyz ~]# cd /usr/src/cmake.2.8.12
[root@zhangyz cmake.2.8.12]# ./bootstrap --prefix=/usr/local/cmake 
Curses libraries were not found. Curses GUI for CMake will not be built.
-- Looking for elf.h
-- Looking for elf.h - found
-- Looking for a Fortran compiler
-- Looking for a Fortran compiler - NOTFOUND
-- Looking for Q_WS_X11
-- Looking for Q_WS_X11 - found
-- Looking for Q_WS_WIN
-- Looking for Q_WS_WIN - not found
-- Looking for Q_WS_QWS
-- Looking for Q_WS_QWS - not found
-- Looking for Q_WS_MAC
-- Looking for Q_WS_MAC - not found
-- Found Qt4: /usr/bin/qmake (found version "4.8.7") 
-- Performing Test QT4_WORKS
-- Performing Test QT4_WORKS - Success
-- Performing Test run_pic_test
-- Performing Test run_pic_test - Success
-- Configuring done
-- Generating done
-- Build files have been written to: /usr/src/cmake-2.8.12.2
[root@zhangyz cmake.2.8.12]# make 
[100%] Building C object Tests/CTestTestMemcheck/NoLogDummyChecker/CMakeFiles/pseudonl_purify.dir/ret0.c.o
Linking C executable purify
[100%] Built target pseudonl_purify
Scanning dependencies of target pseudonl_valgrind
[100%] Building C object Tests/CTestTestMemcheck/NoLogDummyChecker/CMakeFiles/pseudonl_valgrind.dir/ret0.c.o
Linking C executable valgrind
[100%] Built target pseudonl_valgrind
[root@zhangyz cmake.2.8.12]# make install
-- Installing: /usr/local/cmake/share/cmake-2.8/editors/vim/cmake-syntax.vim
-- Installing: /usr/local/cmake/share/cmake-2.8/editors/emacs/cmake-mode.el
-- Installing: /usr/local/cmake/share/cmake-2.8/completions/cmake
-- Installing: /usr/local/cmake/share/cmake-2.8/completions/cpack
-- Installing: /usr/local/cmake/share/cmake-2.8/completions/ctest
[root@zhangyz cmake.2.8.12]# /usr/local/cmake/bin/cmake . -LAH
[root@zhangyz cmake.2.8.12]# /usr/local/cmake/bin/cmake --version
cmake version 2.8.12.2

```

### 编译安装mysql
```shell
[root@zhangyz ~]# tar -xf mysql-5.6.16.tar.gz -C /usr/src
[root@zhangyz ~]# cd /usr/src/mysql-5.6.16/
[root@zhangyz mysql-5.6.16]# /usr/local/cmake/bin/cmake . -LAH 
[root@zhangyz mysql-5.6.16]# /usr/local/cmake/bin/cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DINSTALL_MYSQLDATADIR=/data/db/ -DMYSQL_DATADIR=/data/db/ -DSYSCONFDIR=/usr/local/mysql/etc -DWITH_INNOBASE_STORAGE_ENGINE=1 -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DMYSQL_TCP_PORT=5535 -DMYSQL_UNIX_ADDR=/usr/local/mysql/tmp/mysql.sock -DWITH_EXTRA_CHARSETS=all
-- Running cmake version 2.8.12.2
CMake Warning (dev) at CMakeLists.txt:187 (INCLUDE):
  Syntax Warning in cmake code at

    /usr/src/mysql-5.6.16/cmake/ssl.cmake:237:55

  Argument not separated from preceding token by whitespace.
This warning is for project developers.  Use -Wno-dev to suppress it.

-- MySQL 5.6.16
-- Packaging as: mysql-5.6.16-Linux-x86_64
-- HAVE_VISIBILITY_HIDDEN
-- HAVE_VISIBILITY_HIDDEN
-- HAVE_VISIBILITY_HIDDEN
-- Could NOT find Curses (missing:  CURSES_LIBRARY CURSES_INCLUDE_PATH) 
CMake Error at cmake/readline.cmake:85 (MESSAGE):
  Curses library not found.  Please install appropriate package,

      remove CMakeCache.txt and rerun cmake.On Debian/Ubuntu, package name is libncurses5-dev, on Redhat and derivates it is ncurses-devel.
Call Stack (most recent call first):
  cmake/readline.cmake:128 (FIND_CURSES)
  cmake/readline.cmake:202 (MYSQL_USE_BUNDLED_EDITLINE)
  CMakeLists.txt:410 (MYSQL_CHECK_EDITLINE)


-- Configuring incomplete, errors occurred!
See also "/usr/src/mysql-5.6.16/CMakeFiles/CMakeOutput.log".
See also "/usr/src/mysql-5.6.16/CMakeFiles/CMakeError.log".
```

以上的运行结果报了一个错误, 要先安装一个依赖包Curses然后在移除掉CMakeCache.txt文件在重新运行编译, 解决方法如下

```shell
[root@zhangyz mysql-5.6.16]# yum -y install ncurses-devel
[root@zhangyz mysql-5.6.16]# rm -rf CMakeCache.txt 
[root@zhangyz mysql-5.6.16]# /usr/local/cmake/bin/cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DINSTALL_MYSQLDATADIR=/data/db/ -DMYSQL_DATADIR=/data/db/ -DSYSCONFDIR=/usr/local/mysql/etc -DWITH_INNOBASE_STORAGE_ENGINE=1 -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DMYSQL_TCP_PORT=5535 -DMYSQL_UNIX_ADDR=/usr/local/mysql/tmp/mysql.sock -DWITH_EXTRA_CHARSETS=all
-- Looking for asprintf - found
-- Check size of pthread_t
-- Check size of pthread_t - done
-- Performing Test HAVE_PEERCRED
-- Performing Test HAVE_PEERCRED - Success
-- Library mysqlclient depends on OSLIBS -lpthread;m;dl
-- Googlemock was not found. gtest-based unit tests will be disabled. You can run cmake . -DENABLE_DOWNLOADS=1 to automatically download and build required components from source.
-- If you are inside a firewall, you may need to use an http proxy: export http_proxy=http://example.com:80
Warning: Bison executable not found in PATH
-- Library mysqlserver depends on OSLIBS -lpthread;m;crypt;dl
-- Configuring done
-- Generating done
-- Build files have been written to: /usr/src/mysql-5.6.16
[root@zhangyz mysql-5.6.16]# make
[root@zhangyz mysql-5.6.16]# make install 
```

安装完成之后进入mysql源码安装目录
```shell
[root@zhangyz mysql-5.6.16]# cd /usr/local/mysql
[root@zhangyz mysql]# mkdir tmp etc var log
[root@zhangyz mysql]# cp scripts/mysql_install_db ./bin 
```

创建一个mysql用户, 如果已经存在就不需要创建
```shell
[root@zhangyz mysql]# useradd -M -s /sbin/nologin mysql
```

修改权限
```shell
[root@zhangyz mysql]# chown root:mysql /usr/local/mysql/ -R
[root@zhangyz mysql]# chown mysql:mysql /data/db/ -R   
```

初始化mysql数据库
```shell
//如果要指定配置文件的位置，使用下面参数 --defaults-file=/usr/local/mysql/etc/my.cnf
[root@zhangyz mysql]# /usr/local/mysql/bin/mysql_install_db --basedir=/usr/local/mysql/ --datadir=/data/db --user=mysql
```

启动mysql
```shell
[root@zhangyz mysql]# /usr/local/mysql/bin/mysqld_safe --user=mysql &
```

打开mysql数据库
```shell
[root@zhangyz ~]# /usr/local/mysql/bin/mysql
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 26
Server version: 5.6.12 Source distribution

Copyright (c) 2000, 2014, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
```

启动成功了, 接下来为mysql数据库设定一个密码
```shell
[root@zhangyz ~]# /usr/local/mysql/bin/mysqladmin -u root password redhat
[root@zhangyz ~]# /usr/local/mysql/bin/mysql -uroot -p'redhat'
Warning: Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 28
Server version: 5.6.16 Source distribution

Copyright (c) 2000, 2014, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
```

查看mysql数据库的端口
```shell
[root@zhangyz ~]# netstat -tunlp | grep mysql 
tcp        0      0 :::5635                     :::*                        LISTEN      24815/mysqld    
```

### 编译安装php
```shell
[root@zhangyz ~]# tar -xf php-5.4.17.tar.gz -C /usr/src
[root@zhangyz ~]# cd /usr/src/php-5.4.17/
[root@zhangyz php-5.4.17]# ./configure --prefix=/usr/local/php5 --with-config-file-path=/usr/local/php5/etc --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-pdo-mysql=/usr/local/mysql/ --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --enable-discard-path --enable-magic-quotes --enable-safe-mode --enable-bcmath --enable-shmop --enable-system --enable-inline-optimization --with-curl --enable-mbregex --enable-fastcgi --enable-fpm --enable-force-cgi-redirect --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --with-mime-magi
[root@zhangyz php-5.4.17]# make
[root@zhangyz php-5.4.17]# make install 
```

安装完成之后在/usr/src/php-5.4.16目录下
```shell
[root@zhangyz php-5.4.17]# cp php.ini-development /usr/local/php5/etc/php.ini
```

完成之后
```shell
[root@zhangyz php-5.4.17]# cd /usr/local/php5/etc
```

编辑php.ini配置文件
```shell
[root@zhangyz etc]# vim php.ini
date.timezone = Asia/Shanghai
post_max_size = 32M
max_execution_time = 300
max_input_time = 300 
[root@zhangyz etc]# cp php-fpm.conf.default php-fpm.conf
[root@zhangyz etc]# vim php-fpm.conf
pid = run/var/php.pid
user = nginx
group = nginx
pm.start_servers = 20
pm.min_spare_servers = 5
pm.max_spare_servers = 35
```

更改完之后需要重启php, 重启完成之后最好使用 ps -ef | grep php 查看下

### 编译安装nginx

添加普通用户账号来运行nginx
```shell
[root@zhangyz ~]# useradd nginx
[root@zhangyz ~]# tar xf nginx-1.8.1.tar.gz -C /usr/src 
[root@zhangyz ~]# cd /usr/src/nginx-1.8.1/
[root@zhangyz nginx-1.8.1]# ./configure --user=nginx --group=nginx --prefix=/usr/local/nginx  --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6
[root@zhangyz nginx-1.8.1]# make
[root@zhangyz nginx-1.8.1]# make install
[root@zhangyz nginx-1.8.1]# /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf 
```

配置一个nginx的启动脚本
```shell
[root@zhangyz ~]# vim /etc/init.d/nginx
#!/bin/bash
# chkconfig: - 99 20
# description: Oooo this is my nginx startup script
PROG="/usr/local/nginx/sbin/nginx"
PIDF="/usr/local/nginx/logs/nginx.pid"
case "$1" in
    start)
        $PROG
    ;;
    stop)
        kill -s QUIT $(cat $PIDF)
    ;;
    restart)
        $0 stop
        $0 start
    ;;
    reload)
        kill -s HUP $(cat $PIDF)
    ;;
    *)
        echo "Usage: $0 {start|stop|restart|reload}"
        exit 1
    ;;
esac
exit 0
[root@zhangyz ~]# chmod +x /etc/init.d/nginx
[root@zhangyz ~]# chkconfig --add nginx
```

 
配置nginx支持php的解析
```shell
[root@zhangyz ~]# vim /usr/local/nginx/conf/nginx.conf
server {
    listen       80;
    server_name www.abc.com;          
    charset utf-8;      
    access_log logs/host.access.log main;          
    
    location / {
        root   /var/www/yahoo;
        index index.html index.php;
    }
    
    location ~ \.php$ {
        root    /var/www/yahoo;
        fastcgi_pass    127.0.0.1:9000; 
        fastcgi_index   index.php;
        include         fastcgi.conf;
    }
    
    location ~ /status {
        stub_status     on;
        access_log      off;
    }
    
    error_page   500 502 503 504 /50x.html;
    location = /50x.html {
        root   html;
    }
}
```

写一个php页面进行测试
```shell
[root@zhangyz ~]# vim /var/www/yahoo/test.php
<?php
$link=mysql_connect('localhost','root','');
if($link){
    echo "<h1>successfull!!</h1>";
}
mysql_close();
?>
```

### 编译安装zabbix
```shell
[root@zhangyz ~]# tar -xf zabbix-3.4.1.tar.gz -C /usr/src
[root@zhangyz ~]# cd /usr/src/zabbix-3.4.1
[root@zhangyz zabbix-3.4.1]# ./configure --prefix=/usr/local/zabbix --enable-server --enable-proxy --enable-agent --with-mysql=/usr/local/mysql/bin/mysql_config --with-net-snmp --with-libcurl
[root@zhangyz zabbix-3.4.1]# make 
[root@zhangyz zabbix-3.4.1]# make install 
```

在mysql数据库当中创建一个zabbix用户和名字叫zabbix的数据库
```shell
mysql> CREATE DATABASE `zabbix` /*!40100 DEFAULT CHARACTER SET utf8 */;
mysql> use mysql;
mysql> grant all privileges on zabbix.* to 'zabbix'@'192.168.1.%' identified by 'zabbix';
mysql> flush privileges;
```

将zabbix的sql数据导入mysql数据库
```shell
[root@zhangyz zabbix-3.4.1]# /usr/local/mysql/bin/mysql -uzabbix -pzabbix -hlocalhost zabbix < database/mysql/schema.sql
[root@zhangyz zabbix-3.4.1]# /usr/local/mysql/bin/mysql -uzabbix -pzabbix -hlocalhost zabbix < database/mysql/images.sql
[root@zhangyz zabbix-3.4.1]# /usr/local/mysql/bin/mysql -uzabbix -pzabbix -hlocalhost zabbix < database/mysql/data.sql
```

修改配置文件
```shell
[root@zhangyz zabbix-3.4.1]# cp misc/init.d/fedora/core/zabbix_server /etc/init.d/
[root@zhangyz zabbix-3.4.1]# cp misc/init.d/fedora/core/zabbix_agentd /etc/init.d/
[root@zhangyz zabbix-3.4.1]# cp -R frontends/php /var/www/html/zabbix
[root@zhangyz zabbix-3.4.1]# sed -i 's/^DBUser=.*$/DBUser=zabbix/g' /usr/local/zabbix/etc/zabbix_server.conf
[root@zhangyz zabbix-3.4.1]# sed -i 's/^.*DBPassword=.*$/DBPassword=zabbix/g' /usr/local/zabbix/etc/zabbix_server.conf
[root@zhangyz zabbix-3.4.1]# sed -i 's/BASEDIR=\/usr\/local/BASEDIR=\/usr\/local\/zabbix/g' /etc/init.d/zabbix_server
[root@zhangyz zabbix-3.4.1]# sed -i 's/BASEDIR=\/usr\/local/BASEDIR=\/usr\/local\/zabbix/g' /etc/init.d/zabbix_agentd
```

添加zabbix服务端口到 /etc/services 文件当中
```shell
[root@zhangyz zabbix-3.4.1]# vim /etc/services eof
zabbix-agent    10050/tcp   # Zabbix Agent
zabbix-agent    10050/udp   # Zabbix Agent
zabbix-trapper  10051/tcp   # Zabbix Trapper
zabbix-trapper  10051/udp   # Zabbix Trapper
```

启动服务并开机启动
```shell
[root@zhangyz zabbix-3.4.1]# /etc/init.d/zabbix_server start
[root@zhangyz zabbix-3.4.1]# /etc/init.d/zabbix_agentd start
```

编写一个脚本一键重启php,nginx,mysql,zabbix等服务
```bash
#!/bin/bash
#

function start() {
    /etc/init.d/mysqld start
    /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
    /usr/local/php5/sbin/php-fpm -c /usr/local/php5/etc/php.ini-conf
    /etc/init.d/zabbix_server start
    sync;sync;sync;sync;sync
    sleep 2
}

function listen(){	
    netstat -tunlp | grep -E "(3306|80|9000|10051)"
}

function stop() {
    /etc/init.d/mysqld stop
    kill `cat /usr/local/php5/var/run/php-fpm.pid`
    kill `netstat -tunlp | grep nginx | awk '{print $NF}' | cut -d "/" -f1`
    /etc/init.d/zabbix_server stop
    sync;sync;sync;sync;sync
}

case "$1" in
    start)
        start
    ;;
    stop)
        stop
    ;;
    listen)
        listen
    ;;
    *)
        echo "Usage: `basename $0` stop | start"
    ;;
esac
```

<br>

<br>

# Zabbix Agent端

1.安装开发软件包
```shell
[root@agent01 ~]# yum -y groupinstall "Development Tools"
[root@agent01 ~]# yum –y install ntpdate
```

2.同步客户端时间防止跟服务器端不一致导致检测到不可用的监控数据
```shell
ntpdate pool.ntp.org
```

3.创建zabbix运行所需要的用户跟组
```shell
[root@agent01 ~]# groupadd -g 201 zabbix
[root@agent01 ~]# useradd -g zabbix -u 201 -m zabbix
```

4.解压安装 zabbix agent端
```shell
[root@agent01 ~]# cd /usr/src/
[root@agent01 src]# tar xf zabbix-3.4.1.tar.gz
[root@agent01 src]# cd zabbix-3.4.1
[root@agent01 zabbix-3.4.1]# ./configure –sysconfdir=/etc/zabbix --prefix=/usr/local/zabbix --enable-agent
[root@agent01 zabbix-3.4.1]# make 
[root@agent01 zabbix-3.4.1]# make install
```

5.copy agent端运行所需要的脚本
```shell
[root@agent01 zabbix-3.4.1]# cp misc/init.d/tru64/zabbix_agentd /etc/init.d/
[root@agent01 zabbix-3.4.1]# chmod +x /etc/init.d/zabbix_agentd
```

6.配置agent端配置文件
```shell
[root@agent01 zabbix-3.4.1]# vim /etc/zabbix/zabbix_agentd.conf   # 此处千万别写成了zabbix_agent.conf否则配置了不生效
Server=192.168.1.1                   # 填写Server的IP地址
ServerActive=192.168.1.1             # 修改为Server的IP地址
Hostname=agent01                     # 填写本机的HostName,注意Server端要能解析
UnsafeUserParameters=1                   # 是否允许自定义的key,1为允许，0为不允许
Include=etc/zabbix/zabbix_agentd.conf.d/ # 自定义的agentd配置文件(key)可以在这里面写；
```

7.启动zabbix agent端
```shell
[root@agent01 zabbix-3.4.1]# /etc/init.d/zabbix_agentd start
```
