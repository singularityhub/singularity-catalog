Bootstrap: docker
From: ubuntu:16.04

%labels
Maintainer Phelelani.Mpangase@wits.ac.za
    
%post
## Updates and essentials
apt-get update
apt-get install -y build-essential
apt-get install -y software-properties-common
apt-get update

## Other essentials
apt-get install -y wget git zlib1g-dev unzip

## Install STAR Aligner
## From Source: https://github.com/alexdobin/STAR
cd /opt \
    && git clone https://github.com/alexdobin/STAR.git \
    && cd STAR/source \
    && make STAR

%environment
## Add paths to environment
export PATH=/opt/STAR/source:$PATH
