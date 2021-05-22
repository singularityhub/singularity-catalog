Bootstrap: docker
From: nvidia/cuda:7.5-cudnn5-devel-ubuntu14.04

%post

    # Update list of available packages, then upgrade them
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
    
    # Caffe dependencies  
    apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev \
        libhdf5-serial-dev protobuf-compiler
    apt-get install --no-install-recommends -y libboost-all-dev
    apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev

    #Neuro_Imaging
    pip install nibabel
    pip install niftynet
