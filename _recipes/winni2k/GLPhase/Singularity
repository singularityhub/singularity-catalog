BootStrap: library
From: ubuntu:18.04

%post
    NCPU=$(nproc)
    apt-get -y update
    apt-get install -y software-properties-common
    add-apt-repository -y universe
    apt-get -y update
    apt install -y git wget build-essential libboost-all-dev zlib1g-dev libbz2-dev liblzma-dev libhts-dev libgsl0-dev

    wget https://github.com/winni2k/GLPhase/releases/download/v1.7.1/GLPhase.tar.gz
    tar xf GLPhase.tar.gz
    cd GLPhase
    make -j $NCPU
    make test -j $NCPU
    
    ldd bin/glphase
    install bin/glphase /usr/local/bin
    cd -
    

%environment
    export LC_ALL=C

%runscript
    glphase

%labels
    Author winni@warrenwk.com
    Version 1.7.1-0

%help
    This is a container for running GLPhase <https://github.com/winni2k/GLPhase>.
    This container was built with OpenMP and without CUDA support.