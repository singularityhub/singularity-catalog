Bootstrap: docker
From: ubuntu

%setup
    REPO_ROOT=`dirname $SINGULARITY_BUILDDEF`
    cp -r $REPO_ROOT/ $SINGULARITY_ROOTFS/pplanner

%post
    apt update && apt -y install \
    cmake \
    g++ \
    make \
    libboost-all-dev \
    wget \
    unzip \
    libjemalloc-dev \
    && apt clean

    wget https://download.open-mpi.org/release/open-mpi/v3.1/openmpi-3.1.1.tar.bz2
    tar xvf openmpi-3.1.1.tar.bz2
    cd openmpi-3.1.1
    ./configure --prefix=/usr/local
    make
    make install

    cd /pplanner/lib
    wget http://www.tcs.hut.fi/Software/bliss/bliss-0.73.zip
    unzip bliss-0.73.zip
    mv bliss-0.73 bliss
    cd /pplanner/lib/bliss
    make

    cd /pplanner/build
    cmake ..
    make planner
    make mpi_planner
