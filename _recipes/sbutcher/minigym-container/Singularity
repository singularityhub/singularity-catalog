Bootstrap: docker
From: nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

%help

   Purpose: Pytorch/tensorflow container for GPU (#13512)
   Author: S. Butcher / QMUL. 
   Based in part, on https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/docker/Dockerfile.gpu
   Versions:
   Python       : 3.5
   Pytorch	: 1.0
   Tensorflow	: 1.12             # GPU version
   CUDA         : 9.0.176          # Tensorflow requires CUDA 9.0 
   CUDNN        : 7.4.1
   Ubuntu       : 16.04
   Architecture : x86
   Run `singularity exec <container> pip freeze` to see a list of installed python packages
   You will need to pass the `--nv` option to the singularity exec/shell commands to use the GPU.
   Published research should reference Apocrita using the following text:
   "This research utilised Queen Mary's Apocrita HPC facility, supported by QMUL Research-IT. http://doi.org/10.5281/zenodo.438045"

%environment 

   # Add CUDA paths
   CPATH="/usr/local/cuda/include:$CPATH"
   PATH="/usr/local/cuda/bin:$PATH"
   # For CUDA profiling, TensorFlow requires CUPTI.
   LD_LIBRARY_PATH="/usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
   CUDA_HOME="/usr/local/cuda"
   export LC_ALL="en_GB.UTF-8"        
   export LANG="en_GB.UTF-8"

%post

   # Pick up some TF dependencies
   apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libzmq3-dev \
        pkg-config \
        python3 \
        python3-dev \
        rsync \
        software-properties-common \
        unzip \
        git \
        vim \
	locales \
        libx11-6 \
	libxext6 \
	python3-fontconfig \
        libxi6 \
	libxrender-dev \
        libgl1-mesa-glx \
        && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/*

   export LC_ALL="en_GB.UTF-8"
   export LANG="en_GB.UTF-8"
   locale-gen en_GB.UTF-8

   # ensure python3 is default
   update-alternatives --install /usr/bin/python python /usr/bin/python3 1  \

   # install pip (don't use apt because of https://github.com/pypa/pip/issues/5221 )
   curl -O https://bootstrap.pypa.io/get-pip.py && \
      python get-pip.py && \
      rm get-pip.py
   pip install -U virtualenv

   pip install --upgrade requests setuptools pipenv
   pip --no-cache-dir install \
        numpy \
        pandas \
        scipy \
        sklearn \
        torch \
	torchvision \
        tensorflow-gpu \
        gym-ple \
        gym[atari] \
        gym-retro \
        pyqt5

   # Install the minigrid package. This has a GUI and results in 
   # libxi6,libxrender-dev, libgl1-mesa-glx, python3-fontconfig
   mkdir gits && cd /gits
   git clone https://github.com/maximecb/gym-minigrid.git
   cd gym-minigrid
   pip3 install -e .
        
   cd /gits
   git clone https://github.com/lcswillems/torch-rl.git
   cd torch-rl
   pip3 install -e torch_rl

%test 
   echo "Container complete. Running pip list"
   pip freeze
