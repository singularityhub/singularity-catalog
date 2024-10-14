# Copyright (c) 2015-2016, Gregory M. Kurtzer. All rights reserved.
#
# "Singularity" Copyright (c) 2016, The Regents of the University of California,
# through Lawrence Berkeley National Laboratory (subject to receipt of any
# required approvals from the U.S. Dept. of Energy).  All rights reserved.

BootStrap: debootstrap
OSVersion: bionic
MirrorURL: http://us.archive.ubuntu.com/ubuntu/


%environment
    LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
	PATH=$PATH:/opt/anaconda3/bin
	export PATH LD_LIBRARY_PATH


%runscript
    echo "This is what happens when you run the container..."


%post
    echo "Hello from inside the container"
    sed -i 's/$/ universe/' /etc/apt/sources.list
	apt-get update


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
	apt install -y  openjdk-11-jdk  
	apt install -y  maven 


	# Python
	apt install -y  python-dev  
	apt install -y  python3-dev
    wget https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh
    bash Anaconda3-2019.10-Linux-x86_64.sh -b -p /opt/anaconda3



    # node.js
    curl -sL https://deb.nodesource.com/setup_10.x | bash -
    apt install -y  nodejs


    # R
	apt install -y r-base
    ## all CRAN packages
    apt search r-cran | grep ^r-cran | perl -ne 'if ($_ =~ /^([a-z-]+)\//) {print $1, "\n"}' | xargs -L 1 apt -y install	



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
	apt install -y namebench

	apt install -y phoronix-test-suite

    apt install -y stress
	apt install -y sysbench
	apt install -y ubuntu-benchmark-tools

	

    # install tools from tarballs.

    ## installing iperf3 ver3.6
	wget https://downloads.es.net/pub/iperf/iperf-3.6.tar.gz
	tar zxvf iperf-3.6.tar.gz
	cd iperf-3.6
	./configure
	make
	make install


