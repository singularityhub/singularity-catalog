Bootstrap: docker
From: ubuntu:16.04

%post
    # update package manager
    apt-get update
    
    # make sane environment
    apt-get install -qqy apt-utils build-essential pkg-config unzip git automake

    # htslib dependencies
    apt-get install -qqy zlib1g-dev liblzma-dev libbz2-dev libcurl4-gnutls-dev
    
    # create some scratch space to not overlap accidentally with home
    mkdir -p /scratch
    cd /scratch
	
    # install htslib
    git clone https://github.com/samtools/htslib.git
    cd /scratch/htslib
    autoheader
    autoconf
    ./configure --enable-libcurl
    make
    make install

    # gangstr dependencies
    apt-get install -qqy libtool-bin libnlopt-dev libgsl-dev

    # download, compile, and install GangSTR
    cd /scratch
    git clone https://github.com/gymreklab/GangSTR
    cd /scratch/GangSTR
    ./reconf
    ./configure
    make
    make install

    # create bind point to bind resources to
    cd /scratch
    mkdir -p bams ref regions results
