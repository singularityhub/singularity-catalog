Bootstrap: docker
From: ubuntu:18.04

%labels
MAINTAINER darachm

%help

    This container is for providing `bartender` for some bioinformatic pipelines.
    
%post

    apt-get -y update
    apt-get -y update
    apt-get -y install python3 python3-biopython python3-pip
    apt-get -y install gcc-4.8 git make g++ python
    pip3 install regex numpy pandas jellyfish
    git clone https://github.com/LaoZZZZZ/bartender-1.1.git
    cd bartender-1.1
    make all
    make install

%test

    /usr/bin/python3 -V


