Bootstrap: docker
From: ubuntu:20.04

%labels
MAINTAINER TRF

%files

%environment
    
%post
    apt-get update
    apt-get install locales
    locale-gen "en_US.UTF-8"
    dpkg-reconfigure locales
    apt-get install -y genometools libgenometools0 libgenometools0-dev
    
%runscript
