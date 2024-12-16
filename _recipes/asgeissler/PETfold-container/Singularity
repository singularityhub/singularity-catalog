Bootstrap: docker
From: debian:bookworm


%post
    apt-get update -y

    export DEBIAN_FRONTEND=noninteractive
    export TZ=Etc/UTC
    apt-get -y install build-essential wget pkg-config tzdata \
        gfortran libblas-dev libblas3 liblapacke liblapacke-dev

    wget https://www.tbi.univie.ac.at/RNA/download/sourcecode/2_6_x/ViennaRNA-2.6.3.tar.gz
    tar -xf ViennaRNA-2.6.3.tar.gz
    cd ViennaRNA-2.6.3
    ./configure
    make
    make install
    cd ..
    rm ViennaRNA-2.6.3.tar.gz
    rm -rf ViennaRNA-2.6.3

    wget https://rth.dk/resources/petfold/download/PETfold2.2.tar.gz
    tar -xf PETfold2.2.tar.gz
    cd PETfold/src
    make
    cd ..
    cp -r bin /opt/PETfold
    cd ..

    chmod -R a+rx /opt/

    #rm -rf PETfold
    #rm PETfold2.2.tar.gz

%environment
    export LC_ALL=C
    export PATH=$PATH:/opt/PETfold
    export PETFOLDBIN=/opt/PETfold

%runscript
    exec /bin/bash "$@"

