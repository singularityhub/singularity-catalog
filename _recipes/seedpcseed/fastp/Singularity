Bootstrap: docker

From: continuumio/miniconda3

%files

%environment
    PATH=$PATH:/opt/conda/bin

%post
    . /opt/conda/etc/profile.d/conda.sh
    conda install -c bioconda fastp

%runscript
    exec "$@"
