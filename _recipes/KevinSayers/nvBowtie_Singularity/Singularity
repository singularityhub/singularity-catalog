BootStrap: docker
From: nvidia/cuda:8.0-devel

%post
    apt-get update
    apt-get -y install wget build-essential zlib1g-dev
    wget http://www.cmake.org/files/v3.2/cmake-3.2.2.tar.gz
    tar xf cmake-3.2.2.tar.gz
    cd cmake-3.2.2
    ./configure
    make install
    wget https://github.com/NVlabs/nvbio/archive/v1.1.00.tar.gz
    tar -xvf v1.1.00.tar.gz 
    cd nvbio-1.1.00/
    mkdir build
    cd build/
    cmake ..
    cd nvBowtie/
    make
    mv nvBowtie /usr/local/bin/nvBowtie
    cd ../nvBWT
    make
    mv nvBWT /usr/local/bin/nvBWT
