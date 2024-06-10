
Bootstrap: docker
From: ubuntu:20.04

%environment
   export PATH=$PATH:/opt/CLASS-2.1.7

%labels
   MAINTAINER Arun Seetharam
   EMAIL arnstrm@iastate.edu

%post
   apt-get update
   apt-get install -y build-essential wget curl git autoconf automake
   apt-get install -y gcc g++ make
   apt-get install -y perl zlib1g-dev libbz2-dev liblzma-dev libcurl4-gnutls-dev libssl-dev libncurses5-dev
   cd /opt
   wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2
   tar xf samtools-1.10.tar.bz2
   cd samtools-1.10
   ./configure
   make
   make install
   cd /opt
   wget https://downloads.sourceforge.net/project/splicebox/CLASS-2.1.7.tar.gz
   tar xf CLASS-2.1.7.tar.gz
   cd CLASS-2.1.7
   sh build.sh
   make
#   make install
