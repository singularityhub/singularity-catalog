Bootstrap:docker
From:continuumio/miniconda3:4.6.14

%labels
    MAINTAINER Peter Kruczkiewicz
    DESCRIPTION Singularity image containing all requirements for the peterk87/nf-biohansel-sra-benchmarking pipeline
    VERSION 1.0dev

%environment
    #export LC_ALL=C
    export PATH=/opt/conda/envs/nf-biohansel-sra-benchmarking-1.0dev/bin:$PATH

%files
    environment.yml /

%post
    export PATH=/opt/conda/bin:$PATH
    conda info
    apt-get update && apt-get install -y procps curl locales && apt-get clean -y
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
        echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
        dpkg-reconfigure --frontend=noninteractive locales && \
        update-locale LANG=en_US.UTF-8
    locale
    #conda install -c bioconda snpeff
    #snpEff -version
    conda install conda=4.7.11
    conda env create -f /environment.yml
    conda clean -a
