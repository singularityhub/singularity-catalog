Bootstrap: docker
From: continuumio/miniconda3

%labels
   MAINTAINER Arun Seetharam
   EMAIL arnstrm@iastate.edu

%test
    python3 --version

%files
    environment.yml
    
%environment
    export PATH=/opt/conda/envs/Ancestry/bin/:$PATH
    export PATH=/opt/RIA/:$PATH
    export PATH=/opt/RIA/Tools:/opt/RIA/Tools/EB_Analysis:/opt/RIA/Tools/TestingModel:$PATH

%post

    apt update
    apt install -y software-properties-common
    DEBIAN_FRONTEND=noninteractive
    apt update
    apt install -y build-essential wget curl git autoconf automake
    apt install -y gcc g++ bison make cmake
    apt install -y perl zlib1g-dev libbz2-dev liblzma-dev libcurl4-gnutls-dev libssl-dev libtool libncurses5-dev liblpsolve55-dev rsync librsync-dev
    apt install -y libboost-dev '^libboost-.*71-dev'
    apt install -y bowtie2 jellyfish salmon samtools
    apt install -y python3 python3-numpy python3-dev python3-scipy python3-pandas python3-pip
    apt install -y perl
    /opt/conda/bin/conda env create -f environment.yml
    # RIA
    cd /opt
    git clone https://github.com/jahaltom/RIA.git
    cd RIA
    find . -type f -name "*.py" | xargs chmod +x 


%runscript
    exec /opt/conda/envs/Ancestry/bin/"$@"


