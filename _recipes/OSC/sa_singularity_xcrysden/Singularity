BootStrap: docker
From: ubuntu:18.04

%labels
    Maintainer zyou@osc.edu
    Recipe https://github.com/OSC/sa_singularity_xcrysden

%help

    Container with pre-built XCrysDen for Ubuntu 18.04

%environment
    export PATH=$PATH:/usr/local/xcrysden/1.6.2

%post
    apt update
    apt upgrade -y
    DEBIAN_FRONTEND=noninteractive apt install -y \
	wget tk libglu1-mesa libtogl2 libfftw3-3 libxmu6 imagemagick openbabel libgfortran5
    wget http://www.xcrysden.org/download/xcrysden-1.6.2-linux_x86_64-shared.tar.gz 
    mkdir -p /usr/local/xcrysden/1.6.2
    tar xf xcrysden-1.6.2-linux_x86_64-shared.tar.gz -C /usr/local/xcrysden/1.6.2 --strip=1
    rm -f xcrysden-1.6.2-linux_x86_64-shared.tar.gz 
    apt autoclean
    apt autoremove --purge -y
    rm -rf /var/lib/apt/lists/*

%runscript
    exec xcrysden "$@"
