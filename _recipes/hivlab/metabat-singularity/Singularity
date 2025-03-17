Bootstrap: docker
From: ubuntu:18.04

%labels
  Maintainer tpall
  Version 0.1

%apprun runMetaBat.sh
    exec /usr/local/bin/runMetaBat.sh "${@}"

%runscript
    exec /usr/local/bin/runMetaBat.sh "${@}"

%post
    apt-get update && \
        apt-get install -y libgomp1 \
        build-essential \
        autoconf \
        libboost-all-dev \
        cmake \
        git \
        curl \
        libncurses5-dev \
        zlib1g-dev

    git clone https://tpall@bitbucket.org/berkeleylab/metabat.git && \
        cd metabat && \
        mkdir build && \
        cd build && \
        cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
        make -j8 && \
        make install && \
        cd .. && \
        rm -rf build
    
    apt-get autoremove -y && \
        apt-get clean && \
        apt-get autoclean && \
        rm -rf /var/lib/apt/lists/*
