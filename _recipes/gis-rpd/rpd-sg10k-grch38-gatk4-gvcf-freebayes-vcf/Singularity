From:continuumio/miniconda
Bootstrap:docker

%labels
    MAINTAINER Andreas Wilm <wilma@gis.a-star.edu.sg>
    DESCRIPTION Container image containing all requirements for the rpd-sg10k-grch38-gatk4gvcf pipeline
    VERSION 1.0dev

%environment
    PATH=/opt/conda/envs/rpd-sg10k-grch38-gatk4gvcf/bin:$PATH
    export PATH

%files
    environment.yml /

%post
    # copied from https://github.com/nf-core/tools/blob/master/Dockerfile
    # so that we can start from miniconda rather than nfcore/base
    # Install procps so that Nextflow can poll CPU usage
    # Also install gnuplot which seems broken in bio/conda at the
    # time of writing due to missing libs 
    apt-get update && apt-get install -y procps gnuplot && apt-get clean -y 
    # Update the base version of conda
    /opt/conda/bin/conda update -n base conda

    # nscc
    mkdir /data /seq /secure /scratch

    # sg10k-cov
    apt-get install -y build-essential zlib1g-dev libbz2-dev && \
      git clone https://andreas-wilm@bitbucket.org/andreas-wilm/sg10k-cov.git && \
      cd sg10k-cov/ && \
      git checkout 6b74ab8 && \
      bash make.sh && \
      cp sg10k-cov-062017.sh samtools-M /usr/local/bin/ && \
      cd .. && rm -rf sg10k-cov/ && \
      apt-get remove -y build-essential zlib1g-dev libbz2-dev && apt-get clean -y
      
    /opt/conda/bin/conda env create -f /environment.yml
    /opt/conda/bin/conda clean -a

