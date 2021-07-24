Bootstrap: docker
From: ubuntu:18.04

%environment
    export GUACAMOLE_HOME=/etc/guacamole
    export PATH=/usr/local/mysql/bin:$PATH
%post
    sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
    sed -i.bak -e "s%http://security.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
    apt-get -y update
    apt-get -y upgrade
    apt-get -y install vim wget sudo less

    apt-get -y install gcc g++ software-properties-common libcairo2-dev libjpeg-turbo8-dev libpng-dev libtool-bin libossp-uuid-dev libavutil-dev libswscale-dev build-essential libssh2-1-dev libssl-dev libpango1.0-dev libvncserver-dev libtelnet-dev libpulse-dev libwebp-dev libogg-dev libvorbis-dev libvorbisenc2 libwebp-dev 
#    add-apt-repository ppa:remmina-ppa-team/freerdp-daily
#    apt-get -y update
    apt-get -y install freerdp2-dev freerdp2-x11 
    apt-get -y install openjdk-11-jdk unzip

    # install MySQL

    MYSQL_VERSION=5.6.51
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

    # install guacamole server

    cd /usr/local/src
    wget http://archive.apache.org/dist/guacamole/1.3.0/source/guacamole-server-1.3.0.tar.gz
    tar xzvf guacamole-server-1.3.0.tar.gz
    cd guacamole-server-1.3.0
    ./configure
    make
    make install
    echo /usr/local/lib > /etc/ld.so.conf.d/custom.conf
    ldconfig
    mkdir /etc/guacamole

    # install tomcat

    cd /usr/local/src
    export TOMCAT_VERSION="9.0.50"
    wget https://ftp.kddi-research.jp/infosystems/apache/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
    tar xzvf apache-tomcat-${TOMCAT_VERSION}.tar.gz
    mv apache-tomcat-${TOMCAT_VERSION} /opt/tomcat
    rm -r /opt/tomcat/webapps/*

    # install guacamole.war

    cd /usr/local/src
    wget http://archive.apache.org/dist/guacamole/1.3.0/binary/guacamole-1.3.0.war
    cp guacamole-1.3.0.war /opt/tomcat/webapps/guacamole.war
    /opt/tomcat/bin/startup.sh
    sleep 10
    /opt/tomcat/bin/shutdown.sh

    chmod 755 /opt/tomcat/bin
    chmod 755 /opt/tomcat/bin/*
    chmod 755 /opt/tomcat/conf
    chmod 644 /opt/tomcat/conf/*
    chmod 755 /opt/tomcat/lib
    chmod 644 /opt/tomcat/lib/*
    chmod 755 /opt/tomcat/webapps
    chmod 755 -R /opt/tomcat/webapps/guacamole

    cd /usr/local/src
    wget http://archive.apache.org/dist/guacamole/1.3.0/binary/guacamole-auth-jdbc-1.3.0.tar.gz
    tar xzvf guacamole-auth-jdbc-1.3.0.tar.gz
    wget http://ftp.jaist.ac.jp/pub/mysql/Downloads/Connector-J/mysql-connector-java-5.1.49.tar.gz
    tar xzvf mysql-connector-java-5.1.49.tar.gz

