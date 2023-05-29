Bootstrap: docker
From: nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

%environment

  # use bash as default shell
  SHELL=/bin/bash

  # add CUDA paths
  CPATH="/usr/local/cuda/include:$CPATH"
  PATH="/usr/local/cuda/bin:$PATH"
  LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
  CUDA_HOME="/usr/local/cuda"

  # add Anaconda path
  PATH="/usr/local/anaconda3/bin:$PATH"

  export PATH LD_LIBRARY_PATH CPATH CUDA_HOME

%setup
  # runs on host
  # the path to the image is $SINGULARITY_ROOTFS

%post
  # post-setup script

  # load environment variables
  . /environment

  # use bash as default shell
  echo "\n #Using bash as default shell \n" >> /environment
  echo 'SHELL=/bin/bash' >> /environment

  # make environment file executable
  chmod +x /environment

  # default mount paths
  mkdir /scratch /data 

  #Add CUDA paths
  echo "\n #Cuda paths \n" >> /environment
  echo 'export CPATH="/usr/local/cuda/include:$CPATH"' >> /environment
  echo 'export PATH="/usr/local/cuda/bin:$PATH"' >> /environment
  echo 'export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"' >> /environment
  echo 'export CUDA_HOME="/usr/local/cuda"' >> /environment

  # updating and getting required packages
  apt-get update
  apt-get install -y wget git vim build-essential cmake

  # creates a build directory
  mkdir build
  cd build

  # download and install Anaconda
  CONDA_INSTALL_PATH="/usr/local/anaconda3"
  wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
  chmod +x Anaconda3-5.0.1-Linux-x86_64.sh
  ./Anaconda3-5.0.1-Linux-x86_64.sh -b -p $CONDA_INSTALL_PATH

  # idea courtesy https://tspankaj.com/2017/08/12/cuda-9-and-cudnn-7-with-pytorch/

  # install pytorch
  git clone https://github.com/csarofeen/pytorch
  cd pytorch
  git checkout cuda9

  export CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"
  conda install numpy pyyaml mkl setuptools cffi
  conda install -c soumith magma-cuda80
  python setup.py install

%runscript
  # executes with the singularity run command
  # delete this section to use existing docker ENTRYPOINT command

%test
  # test that script is a success
