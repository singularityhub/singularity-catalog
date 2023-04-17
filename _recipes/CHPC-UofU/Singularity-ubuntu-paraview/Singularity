# Defines a Singularity container with paraview
#



BootStrap: docker
From: ubuntu:16.10
#Include: rpm2cpio


%runscript


%setup
    # Runs from outside the container during Bootstrap



%post
    # Runs within the container during Bootstrap


    # Install the necessary packages (from repo)
    apt-get update && apt-get install -y --no-install-recommends \
        apt-utils \
        build-essential \
        curl \
        git \
        libopenblas-dev \
        libcurl4-openssl-dev \
        libfreetype6-dev \
        libpng-dev \
        libzmq3-dev \
        python-pip \
        pkg-config \
        python-dev \
        python-setuptools \
        rsync \
        software-properties-common \
        unzip \
        vim \
        zip \
        zlib1g-dev
    apt-get clean

    # Set up some required environment defaults
    #MC issue with locale (LC_ALL, LANGUAGE), to get it right:
    apt-get install -y language-pack-en
    locale-gen "en_US.UTF-8"
    dpkg-reconfigure locales
    export LANGUAGE="en_US.UTF-8"
    echo 'LANGUAGE="en_US.UTF-8"' >> /etc/default/locale
    echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale

    # Update to the latest pip (newer than repo)
    pip install --no-cache-dir --upgrade pip
    
    # Install other commonly-needed packages
    pip install --no-cache-dir --upgrade \
        future \
        matplotlib \
        scipy 

    #for OpenBLAS accelerated Python3 NumPy, install through pip3
    apt-get install -y python3-pip
    pip3 install --no-cache-dir --upgrade pip
    pip3 install --no-cache-dir --upgrade future matplotlib scipy

    # need to create mount point for home dir
    mkdir /uufs
    mkdir /scratch

    # git, wget
    apt-get install -y git wget

    apt-get install -y paraview  paraview-dev  paraview-python

    # LMod
    apt-get install -y liblua5.1-0 liblua5.1-0-dev lua-filesystem-dev lua-filesystem lua-posix-dev lua-posix lua5.1 tcl tcl-dev lua-term lua-term-dev lua-json

    echo "
if [ -f /uufs/chpc.utah.edu/sys/etc/profile.d/module.sh ]
then
   . /uufs/chpc.utah.edu/sys/etc/profile.d/module.sh
fi
   " > /etc/profile.d/91-chpc.sh

    echo "
. /etc/profile.d/91-chpc.sh
" >> /etc/bash.bashrc

%test
    # Sanity check that the container is operating
    python -c "from paraview.simple import *"
    # this runs a demo that launches another window
    # paraview.simple.demo1()
    

