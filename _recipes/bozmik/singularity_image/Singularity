Bootstrap: docker
From: nfcore/base


%environment

    PATH=/opt/conda/envs/bozmik-singularity_image/bin:$PATH
    export PATH


%files
    environment.yml 

%post

    alias conda="/opt/conda/bin/conda"
    conda config --add channels conda-forge
    conda config --add channels bioconda
    conda install -y \
       spotyping=2.1
    conda clean --tarballs --index-cache --source-cache
    apt-get update && apt-get install -y procps

    /opt/conda/bin/conda env create -f /environment.yml
    /opt/conda/bin/conda clean -a



