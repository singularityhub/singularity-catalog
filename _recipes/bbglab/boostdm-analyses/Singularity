Bootstrap: docker
From: debian:buster-slim

%environment
    export DEBIAN_FRONTEND=noninteractive
    export TZ=Europe
    export LC_ALL=C.UTF-8
    export PATH_SOURCE_DATA=$PWD/boostdm-analyses

%help
    Singularity image to run boostdm-analyses notebooks with all dependencies
    GitHub: https://github.com/bbglab/boostdm-analyses

%setup
    mkdir ${SINGULARITY_ROOTFS}/notebook

%post
    apt-get update
    
    apt-get -y --no-install-recommends install locales-all build-essential libffi-dev \
    python3 python3-dev python3-venv python3-pip python3-setuptools \
    libcurl4-openssl-dev libssl-dev python3-pip python3-tk

    /usr/bin/pip3 install numpy==1.16.2 scipy==1.1.0 pandas==0.24.1 \
                          bgdata bgreference \
                          matplotlib==3.0.2 seaborn \
                          ipykernel ipython jupyterlab tqdm click \
                          scikit-learn patsy statsmodels statannot

