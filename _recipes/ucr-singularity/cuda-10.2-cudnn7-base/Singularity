Bootstrap: docker
From: nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

%environment

    LANG=C.UTF-8 
    LC_ALL=C.UTF-8 
    PATH=/opt/conda/bin:$PATH
    CONDA_PKGS_DIRS=$HOME/.conda/pkgs
    
%post

    # Update list of available packages, then upgrade them
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
    
    # Utility and support packages
    apt-get install -y screen terminator tmux vim wget 
    apt-get install -y aptitude build-essential cmake g++ gfortran git \
        pkg-config software-properties-common
    apt-get install -y unrar
    apt-get install -y ffmpeg
    apt-get install -y gnuplot-x11
    
    # Anaconda 3 per https://github.com/ContinuumIO/docker-images/blob/master/anaconda3/debian/Dockerfile
    # License per https://github.com/ContinuumIO/docker-images/blob/master/anaconda3/LICENSE
    apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial subversion
    apt-get clean

    wget --quiet https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh -O ~/anaconda.sh
    /bin/bash ~/anaconda.sh -b -p /opt/conda
    rm ~/anaconda.sh
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
    echo "conda activate base" >> ~/.bashrc
    find /opt/conda/ -follow -type f -name '*.a' -delete
    find /opt/conda/ -follow -type f -name '*.js.map' -delete
    /opt/conda/bin/conda clean -afy

    # Install packages
    /opt/conda/bin/conda install -y -c pytorch pytorch

    # Clean up
    apt-get -y autoremove
    rm -rvf /var/lib/apt/lists/*
