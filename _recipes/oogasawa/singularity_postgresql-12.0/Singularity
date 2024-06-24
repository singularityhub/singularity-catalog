BootStrap: docker
From: ubuntu:20.04

%labels
    Maintainer Yoshihiro Okuda, Osamu Ogasawara
    Version    v1.1.0
		
		

%environment
    export PATH=/usr/local/pgsql/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/pgsql/lib:$LD_LIBRARY_PATH
    export LC_ALL="en_GB.UTF-8"
    export LC_CTYPE="en_GB.UTF-8"
    export LANG="en_GB.UTF-8"

%post
    apt-get -y update
    apt-get -y upgrade


    # Noninteractive install of tzdata
	# https://stackoverflow.com/questions/44331836/apt-get-install-tzdata-noninteractive
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
    apt-get -y install wget python3-dev

    # install PostgreSQL
    apt-get -y install make gcc libreadline-dev zlib1g-dev libperl-dev libpython2.7-dev libpython3-dev gettext libssl-dev libxml2-dev libxslt1-dev
    useradd user1
    chown user1 /usr/local/src
    cd /usr/local/src
    su -c 'wget https://ftp.postgresql.org/pub/source/v12.0/postgresql-12.0.tar.gz' user1
    su -c 'tar xzvf postgresql-12.0.tar.gz' user1
    cd postgresql-12.0
    su -c './configure --with-openssl --with-libxml --with-libxslt --with-perl --with-python --prefix=/usr/local/pgsql' user1
    su -c 'make world' user1
    su -c 'make check' user1
    make install-world

    rm -r /usr/local/src/*
    chown root /usr/local/src
    userdel user1
