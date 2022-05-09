BootStrap: docker
From: conda/miniconda3

%labels
    Maintainer remi-andre.olsen@scilifelab.se

%post
    apt-get update
    apt-get install -y git coreutils build-essential zlib1g-dev

    conda config --add channels bioconda
    conda install --yes bwa=0.7.17 samtools=1.11

    cd /opt
    git clone https://github.com/dfguan/pins.git
    cd pins/src && make

%environment
    export PATH="/opt/pins/bin/:$PATH"

%help
    (singularity image built $NOW)
    https://github.com/dfguan/pin_hic


