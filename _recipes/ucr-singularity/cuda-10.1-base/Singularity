Bootstrap: docker
From: nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

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

    # Clean up
    apt-get -y autoremove
    rm -rvf /var/lib/apt/lists/*
    
