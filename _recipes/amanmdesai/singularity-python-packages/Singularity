BootStrap: docker
From: ubuntu:20.04

%post
    apt-get update -y
    apt-get install wget -y
    export DEBIAN_FRONTEND=noninteractive
    apt-get install dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev \
    libxft-dev libxext-dev python3 libssl-dev libgsl0-dev libtiff-dev \
    python3-pip -y
    pip3 install numpy
    pip3 install awkward
    pip3 install uproot4
    pip3 install particle
    pip3 install hepunits
    pip3 install matplotlib
    pip3 install hist
    pip3 install mplhep
    pip3 install vector
    pip3 install fastjet
    pip3 install iminuit
