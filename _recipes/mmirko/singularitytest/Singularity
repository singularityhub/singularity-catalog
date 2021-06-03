Bootstrap: docker
From: amd64/centos:7

%post
    yum update -y && \
    	yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    
    yum group install -y "Development Tools"

    yum update -y && \
    	yum -y install \
	    wget \
	    openssh-clients \
	    openssl \
	    glibc-devel \
	    glibc-static \
	    git \
	    bash \
	    centos-release-scl\

    yum update -y && \
    	yum -y install \
	    devtoolset-7 \


%files

%environment
    export LC_ALL=C
    export PATH=/usr/games:$PATH

%runscript
    /bin/bash

