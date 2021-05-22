BootStrap: docker
From: nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

%labels
  maintainer Miguel Carcamo <miguel.carcamo@postgrad.manchester.ac.uk>
  package.name
  package.version 1.0
  package.homepage
  package.source.url
  package.source.mdm5
  package.license GPLv3
%environment
    SHELL=/bin/bash
    TMPDIR=/raid/scratch/carcamo/tmp
    CUDA_HOME=/usr/local/cuda-10.0
    PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
    LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/lib:/usr/local/lib:$LD_LIBRARY_PATH
    export PATH LD_LIBRARY_PATH CUDA_HOME TMPDIR
%post
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt bionic main restricted universe multiverse" > /etc/apt/sources.list
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt bionic-security main restricted universe multiverse" >> /etc/apt/sources.list 
    apt-get update
    apt-get -y install software-properties-common
    add-apt-repository main
    add-apt-repository universe
    add-apt-repository restricted
    add-apt-repository multiverse
    apt-get update
    apt-get -y install man
    apt-get -y install vim
    apt-get -y install autoconf
    apt-get -y install libtool
    apt-get -y install automake
    apt-get -y install libboost-all-dev
    apt-get -y install apt-utils
    apt-get -y install udev
    apt-get -y install python2.7
    apt-get -y install python-pip
    apt-get -y install python3.6
    apt-get -y install python3-pip
    apt-get -y install python3-tk
    apt-get -y install python-tk
    apt-get -y install git
    apt-get -y install ffmpeg
    pip3 install numpy
    pip3 install matplotlib
    pip3 install cython
    pip3 install pyfits
    pip3 install pywcs
    pip3 install astropy
    pip3 install PyWavelets
    pip3 install scipy
    pip3 install toolz
    pip3 install dask
    pip3 install astropy_helpers
    pip3 install https://github.com/keflavich/gaussfitter/archive/master.zip
    apt-get -y install curl
    apt-get -y install cmake
    apt-get -y install gfortran
    apt-get -y install g++
    apt-get -y install libncurses5-dev
    apt-get -y install libreadline-dev
    apt-get -y install flex
    apt-get -y install bison
    apt-get -y install libblas-dev
    apt-get -y install liblapacke-dev
    apt-get -y install libcfitsio-dev
    apt-get -y install wcslib-dev
    apt-get -y install libhdf5-serial-dev
    apt-get -y install libfftw3-dev
    apt-get -y install python-numpy
    apt-get -y install libboost-python-dev
    apt-get -y install libpython3.6-dev
    apt-get -y install libpython2.7-dev
    apt-get -y install htop
    apt-get -y install saods9
    apt-get -y install xorg
%runscript
   
