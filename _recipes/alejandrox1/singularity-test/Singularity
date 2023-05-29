Bootstrap: docker
From: ubuntu:18.04

%labels
    AUTHOR alarcj137@gmail.com
    VERSION v1.0

%help
    Singularity test - running a containarized MPI executable.

%files
    ./mpi_hello_world.c
    ./Makefile

%post
    mkdir -p /tmp/git
    cd /tmp/git
    apt-get update -y && apt-get install -y git build-essential autoconf libtool-bin flex
    [ -d ompi ] && rm -rf ompi
    git clone https://github.com/open-mpi/ompi.git
    cd ompi
    ./autogen.pl
    ./configure --prefix=/usr/local
    make -j 10
    make install
    ldconfig

    /usr/local/bin/mpicc examples/ring_c.c -o /usr/bin/mpi_ring

%test
    /usr/local/bin/mpirun --allow-run-as-root /usr/bin/mpi_ring

%environment
    # export PATH="$PATH:$PWD"

%runscript
    cat /etc/*release
    cd src/
    make
    cd ../
    cp src/mpi_hello_world /usr/bin/
    exec /usr/local/bin/mpirun --version
