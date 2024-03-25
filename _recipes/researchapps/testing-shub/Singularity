Bootstrap: docker
From: ubuntu:18.04

%environment
    export LC_ALL=C
    export DEBIAN_FRONTEND=noninteractive

%post
  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y git wget

  echo "DONE with OS install and update"
  echo "Define environment variable for conda install path"
  export ROOT_INSTALL_PATH="/usr/local"
  export CONDA_INSTALL_PATH="/usr/local/miniconda3"
  echo "Change to install directory"
  cd $ROOT_INSTALL_PATH
  echo "Download and install miniconda"
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
  echo "Install conda"
  bash Miniconda3-latest-Linux-x86_64.sh -b -p $CONDA_INSTALL_PATH
