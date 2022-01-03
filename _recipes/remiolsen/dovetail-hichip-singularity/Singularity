BootStrap: docker
From: conda/miniconda3

%labels
    Maintainer remi-andre.olsen@scilifelab.se

%post
    apt-get update
    apt-get install -y git build-essential zlib1g-dev libcurl3 liblz4-tool
    conda config --add channels bioconda
    conda install --yes bwa=0.7.17 \
        samtools=1.11 \
        pairtools=0.3.0 \
        bedtools=2.30.0
    pip install pysam==0.16.0.1 \
        tabulate==0.8.9 \
        numpy==1.21.2 \
        scipy==1.7.1 \
        py2bit==0.3.0 \
        matplotlib==3.4.3 \
        pyBigWig==0.3.18 \
        deeptools==3.5.1 \
        pandas==1.3.3
    apt-get clean
    cd /opt
    git clone https://github.com/dovetail-genomics/HiChiP.git
    cd HiChiP
    for i in *.sh; do chmod +x $i;done
    for i in *.py; do chmod +x $i;done
    NOW=`date`
    REV=`git rev-parse --short HEAD`

%environment
    export PATH="/opt/HiChiP/:$PATH"


%help
    https://github.com/remiolsen/dovetail-hichip-singularity (built $NOW)
    Singularity dependency wrapper and containerization of Dovetail HiChiP tools - https://hichip.readthedocs.io/en/latest/index.html
    HiChiP-$REV



