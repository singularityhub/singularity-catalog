Bootstrap: docker
From: vcatechnology/linux-mint

%post
    export DEBIAN_FRONTEND=noninteractive
    apt-get update && apt-get -y dist-upgrade
    apt-get -y install subversion
    apt-get install -y openmpi-bin libmpich-dev libopenmpi-dev lam4-dev gcc g++ gfortran m4 vim
    apt-get install -y build-essential
    apt-get install -y libcurl4-openssl-dev
    ln -s /usr/bin/make /usr/bin/gmake
    apt-get install -y git
    unset DEBIAN_FRONTEND

    mkdir /nemo
    cd /nemo
    git clone https://github.com/swarder/NEMO-AMM7-recipe.git installations
    cd installations/install_scripts
    ./install_zlib.sh
    ./install_hdf5.sh
    ./install_netcdf-c.sh
    ./install_netcdf-fortran.sh
    ./install_xios.sh

%environment
    export LC_ALL=C.UTF-8

%labels
    Author Simon Warder
