# Defines a base Ubuntu 16 Singularity container with basic Python packages
# uses pip to install numpy so it detects and takes advantage of OpenBLAS
# OpenBLAS is optimized for multiple CPU archs, on par with MKL for SSE and AVX 
# and about 30% slower for AVX2


# bootstraping from docker image is faster and includes more dependencies
BootStrap: docker
From: ubuntu:16.04

# alternatively we can bootstrap directly from the repo, but installation will be longer
#BootStrap: debootstrap
#OSVersion: xenial
#MirrorURL: http://us.archive.ubuntu.com/ubuntu/
#Include: rpm2cpio


%runscript
    echo "Arguments received: $*"
    #sv "$@"

%setup
    # Runs from outside the container during Bootstrap
    # for example how to use this section see
    # https://github.com/mcuma/chpc_singularity/blob/master/tensorflow/ubuntu16-tensorflow-1.0.1-gpu.def
    working_dir=$(pwd)
    pwd
    ls /uufs/chpc.utah.edu/common/home/u0101881/containers/singularity/containers/chpc/Singularity-ubuntu-samviewer
    mkdir -p ${SINGULARITY_ROOTFS}/opt/sam
    cd ${SINGULARITY_ROOTFS}/opt/sam
    cp /${working_dir}/sam_all_150904.tar ${SINGULARITY_ROOTFS}/opt/sam
    tar xf ${SINGULARITY_ROOTFS}/opt/sam/sam_all_150904.tar
    # copy hand modified SamViewer files to the container
    cp -r /${working_dir}/mod ${SINGULARITY_ROOTFS}/opt/sam

%post
    # Runs within the container during Bootstrap
    env
    env | grep proxy | true

    # Install the commonly used packages (from repo)
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
        locales \
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
    locale-gen en_US.UTF-8
   # dpkg-reconfigure locales 
   # export LANGUAGE="en_US.UTF-8"
   # echo 'LANGUAGE="en_US.UTF-8"' >> /etc/default/locale
   # echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale

    # Update to the latest pip (newer than repo)
    pip install --no-cache-dir --upgrade pip
    
    # Install other commonly-needed python packages
    pip install --no-cache-dir --upgrade \
        future \
        matplotlib \
        scipy 

    #for OpenBLAS accelerated Python3 NumPy, install through pip3
  # apt-get install -y python3-pip
  # pip3 install --no-cache-dir --upgrade pip
  # pip3 install --no-cache-dir --upgrade pip
  # pip3 install --no-cache-dir --upgrade future matplotlib scipy

    # need to create mount point for home dir
    mkdir /uufs
    mkdir /scratch

    # git, wget
    apt-get install -y git wget
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

# Samviewer
    apt-get install -y xorg openbox
    apt-get install -y python-wxgtk3.0 python-pil python-imaging
    cd /opt
    wget http://liao.hms.harvard.edu/sites/liao.hms.harvard.edu/files/attached/files/samviewer_v15.01.tar
    tar xf samviewer_v15.01.tar

# Need to also add these plugins to PIL, see
# https://liao.hms.harvard.edu/samviewer
    cp /opt/samviewer/Dm3ImagePlugin.py /opt/samviewer/dm3lib_v099.py /opt/samviewer/MrcImagePlugin.py /usr/lib/python2.7/dist-packages/PIL
# also modify /usr/lib/python2.7/dist-packages/PIL/__init__.py
    sed -i '/XbmImagePlugin/c\            '\''XbmImagePlugin'\'',\n            '\''Dm3ImagePlugin'\'',\n            '\''MrcImagePlugin'\'',' /usr/lib/python2.7/dist-packages/PIL/__init__.py 

# copy hand modified files to samviewer dir - "fixed" issues with newer wxPython version
    cp /opt/sam/mod/* /opt/samviewer

%environment
PATH=/opt/samviewer:/opt/sam/sam/bin:$PATH
LD_LIBRARY_PATH=/opt/sam/sam/lib:$LD_LIBRARY_PATH

%test
    # Sanity check that the container is operating
    # make sure that numpy is using openblas
    /usr/bin/python -c "import numpy as np;np.__config__.show()"
