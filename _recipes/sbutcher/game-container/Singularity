Bootstrap: docker
From: nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

%help

   Purpose: Pytorch container for GPU
   Author: S. Butcher / QMUL. 
   Based on https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/docker/Dockerfile.gpu
   Versions:
   Python       : 2.7
   Pytorch	: 0.4
   CUDA         : 9.0.176
   CUDNN        : 7.1.4.18
   Ubuntu       : 16.04
   Architecture : x86
   Run `singularity exec <container> pip list` to see a list of installed python packages
   You will need to pass the `--nv` option to the singularity exec/shell commands to use the GPU

%environment 

   # Add CUDA paths
   CPATH="/usr/local/cuda/include:$CPATH"
   PATH="/usr/local/cuda/bin:$PATH"
   # For CUDA profiling, TensorFlow requires CUPTI.
   LD_LIBRARY_PATH="/usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
   CUDA_HOME="/usr/local/cuda"

%post

   # Pick up some TF dependencies
   apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libzmq3-dev \
        pkg-config \
        python \
        python-dev \
        rsync \
        software-properties-common \
        unzip \
        wget \
        sudo \
        && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/*

   # ensure python2 is default
   update-alternatives --install /usr/bin/python python /usr/bin/python27 1 \
   && update-alternatives --install /usr/bin/pip pip /usr/bin/pip27 1

   # install pip
   curl -O https://bootstrap.pypa.io/get-pip.py && \
      python get-pip.py && \
      rm get-pip.py

   pip install --upgrade pip requests setuptools pipenv
   pip --no-cache-dir install \
        numpy \
        pandas \
        scipy \
        sklearn

   # Install pytorch as per pytorch.org instructions
   pip install http://download.pytorch.org/whl/cu90/torch-0.4.0-cp27-cp27mu-linux_x86_64.whl
   pip install torchvision 

    mkdir /opt/rl-setup && cd /opt/rl-setup
   git clone https://github.com/openai/gym.git
   cd gym
   pip install -e .

   cd /opt/rl-setup
   git clone https://github.com/sbutcher/visdom
   cd visdom
   bash ./download.sh
   pip install -e .
   cp -r /opt/rl-setup/visdom/py/static/* /opt/rl-setup/visdom/py/visdom/static

   pip install mujoco-py==0.5.7 


%test 
   echo "Running pip list"
   pip list

