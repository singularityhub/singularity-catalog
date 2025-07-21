Bootstrap: docker

From: continuumio/miniconda3

%files
    environment.yml

%post
    apt-get update
    apt-get -y install \
    build-essential \
    cmake \
    gdb \
    libhdf5-dev
    /opt/conda/bin/conda env create -f environment.yml