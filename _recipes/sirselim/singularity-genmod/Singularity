Bootstrap: docker
From: ubuntu:18.04

%help
    This is a container for installing genmod version 3.7.3

%labels
    MAINTAINER Miles Benton
    VERSION 0.1

%environment
    export LC_ALL=C
    export PATH=/usr/games:$PATH

%post
    apt-get -y update
    apt-get -y install python-dev build-essential libssl-dev libffi-dev libxml2-dev libxslt1-dev zlib1g-dev python-pip
    pip install genmod
