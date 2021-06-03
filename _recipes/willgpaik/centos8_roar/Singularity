BootStrap: docker
From: centos:8

%setup

%files

%environment
    export BOOST_ROOT=/usr/local/
    
%runscript

%post
    dnf install -y epel-release
    dnf install -y dnf-plugins-core
    dnf config-manager --set-enabled powertools
    dnf group install -y "Development Tools"
    dnf group install -y "Base"
    dnf install -y vim \
            git \
            cmake \
            gcc \
            gcc-c++ \
            gcc-gfortran \
            python2-devel \
            python2-pip \
            python38-devel \
            python38-pip \
            patch \
            openssl-devel \
            pcre-devel \
            mesa-libGL-devel \
            mesa-libGLU-devel \
            glibc-devel \
            Lmod \
            qt5-qtbase-devel \
            qt5-qtcharts-devel \
            qt5-qtsvg-devel \
            qt5-qtx11extras-devel \
            libX11-devel \
            libXpm-devel \
            libXft-devel \
            libXext-devel \
            gsl-devel \
            hdf5-devel \
            bzip2-devel \
            zlib-devel \
            libcurl-devel \
            ca-certificates \
            autoconf \
            tix \
            tk-devel \
            python2-tkinter \
            python38-tkinter \
            libxkbcommon-devel \
            libxkbcommon-x11 \
            readline-devel
    dnf -y install tix-devel python3-tkinter python38-tkinter \
            libxkbcommon-devel libxkbcommon-x11-devel \
            lapack-devel \
            blas-devel \
            openblas-devel \
            netcdf-devel \
            atlas-devel \
            libX11-devel \
            libXt-devel \
            xorg-x11-server-devel \
            xorg-x11-drv-evdev-devel \
            xz-devel
    dnf -y update
    
    # Make python 3.8 as default
    ln -sf /usr/bin/python3.8 /usr/bin/python3
    ln -sf /usr/bin/pip3.8 /usr/bin/pip3
    
    # Install CMake 3.19.7
    cd /tmp
    wget https://github.com/Kitware/CMake/releases/download/v3.19.7/cmake-3.19.7.tar.gz
    tar -xf cmake-3.19.7.tar.gz
    cd cmake-3.19.7
    ./configure
    make -j 2 && make install
    cd ..
    rm -rf cmake-*
    
    # Install Boost 1.75.0
    cd /tmp/
    wget https://dl.bintray.com/boostorg/release/1.75.0/source/boost_1_75_0.tar.gz
    tar -xf boost_1_75_0.tar.gz
    cd boost_1_75_0
    ./bootstrap.sh
    ./b2 -j 2 install
    cd ..
    rm -rf boost_*
    
    # Install R 4.0.4
    cd /tmp
    wget https://cran.r-project.org/src/base/R-4/R-4.0.4.tar.gz
    tar -xf R-4.0.4.tar.gz
    cd R-4.0.4
    ./configure
    make -j 2 && make install
    cd ..
    rm -rf R-*
    
