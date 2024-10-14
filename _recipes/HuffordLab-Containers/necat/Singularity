Bootstrap: docker
From: ubuntu:16.04

%environment
   export PATH=$PATH:/opt/NECAT/Linux-amd64/bin

%labels
   Author Arun Seetharam
   Version v1
   Maintainer arnstrm@iastate.edu

%help
   This is a container for the NECAT

%test
   which necat.pl
   which pigz
   which ctgcns

%post
   apt-get update
   apt-get install -y build-essential wget curl git autoconf
   apt-get install -y gcc g++ make
   apt-get install -y zlib1g-dev libgomp1 libgomp1 libpam-systemd-
   apt-get install -y libcurl4-gnutls-dev libxml2-dev libssl-dev libbz2-dev
   apt-get install -y gfortran
   apt-get install -y perl python3 python3-pip 
# instll necat
   cd opt/
   git clone https://github.com/xiaochuanle/NECAT.git
   cd NECAT/src
   make
   cd ../Linux-amd64/bin

   

