Bootstrap: docker
From: ubuntu:16.04

%environment
    LC_ALL=C.UTF-8 
    SHELL=/bin/bash
    PATH=/opt/anaconda/bin:${PATH}
    ROOTSYS=/opt/root/
    LD_LIBRARY_PATH=/opt/root/lib

    #SHELL:=/bin/bash
    #ROOTSYS=/bin/root
    #PATH=$PATH:$ROOTSYS/bin
    #LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ROOTSYS/lib

%runscript
    echo "This container is filled with jitterbugs"
    #export PATH=/opt/anaconda/bin:${PATH}

%post
    echo "Hello from inside the container"
    apt-get update
    apt-get -y install wget git bzip2 build-essential gcc zlib1g-dev language-pack-en-base apt-transport-https make cmake unzip libncurses5-dev libncursesw5-dev
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

    cd /root/ && wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
    cd /root/ && chmod 700 ./Miniconda2-latest-Linux-x86_64.sh
    cd /root/ && bash ./Miniconda2-latest-Linux-x86_64.sh -b -p /opt/anaconda/   

    export PATH=/opt/anaconda/bin:${PATH} 
    pip install pysam==0.8.1
    pip install numpy
    pip install matplotlib
    pip install matplotlib-venn
    pip install pybedtools psutil pandas memory_profiler 
    
    conda update -n base -c defaults conda
    conda config --add channels defaults
    conda config --add channels conda-forge
    conda config --add channels bioconda
    
    cd /opt/ && git clone https://github.com/elzbth/jitterbug.git
    cd /opt/jitterbug
