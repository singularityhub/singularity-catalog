BootStrap: docker
From: ubuntu:14.04


%runscript
    echo "This is what happens when you run the container..."


%post
    echo "Hello from inside the container"
    apt-get update
    apt-get -y install vim git make gcc g++ gfortran cmake \
               libboost-all-dev libhdf5-serial-dev \
               gsl-bin libgsl0-dbg libgsl0-dev libgsl0ldbl \
               python3 python3-h5py python3-numpy python3-scipy python3-pip
    pip3 install fortranformat 
    apt-get clean

    # create bind point for additional storage
    mkdir /scratch
    cd /scratch
    git clone --recursive https://github.com/Yingru/hic_HQ-osg.git
    cd hic_HQ-osg/
    git checkout container
    git submodule update 
    bash makepkg


    cp hic_HQ-osg.tar.gz /var
    cd /var
    tar -xzf hic_HQ-osg.tar.gz 
    cd hic_HQ-osg/    

    echo "now everything is done!"
    ls -l

    # for some reason, need to setlocale
    echo "LC_ALL=en_US.UTF-8" >> /etc/environment
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
    locale-gen en_US.UTF-8
