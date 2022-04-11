bootstrap:docker
From:nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

%environment

    LD_LIBRARY_PATH=/host-libs:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda-8.0/lib64
    export LD_LIBRARY_PATH
    PATH=/usr/local/cuda-8.0/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
    export PATH

%post

    apt-get update && apt-get upgrade -y --allow-unauthenticated
    
    export DEBIAN_FRONTEND=noninteractive && \
        apt-get install -y --allow-unauthenticated \
            build-essential \
            cmake \
            cuda-drivers \
            curl \
            git \
            libfreetype6-dev \
            libpng12-dev \
            libssl-dev \
            libxpm-dev \
            libzmq3-dev \
            module-init-tools \
            pkg-config \
            python \
            python-dev \
            python-tk \
            python3 \
            python3-dev \
            python3-tk \
            rsync \
            software-properties-common \
            unzip \
            zip \
            zlib1g-dev \
            openjdk-8-jdk \
            openjdk-8-jre-headless \
            vim \
            wget
    
    apt-get clean 
    rm -rf /var/lib/apt/lists/*
    
    # bazel is required for some TensorFlow projects
    echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" >/etc/apt/sources.list.d/bazel.list
    curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
    
    export DEBIAN_FRONTEND=noninteractive && \
        apt-get update && \
        apt-get install -y --allow-unauthenticated \
            bazel
    
    curl -O https://bootstrap.pypa.io/get-pip.py && \
        python get-pip.py && \
        rm get-pip.py
    
    pip --no-cache-dir install \
            h5py \
            ipykernel \
            jupyter \
            matplotlib \
            numpy \
            pandas \
            Pillow \
            scipy \
            sklearn
    
    python -m ipykernel.kernelspec
    
    echo "/usr/local/cuda-8.0/lib64/" >/etc/ld.so.conf.d/cuda.conf
    echo "/usr/local/cuda/extras/CUPTI/lib64/" >>/etc/ld.so.conf.d/cuda.conf
    
    # Install TensorFlow GPU version
    pip install --upgrade tensorflow-gpu
    
    # keras
    pip install --upgrade keras

    # tflearn 
    pip install --upgrade tflearn 
    
    #############################
    # now do the same for python3
    
    curl -O https://bootstrap.pypa.io/get-pip.py && \
        python3 get-pip.py && \
        rm get-pip.py
    
    pip3 --no-cache-dir install \
            h5py \
            ipykernel \
            jupyter \
            matplotlib \
            numpy \
            pandas \
            Pillow \
            scipy \
            sklearn
    
    python3 -m ipykernel.kernelspec
    
    # Install TensorFlow GPU version
    pip3 install --upgrade tensorflow-gpu
    
    # keras
    pip3 install --upgrade keras
    
    # keras
    pip3 install --upgrade tflearn 
    #############################
    
    # make sure we have a way to bind host provided libraries
    # see https://github.com/singularityware/singularity/issues/611
    mkdir -p /host-libs /etc/OpenCL/vendors
    echo "/host-libs/" >/etc/ld.so.conf.d/000-host-libs.conf

    # required directories
    mkdir -p /cvmfs
    
    # root
    cd /opt && \
        wget -nv https://root.cern.ch/download/root_v6.10.02.Linux-ubuntu16-x86_64-gcc5.4.tar.gz && \
        tar xzf root_v6.10.02.Linux-ubuntu16-x86_64-gcc5.4.tar.gz && \
        rm -f root_v6.10.02.Linux-ubuntu16-x86_64-gcc5.4.tar.gz

    # xrootd
    cd /opt && \
        wget http://xrootd.org/download/v4.7.1/xrootd-4.7.1.tar.gz && \
        tar xzf xrootd-4.7.1.tar.gz && \
        cd xrootd-4.7.1 && \
        mkdir build && \
        cd  build && \
        cmake /opt/xrootd-4.7.1 -DCMAKE_INSTALL_PREFIX=/opt/xrootd -DENABLE_PERL=FALSE && \
        make && \
        make install && \
        cd /opt && \
        rm -rf xrootd-4.7.1.tar.gz xrootd-4.7.1
    
    # stashcp
    cd /opt && \
        git clone https://github.com/opensciencegrid/StashCache.git
    
    # build info
    echo "Timestamp:" `date --utc` | tee /image-build-info.txt



