Bootstrap: docker
From: ubuntu:latest

%post
    # Install necessary packages
    apt-get update && apt-get install -y \
        wget \
        unzip \
        default-jre \
        perl \
        python-setuptools \
        python3 \
        python-pip

    # Download and install FastQC
    wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip && \
        unzip fastqc_v0.11.9.zip && \
        chmod +x FastQC/fastqc && \
        ln -s /FastQC/fastqc /usr/local/bin/fastqc


    wget http://opengene.org/fastp/fastp && \
        chmod a+x ./fastp

    python3 -m pip install --upgrade pip
    python3 -m pip install multiqc fastq-dl biopython

%runscript
    # Set the default command
    exec "$@"