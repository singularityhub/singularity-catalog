BootStrap: library
From: ubuntu:20.04

%post
    apt-get install -y software-properties-common
    add-apt-repository universe
    apt-get update -y
    apt-get install -y pandoc

%environment
    export LC_ALL=C

%runscript
    pandoc $@

%labels
    Author radovan.bast@uit.no
