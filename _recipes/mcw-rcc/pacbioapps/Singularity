Bootstrap: docker
From: ubuntu:16.04

%labels
Maintainer Matthew Flister

%help
This container runs includes available PacBio apps as of 04/09/2020.

%environment
    SHELL=/bin/bash
    export PATH="/opt/miniconda2/bin:$PATH"

%post
    # default mount points
    mkdir -p /scratch/global /scratch/local /rcc/stor1/refdata /rcc/stor1/projects /rcc/stor1/depts

    # Install necessary packages
    apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        gcc-multilib \
        libboost-all-dev \
        libhdf5-serial-dev \
        zlib1g-dev \
        pkg-config \
        wget \
        bzip2
    apt-get clean

    # install miniconda
    wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda2.sh
    bash miniconda2.sh -b -p /opt/miniconda2
    rm miniconda2.sh
    export PATH="/opt/miniconda2/bin:$PATH"

    # install pacbio apps
    conda install -c bioconda \
        bam2fastx \
        bax2bam \
        blasr \
        pbgcpp \
        genomicconsensus \
        isoseq3 \
        lima \
        minorseq \
        pbbam \
        pbccs \
        pbcommand \
        pbcopper \
        pbcore \
        pbcoretools \
        pblaa \
        pbalign \
        pbmm2 \
        pbsv \
        recalladapters \
        pb-falcon \
        pb-dazzler \
        pb-assembly \

