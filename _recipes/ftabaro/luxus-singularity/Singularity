Bootstrap: docker
From: centos:7

%help
  This is a LuxUS container based on CentOS 7. 

  Documentation: https://github.com/hallav/LuxUS

  Usage:
    singularity run --app prepare luxus.sif [options]  # run prepare_data_for_luxus.py 
    singularity run --app luxus luxus.sif [options]    # run run_luxus.py

%labels
  Author francesco.tabaro@tuni.fi
  Version 0.1

%post
  umask 002 && \
  PACKAGES=/packages && \
  mkdir $PACKAGES && \
  cd $PACKAGES && \
  yum makecache && \
  yum groupinstall -y 'Development Tools' && \
  yum install -y epel-release && \
  yum install -y python-devel python-pip && \
  pip install numpy==1.14.5 scipy==1.1.0 kiwisolver==1.1.0 matplotlib==2.2.2 pystan==2.17.1.0 && \
  curl -LO https://github.com/stan-dev/cmdstan/releases/download/v2.12.0/cmdstan-2.12.0.tar.gz && \
  tar xf cmdstan-2.12.0.tar.gz && \
  rm cmdstan-2.12.0.tar.gz && \
  cd cmdstan-2.12.0 && \
  make build && \
  git clone https://github.com/hallav/LuxUS.git $PACKAGES/luxus

%environment
  export PACKAGES=/packages
  export PATH="$PATH:$PACKAGES/cmdstan-2.12.0/bin"
  export PYTHONPATH=$PACKAGES/luxus/scripts

#########
## APPS 
#########

%apprun luxus
  exec python $PACKAGES/luxus/scripts/run_luxus.py $@

%apprun prepare
  exec python $PACKAGES/luxus/scripts/prepare_data_for_luxus.py $@

