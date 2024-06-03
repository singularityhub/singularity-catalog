BootStrap: library
From: ubuntu:20.04

%post
    apt-get install -y software-properties-common
    add-apt-repository universe
    apt-get update -y
    apt-get install -y texlive texlive-fonts-extra

%environment
    export LC_ALL=C

%runscript
    pdflatex $@

%labels
    Author radovan.bast@uit.no
