Bootstrap: docker
From: ubuntu:16.04

%runscript
    bash

%environment
    export PATH=/prerequisites/bin:${PATH}
    export LD_LIBRARY_PATH=/prerequisites/lib:${LD_LIBRARY_PATH}
    export PYTHONPATH=/prerequisites/python2.7/site-packages:/ism/amuse-11.2/test:/ism/amuse-11.2/src:/ism/ismcpak:${PYTHONPATH}
    export AMUSE_DIR=/ism/amuse-11.2

%post
    apt-get update
    apt-get install -y --no-install-recommends locales
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen en_US.utf8
    /usr/sbin/update-locale LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8

    export DEBIAN_FRONTEND=noninteractive
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
    apt-get install -y tzdata
    dpkg-reconfigure --frontend noninteractive tzdata

    apt-get install -y wget bzip2 zip
    apt-get -y install emacs vim
    apt-get -y install build-essential checkinstall
    apt-get install -y \
         libreadline-gplv2-dev \
         libncursesw5-dev \
         libssl-dev \
         libsqlite3-dev \
         tk-dev \
         libgdbm-dev \
         libc6-dev \
         libbz2-dev

    mkdir -p /prerequisites/install

    ## download and install python
    cd /prerequisites/install
    wget https://www.python.org/ftp/python/2.7.15/Python-2.7.15.tgz
    tar -xzvf Python-2.7.15.tgz
    cd Python-2.7.15
    ./configure --prefix=/prerequisites --enable-shared  --enable-unicode=ucs4
    make -j8
    make install
    rm -fr Python-2.7.15

    export PATH=/prerequisites/bin:${PATH}
    export LD_LIBRARY_PATH=/prerequisites/lib:${LD_LIBRARY_PATH}
    export AMUSE_DIR=/ism/amuse-11.2

    ## download and install easy_install, pip, pipenv
    cd /prerequisites/install
    wget https://files.pythonhosted.org/packages/c2/f7/c7b501b783e5a74cf1768bc174ee4fb0a8a6ee5af6afa92274ff964703e0/setuptools-40.8.0.zip
    unzip setuptools-40.8.0.zip
    cd setuptools-40.8.0
    python setup.py install
    easy_install pip==19.0.2
    pip install pipenv==2018.11.26
    cd /

    rm -fr /prerequisites/install/*

    ## install the amuse prerequisites
    apt-get install -y \
         git \
         curl \
         gfortran \
         mpich \
         libmpich-dev \
         libgsl-dev \
         cmake \
         libfftw3-3 \
         libfftw3-dev \
         libgmp3-dev \
         libmpfr4 \
         libmpfr-dev \
         libhdf5-serial-dev \
         hdf5-tools \
         gettext

    apt-get clean

    # pdbpp was causing a py2.7 issue when installed with all the other
    # python packages below, this solved the issue and it was installed
    # properly
    pip install setuptools-scm==1.17.0 
    pip install pdbpp==0.10.2
    pip install \
      nose==1.3.7 \
      scipy==1.2.2 \
      numpy==1.16.1 \
      docutils==0.14 \
      h5py==2.9.0 \
      mpi4py==3.0.0 \
      cython==0.29.5 \
      ipython==5.8.0 \
      matplotlib==2.2.3 \
      qtconsole==4.5.5 \
      pyrsistent==0.15.4 \
      jupyter==1.0.0 \
      jupyter-client==5.3.1 \
      jupyter-console==5.2.0 \
      jupyter-core==4.4.0 \
      jupyterlab==0.33.12 \
      jupyterlab-launcher==0.11.2

    ## download and configure and build amuse
    mkdir /ism
    chmod 777 /ism
    cd /ism
    wget https://github.com/amusecode/amuse/archive/release-11.2.tar.gz -O amuse-11.2.tar.gz
    tar -xzvf amuse-11.2.tar.gz
    mv amuse-release-11.2 amuse-11.2 
    rm -f amuse-11.2.tar.gz
    cd amuse-11.2
    ./configure
    make clean
    make

    ## download the ismcpak project
    cd /ism
    git clone https://github.com/mherkazandjian/ismcpak.git
    cd ismcpak
    git checkout alpha-master
    cd ..
    ln -s $PWD/ismcpak/oneSided $PWD/amuse-11.2/src/amuse/community/pdr
    cd /ism/amuse-11.2/src/amuse/community/pdr
    make all
    cd /ism/ismcpak/radex/Radex/src && make

    ## setup the dirs for a first quick run
    mkdir -p /ism/runs/tests/oneSided/single_mesh/meshes

    ## to test the build/config
    # cd /ism/ismcpak/tests
    # mpiexec python run_singleMesh.py
