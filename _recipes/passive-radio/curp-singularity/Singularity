Bootstrap: docker
From: ubuntu:22.04

%environment
    export DEBIAN_FRONTEND=noninteractive

%post
    apt-get update
    apt-get install -y tzdata

    apt-get install -y git graphviz graphviz-dev openmpi-bin libopenmpi-dev python3-pip
    apt-get clean
    rm -rf /var/lib/apt/lists/*

    python3 --version
    python3 -m pip install pip==22.2.2
    
    pip install --no-cache-dir numpy==1.23.5
    
    git clone --depth 1 https://github.com/yamatolab/current-calculations-for-proteins.git curp
    cd curp
    pip install --no-cache-dir .
    rm -rf

%test
    curp -h

%runscript
    echo "Welcom to curp container!"

%labels
    Version v0.0.1

%help
    This is a CURP container to build an ubuntu environment which everything you need to run curp is already installed.