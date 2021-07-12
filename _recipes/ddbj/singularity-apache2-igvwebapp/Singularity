BootStrap: docker
From: ubuntu:18.04


%files
    # copying files from the host system to the container.


%labels
    Maintainer Yoshihiro Okuda
    Version    v1.0


%runscript
    cd /usr/local/apache2/bin
    ./apachectl start


%post
    echo "Hello from inside the container"
#    sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
#    sed -i.bak -e "s%http://security.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
    apt-get -y update
    apt-get -y upgrade
        
    apt-get -y install vim wget less

    # install apache2.4
    apt-get -y install make gcc
    apt-get -y install libpcre3-dev libexpat1-dev

    export LC_CTYPE=C
    cd /usr/local/src
    export APACHE_VERSION=2.4.48
    wget http://archive.apache.org/dist/httpd/httpd-${APACHE_VERSION}.tar.gz
    tar zxvf httpd-${APACHE_VERSION}.tar.gz
    cd httpd-${APACHE_VERSION}/srclib

    export APR_VERSION=1.7.0
    wget http://archive.apache.org/dist/apr/apr-${APR_VERSION}.tar.gz
    tar zxvf apr-${APR_VERSION}.tar.gz
    mv apr-${APR_VERSION} apr

    export APR_UTIL_VERSION=1.6.1
    wget http://archive.apache.org/dist/apr/apr-util-${APR_UTIL_VERSION}.tar.gz
    tar zxvf apr-util-${APR_UTIL_VERSION}.tar.gz
    mv apr-util-${APR_UTIL_VERSION} apr-util

    cd ..
    ./configure --with-included-apr
    make -j 8
    make install

    cd /usr/local/src/
    rm -r /usr/local/src/httpd*

    # install nodejs, npm
    apt-get -y install git

    apt-get -y install nodejs npm
    npm install -g n
    n lts
    apt -y purge nodejs npm
    apt -y autoremove

    # install igv-webapp
    git clone https://github.com/igvteam/igv-webapp.git
    cd igv-webapp
    git checkout refs/tags/v1.5.5
    /usr/local/bin/npm install
    /usr/local/bin/npm run build
