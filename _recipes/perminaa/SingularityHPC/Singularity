bootstrap: docker
From: debian:buster

%environment
    PATH="/opt/namd:/opt/vmd/bin:$PATH"
    LD_LIBRARY_PATH="/opt/vmd/lib"

%post
    apt update
    apt install -y wget make

    #Download and install R
    apt install -y r-base

    # Download and install namd
    mkdir -p /opt/namd
    wget -O /opt/namd/namd.tar.gz https://www.ks.uiuc.edu/Research/namd/2.14/download/946183/NAMD_2.14_Linux-x86_64-multicore.tar.gz
    cd /opt/namd
    tar xvzf namd.tar.gz
    rm namd.tar.gz
    mv NAMD_2.14_Linux-x86_64-multicore/* ./
    rmdir NAMD_2.14_Linux-x86_64-multicore

    # Download and install vmd
    mkdir -p /opt/vmd
    wget -O /opt/vmd/vmd.tar.gz https://www.ks.uiuc.edu/Research/vmd/vmd-1.9.3/files/final/vmd-1.9.3.bin.LINUXAMD64.text.tar.gz
    cd /opt/vmd
    tar xvzf vmd.tar.gz
    cd vmd-1.9.3
    sed 's|$install_bin_dir="/usr/local/bin";|$install_bin_dir="/opt/vmd/bin";|g' configure >configure.tmp
    sed 's|$install_library_dir="/usr/local/lib/$install_name";|$install_library_dir="/opt/vmd/lib";|g' configure.tmp >configure
    rm configure.tmp
    ./configure
    cd src
    make install
    cd ../../
    rm -rf vmd-1.9.3
