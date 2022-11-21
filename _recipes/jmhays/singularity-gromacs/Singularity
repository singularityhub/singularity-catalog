Bootstrap: docker
From: nvidia/cuda:8.0-devel-ubuntu16.04 


%environment

    # use bash as default shell
    SHELL=/bin/bash

    PATH=/usr/local/gromacs/bin:${PATH}    

    export PATH


%labels

   AUTHOR jmh5sf@virginia.edu


%post

    apt-get update && apt-get -y install libopenmpi-dev libfftw3-dev cmake make git locales

    mkdir /builds
    cd /builds

    # gromacs-gmxapi
    git clone https://github.com/gromacs/gromacs.git
    cd gromacs
    git checkout release-2019
    mkdir build
    cd build
    cmake ../ -DGMX_MPI=OFF -DGMX_GPU=ON -DGMX_OPENMP=ON -DGMX_USE_NVML=OFF -DGMXAPI=ON
    make -j8; make install
    cd /builds
