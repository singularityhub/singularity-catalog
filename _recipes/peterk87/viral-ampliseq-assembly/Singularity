Bootstrap:docker
From:continuumio/miniconda3:4.6.14

%labels
    MAINTAINER Peter Kruczkiewicz
    DESCRIPTION Singularity image containing all requirements for the peterk87/viral-ampliseq-assembly
    VERSION 1.0dev

%environment
    PATH=/opt/conda/envs/viral-ampliseq-assembly-1.0.0/bin:$PATH
    export PATH

%files
    environment.yml /

%post
    export PATH=/opt/conda/bin:$PATH
    apt-get update && apt-get install -y procps curl && apt-get clean -y
    conda install conda=4.7.10
    conda env create -f /environment.yml
    conda clean -a
