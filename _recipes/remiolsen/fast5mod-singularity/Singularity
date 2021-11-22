BootStrap: docker
From: python:3.8-buster 

%labels
    Maintainer remi-andre.olsen@scilifelab.se

%post
    apt-get update
    apt-get install -y git coreutils build-essential pkg-config libhdf5-dev gzip
    pip install fast5mod


%help
    https://github.com/nanoporetech/fast5mod


