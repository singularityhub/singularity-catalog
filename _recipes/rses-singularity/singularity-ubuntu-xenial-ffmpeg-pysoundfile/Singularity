Bootstrap: docker
From: ubuntu:16.04

%labels
    Maintainer zpu1@sheffield.ac.uk
    Version 0.1

%setup
    #Runs on host. The path to the image is $SINGULARITY_ROOTFS
    cp requirements.txt $SINGULARITY_ROOTFS/tmp/requirements.txt

%post
    #Post setup, runs inside the image
    apt-get update 

    DEBIAN_FRONTEND=noninteractive apt-get install -y locales
    sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen
    dpkg-reconfigure --frontend=noninteractive locales 
    update-locale LANG=en_GB.UTF-8

    apt install -y \
        procps \
        ffmpeg \
        libsndfile1 \
        sndfile-tools \
        python-pip
    # Here we annoyingly need to 'pip install' numpy _before_ other python packages:
    # (see https://github.com/pypa/pip/issues/272)
    pip install $(grep numpy /tmp/requirements.txt)
    pip install -r /tmp/requirements.txt

    #Default mount paths
    mkdir /scratch /data /shared /fastdata

    #Nvidia driver mount paths (if GPU required)
    #mkdir /nvlib /nvbin

%environment
    LANG=en_GB.UTF-8 
    export LANG

    #Add nvidia driver paths to the environment variables (if GPU required)
    #export PATH="/nvbin:$PATH"
    #export LD_LIBRARY_PATH="/nvlib:$LD_LIBRARY_PATH"

%runscript
    #Runs inside the image every time it starts up

%test
    #Test script to verify that the image is built and running correctly
    #which ffmpeg && python -c 'import soundfile'
