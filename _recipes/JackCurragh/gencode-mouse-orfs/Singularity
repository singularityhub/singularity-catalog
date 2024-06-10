Bootstrap: docker
From: ubuntu:latest

%post
    # Install necessary packages
    apt-get update && apt-get install -y \
        wget \
        unzip \
        default-jre \
        perl

    # Download and install FastQC
    wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip && \
        unzip fastqc_v0.11.9.zip && \
        chmod +x FastQC/fastqc && \
        ln -s /FastQC/fastqc /usr/local/bin/fastqc

%runscript
    # Set the default command
    exec "$@"