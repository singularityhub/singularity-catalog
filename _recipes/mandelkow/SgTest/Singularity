BootStrap: docker
# From: tensorflow/tensorflow:1.1.0-gpu
From: tensorflow/tensorflow:1.7.1-gpu-py3
%labels

    TENSORFLOW_VERSION 1.1.0
    MAINTAINER Roger Jiang

%setup

%post
    # create bind points for NIH HPC environment
    mkdir /gpfs /spin1 /gs2 /gs3 /gs4 /gs5 /gs6 
    mkdir /gs7 /gs8 /data /scratch /fdb /lscratch

    # cd /tmp
    # curl -0 https://repo.anaconda.com/archive/Anaconda2-5.1.0-Linux-x86_64.sh > anaconda.sh
    # bash anaconda.sh -b -p /usr/local/anaconda
    # rm anaconda.sh

    # export PATH=/usr/local/anaconda/bin:$PATH

    echo $PATH

    pip install --upgrade pip
    
    pip install matplotlib numpy pandas scipy simplejson mne jupyterlab

%environment
    export LC_ALL=C
