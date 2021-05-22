Bootstrap: docker
From: ubuntu:xenial

%environment

    export PATH=/opt/conda/bin:${PATH}

%post

    apt-get -y update
    apt-get -y install curl bzip2
    
    curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
    chmod +x ~/miniconda.sh
    ~/miniconda.sh -b -p /opt/conda
    rm ~/miniconda.sh
    
    #For integration with JupyterHub  
    /opt/conda/bin/pip install --no-cache-dir ipykernel 
    
    # Installation of Xeus-cling.  It needs gcc7
    apt-get -y install software-properties-common
    add-apt-repository -y ppa:jonathonf/gcc-7.2
    apt-get update -y
    apt-get install -y gcc-7
    # create gcc alias to gcc-7
    cd /usr/bin && ln -sf gcc-7 gcc
    
    /opt/conda/bin/conda install xeus-cling notebook -c QuantStack -c conda-forge
    

