#minimap2 in singularity

Bootstrap: docker
From: ubuntu:16.04

%runscript
    /STAR/bin/Linux_x86_64/STAR "$@"

%post
    apt-get update
    apt-get --assume-yes install wget curl sudo apt-utils

    apt-get update
    apt-get -y install build-essential zlib1g-dev cmake git-core   
    
    #2018-10-18
    cd /
    git clone https://github.com/alexdobin/STAR.git
    cd STAR/source && make
    
    mkdir /groups
    mkdir /clustertmp
    mkdir /scratch
    mkdir /scratch-ii2

%environment
    PATH=/minimap2/minimap2/misc/:$PATH
    export PATH

%test
    /STAR/bin/Linux_x86_64/STAR -h
    
