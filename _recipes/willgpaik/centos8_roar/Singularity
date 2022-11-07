BootStrap: docker
From: rockylinux:8

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
    dnf -y update
    dnf install -y vim \
            git \
            cmake \
            gcc \
            gcc-c++ \
            gcc-gfortran \
            python2-devel \
            python2-pip \
            python39-devel \
            python39-pip \
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
            python39-tkinter \
            libxkbcommon-devel \
            libxkbcommon-x11 \
            readline-devel \
            libnsl \
            libnsl2-devel
    dnf -y install tix-devel python3-tkinter python39-tkinter \
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
            xz-devel \
            R-devel
    dnf -y update
    
    # Make python 3.9 as default
    ln -sf /usr/bin/python3.9 /usr/bin/python3
    ln -sf /usr/bin/pip3.9 /usr/bin/pip3
    
    
    # Install Boost 1.80.0
    cd /tmp/
    wget https://boostorg.jfrog.io/artifactory/main/release/1.80.0/source/boost_1_80_0.tar.gz
    tar -xf boost_1_80_0.tar.gz
    cd boost_1_80_0
    ./bootstrap.sh
    ./b2 -j 2 install
    cd ..
    rm -rf boost_*
    

    
