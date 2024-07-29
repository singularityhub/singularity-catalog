# Copyright (c) 2015-2016, Gregory M. Kurtzer. All rights reserved.
#
# "Singularity" Copyright (c) 2016, The Regents of the University of California,
# through Lawrence Berkeley National Laboratory (subject to receipt of any
# required approvals from the U.S. Dept. of Energy).  All rights reserved.

BootStrap: debootstrap
OSVersion: bionic
MirrorURL: http://us.archive.ubuntu.com/ubuntu/



%files
    # copying files from the host system to the container.
	httpd-2.4.35.tar.gz /usr/local/src
	apr-1.6.5.tar.gz    /usr/local/src
	apr-util-1.6.1.tar.gz /usr/local/src
	apache_start.sh /usr/local/bin
	apache_stop.sh  /usr/local/bin
	edit_httpd_conf.pl /usr/local/src


%labels
    Maintainer Osamu Ogasawara
	Version    v1.0


    

%runscript
    cd /usr/local/apache2/bin
	./apachectl start


%post
    echo "Hello from inside the container"
    sed -i 's/$/ universe/' /etc/apt/sources.list
	apt-get -y update
	apt-get -y upgrade
	
    apt-get -y install emacs wget build-essential
	apt-get -y install automake autoconf libtool less
	apt-get -y install libxml2-dev libpcre3 libexpat1-dev

    export LC_CTYPE=C
    cd /usr/local/src
    tar zxvf httpd-2.4.35.tar.gz
    cd httpd-2.4.35/srclib

    cp ../../apr-1.6.5.tar.gz .
    tar zxvf apr-1.6.5.tar.gz
    mv apr-1.6.5 apr

    cp ../../apr-util-1.6.1.tar.gz .
    tar zxvf apr-util-1.6.1.tar.gz
    mv apr-util-1.6.1 apr-util

    cd ..
    ./configure --with-included-apr
    make -j 8
    make install

    # chmod start/stop scripts.
    chmod +x /usr/local/bin/apache_start.sh
    chmod +x /usr/local/bin/apache_stop.sh

    # edit httpd.conf
    cd /usr/local/apache2
    cp /usr/local/src/edit_httpd_conf.pl .
    cat conf/httpd.conf | perl edit_httpd_conf.pl > httpd.conf
    mv conf/httpd.conf conf/httpd.conf.bak
    cp httpd.conf conf/httpd.conf
	


