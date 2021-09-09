Bootstrap: docker
From: continuumio/miniconda3:latest
Stage: condabuild

%labels
    authors ="Jyotirmoy Das" \
    description = "Docker image containing all requirement for the AlveolarCellTypeDeconvolution pipeline"

%post
    apt-get update 
    apt-get install -y g++ git make procps rsync locales 
    apt-get clean -y
    
    # Install R, Python, misc. utilities
    apt-get install -y libopenblas-dev r-base-core libcurl4-openssl-dev libopenmpi-dev openmpi-bin openmpi-common openmpi-doc openssh-client openssh-server libssh-dev wget vim git nano git cmake  gfortran g++ curl wget python autoconf bzip2 libtool libtool-bin python-pip python-dev
    apt-get clean
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8

    # install required R packages
    R --slave -e 


