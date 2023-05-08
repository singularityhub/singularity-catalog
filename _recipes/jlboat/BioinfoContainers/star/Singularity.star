Bootstrap: docker

From: debian:latest

%labels
    Topic Bioinformatics
    Input FASTQ
    Output BAM
    STAR latest

%help
singularity run star.simg STAR

%environment
    PATH=$PATH:/STAR/bin/Linux_x86_64/

%post
    apt-get update --fix-missing && apt-get install -y git make g++ libz-dev && rm -rf /var/lib/apt/lists/*
    git clone https://github.com/alexdobin/STAR.git
    chmod -R 777 /STAR
    cd STAR/source
    make STAR
    apt-get remove -y git make g++

%runscript
    exec "$@"

