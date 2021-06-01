# Copyright (c) 2015-2016, Gregory M. Kurtzer. All rights reserved.
#
# "Singularity" Copyright (c) 2016, The Regents of the University of California,
# through Lawrence Berkeley National Laboratory (subject to receipt of any
# required approvals from the U.S. Dept. of Energy).  All rights reserved.

Bootstrap: docker
From: ubuntu:20.04

%environment
    LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
	PATH=$PATH:/opt/anaconda3/bin
	export PATH LD_LIBRARY_PATH


%runscript
    echo "This is what happens when you run the container..."


%post
	apt-get -y update
	apt-get -y upgrade

	# Noninteractive install of tzdata	
	# https://stackoverflow.com/questions/44331836/apt-get-install-tzdata-noninteractive
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

    # misc tools
	apt install -y ncdu             #  ncurses ディスク利用状況ビューア
    apt install -y task-spooler     # personal job scheduler
    apt install -y sysstat          # system performance tools for Linux
    apt install -y tree 
    apt install -y sl
	apt install -y cowsay
	apt install -y git bzip2 pigz


    # network_tools
	apt install -y  openssh-client
    apt install -y  cadaver
    apt install -y  ntp 
    apt install -y  lftp  
    apt install -y  wget 
    apt install -y  curl
	apt install -y  net-tools

    # Emacs
    apt install -y emacs 
	apt install -y emacs-goodies-el


	# C
	apt install -y  build-essential
	apt install -y  gcc   
	apt install -y  gfortran  
	apt install -y  g++  
	apt install -y  cmake  
	apt install -y  dh-autoreconf  
	apt install -y  libarchive-dev  
    apt install -y  libc6-i386         
    apt install -y  libpng-dev
    apt install -y  netpbm             
    apt install -y  libnetpbm10   
    apt install -y  libnetpbm10-dev   
    apt install -y  flex  
	apt install -y  bison


	
	# Java
	apt install -y  openjdk-14-jdk  
	apt install -y  maven 


	# Python
	apt install -y  python3-dev

    # node.js
	curl -sL https://deb.nodesource.com/setup_14.x | bash -
    apt install -y  nodejs


    # R
	#apt install -y r-base
    ## all CRAN packages
    #apt search r-cran | grep ^r-cran | perl -ne 'if ($_ =~ /^([a-z-]+)\//) {print $1, "\n"}' | xargs -L 1 apt -y install	

	apt-get install -y git wget build-essential unzip graphviz
	apt-get install -y libgraphviz-dev pkg-config swig libx11-dev libgsl0-dev
	apt-get install -y libopenblas-dev liblapacke-dev
	apt-get install -y gfortran libreadline-dev libxt-dev libbz2-dev liblzma-dev libpcre2-dev libpcre3-dev
	apt-get install -y libcurl4-nss-dev libiconv-hook-dev

	# Install PCRE (Perl-compatible regular expression library)
	wget https://ftp.pcre.org/pub/pcre/pcre2-10.36.tar.gz
	tar zxvf pcre2-10.36.tar.gz
	cd pcre2-10.36
	./configure
	make -j 4
	make install

	# Install R from source.
	R_VERSION=4.0.5
	R_MAJOR=4
	
	if [ -e R-${R_VERSION}.tar.gz ]; then
		echo "R-${R_VERSION}.tar.gz already exists."
	else
		wget https://cran.ism.ac.jp/src/base/R-${R_MAJOR}/R-${R_VERSION}.tar.gz
	fi
	tar xzvf R-${R_VERSION}.tar.gz
	cd R-${R_VERSION}
	
	./configure --x-includes=/usr/include/X11 --x-libraries=/usr/lib/X11 --enable-R-shlib
	make -j 4
	make install



    # misc tools
	apt install -y ncdu             #  ncurses ディスク利用状況ビューア
    apt install -y sysstat          # system performance tools for Linux
    apt install -y tree 
    apt install -y sl
	apt install -y cowsay
	apt install -y git

    apt install -y cwltool

    apt install -y fio
	apt install -y dbench
	apt install -y hpcc

    apt install -y stress
	apt install -y sysbench


	

    # install tools from tarballs.

    ## installing iperf3 ver3.6
	wget https://downloads.es.net/pub/iperf/iperf-3.6.tar.gz
	tar zxvf iperf-3.6.tar.gz
	cd iperf-3.6
	./configure
	make
	make install


    # 
    mkdir /home/geadmin

