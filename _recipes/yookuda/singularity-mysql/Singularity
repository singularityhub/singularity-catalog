BootStrap: docker
From: ubuntu:18.04

%labels
    Maintainer Yoshihiro Okuda
        Version    v1.0

%environment
    PATH=/usr/local/mysql/bin:$PATH
    export PATH

%post
    echo "Hello from inside the container"
    sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
    sed -i.bak -e "s%http://security.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
    apt-get -y update
    apt-get -y upgrade
    apt-get -y install vim wget sudo less

    # install MySQL
    MYSQL_VERSION=5.6.46
    cd /usr/local/src
    wget http://ftp.jaist.ac.jp/pub/mysql/Downloads/MySQL-5.6/mysql-${MYSQL_VERSION}.tar.gz
    tar xzvf mysql-${MYSQL_VERSION}.tar.gz
    cd mysql-${MYSQL_VERSION}
    apt-get -y install cmake libncurses5-dev make gcc g++ libssl-dev
    mkdir /usr/local/boost
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
    -DDOWNLOAD_BOOST=1 -DWITH_BOOST=/usr/local/boost -DDEFAULT_CHARSET=utf8 \
    -DDEFAULT_COLLATION=utf8_general_ci \
    -DWITH_INNOBASE_STORAGE_ENGINE=1 \
    -DMYSQL_UNIX_ADDR=/usr/local/mysql/data/mysql.sock
    make -j 4 && make install

    apt-get -y install cpanminus
    cpanm File::Copy
    cpanm Sys::Hostname
    cpanm Data::Dumper

    rm -r /usr/local/src/*

