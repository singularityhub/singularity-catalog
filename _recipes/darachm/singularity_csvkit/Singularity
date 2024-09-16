Bootstrap: docker
From: ubuntu:18.04

%labels
MAINTAINER darachm

%help

    This container is for providing `csvkit` for a nextflow pipeline.
    
%post

    apt -y update
    apt -y install csvkit

%test

    /usr/bin/in2csv -h


