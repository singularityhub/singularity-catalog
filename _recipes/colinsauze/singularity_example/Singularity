Bootstrap: docker
From:ubuntu:18.04

%help
    Example container for Cowsay

%labels
    MAINTAINER Colin Sauze

%environment
    export LC_ALL=C
    export PATH=/usr/games:$PATH
    
%post  
    apt-get update
    apt-get -y install cowsay

%runscript
    cowsay $@
