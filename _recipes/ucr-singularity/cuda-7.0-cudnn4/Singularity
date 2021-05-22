
Bootstrap: docker
From: nvidia/cuda:7.0-cudnn4-devel-ubuntu14.04

%post

    # Update list of available packages, then upgrade them
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
    
    # Install opbenblas.  Note: -y to install without prompt is necessary for automated install.
    apt-get install -y libopenblas-dev
