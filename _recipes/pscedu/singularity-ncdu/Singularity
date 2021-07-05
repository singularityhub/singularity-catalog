Bootstrap: docker
From: alpine:edge

%labels
    AUTHOR icaoberg
    MAINTAINER icaoberg@psc.edu
    WEBSITE http://www.andrew.cmu.edu/~icaoberg
    VERSION 1.13

####################################################################################
%appinstall ncdu
    apk update
    apk add ncdu

%apphelp ncdu
    ncdu --help

%apprun ncdu
    ncdu "$@"
