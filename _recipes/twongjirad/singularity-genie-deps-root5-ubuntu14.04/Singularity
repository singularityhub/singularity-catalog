Bootstrap: docker
From: ubuntu:14.04.5

%post
    apt-get update
    apt-get install git dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev libgsl0-dev gfortran libfftw3-dev libxml2-dev wget python
    mkdir /usr/local/share/pythia
    cd /usr/local/share/pythia
    wget https://genie.hepforge.org/trac/export/7080/generator/trunk/src/scripts/build/ext/build_pythia6.sh
    source build_pythia6.sh
    mkdir /usr/local/share/root
    mkdir /usr/local/share/root/build    
    cd /usr/local/share/root
    git clone https://github.com/root-project/root.git src
    cd /usr/local/share/root/src
    git checkout -b v5-34-36 v5-34-36
    cd /usr/local/share/root/build
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local -Dpythia6=ON -DPYTHIA6_LIBRARY=/usr/local/share/pythia/v6_428/lib/libPythia6.so /usr/local/share/root/src/
    make -j4
    make install -j4
    cd /usr/local/share
    wget https://sourceforge.net/projects/log4cpp/files/log4cpp-1.1.x%20%28new%29/log4cpp-1.1/log4cpp-1.1.2.tar.gz
    tar -zxvf log4cpp-1.1.2.tar.gz
    cd /usr/local/share/log4cpp
    ./configure
    make
    make install
    cd /usr/local/share
    wget http://www.hepforge.org/archive/lhapdf/lhapdf-5.9.1.tar.gz
    tar -zxvf lhapdf-5.9.1.tar.gz
    cd /usr/local/share/lhapdf-5.9.1
    ./configure
    make && make install
    rm -r /usr/local/share/root
    rm -r /usr/local/share/lhapdf-5.9.1
    rm -r /usr/local/share/log4cpp
    rm /usr/local/share/*.tar.gz