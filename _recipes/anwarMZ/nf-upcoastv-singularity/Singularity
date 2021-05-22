Bootstrap: docker
From: continuumio/miniconda3:latest
Stage: condabuild

%labels
authors="Zohaib Anwar"
description="Docker image containing all requirements for the upcoast-v project's vibrio pipeline"

%post

apt-get update && \
apt-get install -y git procps && \
apt-get clean -y

/opt/conda/bin/conda create --name upcoastv-env && \
    conda config --append channels default && \
    conda config --append channels bioconda  && \
    conda config --append channels conda-forge  && \
    conda install mamba -n base -c conda-forge && \
    mamba install python=3.7 biopython=1.74 \
    libxcb pandas=1.2.4 \
    bwa=0.7.17 samtools=1.10 \
    bcftools=1.10 trim-galore=0.6.5 \
    pyvcf=0.6.8 pyyaml=5.3.1 pysam=0.16.0 \
    csvtk=0.22.0 graphviz=2.40.1 fastqc=0.11.7 \
    shovill=1.1.0 multiqc=1.9


%environment
export PATH=/opt/conda/envs/upcoastv-env/bin:$PATH
