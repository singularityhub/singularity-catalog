BootStrap: docker
From: nvidia/cuda:8.0-devel

%post
    apt-get update
    apt-get -y install wget build-essential zlib1g-dev
    wget https://vorboss.dl.sourceforge.net/project/seqbarracuda/Source%20Code/Version%200.7.0/barracuda_0.7.107h.tar.gz
    tar xvf barracuda_0.7.107h.tar.gz 
    cd barracuda
    make all
    mv bin/barracuda /usr/local/bin/barracuda

