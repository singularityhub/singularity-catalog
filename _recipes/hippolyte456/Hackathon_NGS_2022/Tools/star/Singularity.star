Bootstrap: docker
FROM: ubuntu:22.04

%post

    # Install Dependancies
    apt-get update
    apt-get install -y tar wget make gcc libz-dev build-essential
    apt-get install -y autoconf automake gcc perl zlib1g-dev libbz2-dev liblzma-dev libcurl4-gnutls-dev libssl-dev libncurses5-dev

    # STAR
    wget https://github.com/alexdobin/STAR/archive/2.7.10a.tar.gz 
    tar -xzvf 2.7.10a.tar.gz  -C /usr/local 
    rm 2.7.10a.tar.gz
    mv /usr/local/STAR-2.7.10a /usr/local/STAR
    make STAR -C /usr/local/STAR/source

    #samtools
    wget https://github.com/samtools/samtools/releases/download/1.3.1/samtools-1.3.1.tar.bz2 -O samtools.tar.bz2
    tar -xjvf samtools.tar.bz2  -C /usr/local
    rm samtools.tar.bz2
    make -C /usr/local/samtools-1.3.1
    make install -C /usr/local/samtools-1.3.1

    # Cleaning
    apt-get autoremove -y && apt-get clean
    
%environment
    export PATH=:$PATH:/usr/local/STAR/bin/Linux_x86_64:/usr/local/samtools:/usr/local/bin 