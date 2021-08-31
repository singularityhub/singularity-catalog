Bootstrap: docker
From: ubuntu:20.04

%environment
    export TZ=Europe/Berlin
    
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8

%post
    apt-get update
    export TZ=Europe/Berlin
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
    
    apt-get install -y tabix moreutils wget zip unzip


# PLINK
    mkdir -p /opt/plink
    cd /opt/plink
    wget http://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20201019.zip
    unzip plink_linux_x86_64_20201019.zip
    rm plink_linux_x86_64_20201019.zip
    ln -s /opt/plink/plink /usr/local/bin/plink


# GCTA
    cd /opt
    wget https://cnsgenomics.com/software/gcta/bin/gcta_1.93.2beta.zip
    unzip gcta_1.93.2beta.zip && rm gcta_1.93.2beta.zip
    ln -s /opt/gcta_1.93.2beta/gcta64 /usr/local/bin/gcta64


# Metal
    cd /opt
    wget http://csg.sph.umich.edu/abecasis/Metal/download/Linux-metal.tar.gz
    tar zxf Linux-metal.tar.gz && rm Linux-metal.tar.gz
    ln -s /opt/generic-metal/metal /usr/local/bin/metal

