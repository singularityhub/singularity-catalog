Bootstrap: docker
From: debian:latest

%labels
    AUTHOR icaoberg
    MAINTAINER icaoberg@psc.edu
    WEBSITE http://github.com/icaoberg/singularity-gent
    COPYRIGHT Copyright © 2021 Pittsburgh Supercomputing Center. All Rights Reserved. 
    VERSION 1.0.0

%post
    apt update
    apt install -y gnuplot gfortran git
    git clone https://github.com/ropelews/GeNT.git
    cd GeNT && gfortran -o gent gent.for && \
         cp gent /usr/local/bin && \
         cp gnuplot.script /usr/local/bin
    cd .. && rm -rfv GeNT
