Bootstrap: docker
From: nvidia/cuda:9.0-base-ubuntu16.04

%post
    apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        zlib1g-dev \
        libssl-dev \
        libbz2-dev \
        libreadline-dev \
        cuda-command-line-tools-9-0 \
        cuda-cublas-9-0 \
        cuda-cufft-9-0 \
        cuda-curand-9-0 \
        cuda-cusolver-9-0 \
        cuda-cusparse-9-0 \
        curl \
        libcudnn7=7.2.1.38-1+cuda9.0 \
        libnccl2=2.2.13-1+cuda9.0 \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python \
        python-dev \
        rsync \
        software-properties-common \
        unzip \
        git \
        openssl \
        ca-certificates \
        python3 \
        python3-pip \
        python3-setuptools \
        python3-dev \
        && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

    apt-get update && \
        apt-get install nvinfer-runtime-trt-repo-ubuntu1604-4.0.1-ga-cuda9.0 && \
        apt-get update && \
        apt-get install libnvinfer4=4.1.2-1+cuda9.0
    
    pip3 install -U setuptools
    pip3 --no-cache-dir install \
        wheel \
        Pillow \
        opencv-contrib-python==3.2.0.8 \
        h5py \
        keras_applications \
        keras_preprocessing \
        matplotlib \
        numpy \
        pandas \
        scipy \
        sklearn \
        tqdm \
        argparse \
        boto3 \
        mtcnn \
        && \
    pip3 install tensorflow-gpu

%environment
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8
    export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
