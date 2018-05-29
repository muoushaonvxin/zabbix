# 安装zabbix3.0

<br>

<br>

使用编译安装 Nginx + zabbix + mysql + cmake + php 安装完成监控搭建

<br>

1.搭建cmake
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
