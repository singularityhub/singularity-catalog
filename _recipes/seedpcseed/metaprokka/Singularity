Bootstrap: docker

From: continuumio/miniconda3

%files

%environment
    PATH=$PATH:/opt/conda/bin

%post
    apt-get update
    . /opt/conda/etc/profile.d/conda.sh
    conda config --add channels bioconda
    conda config --add channels conda-forge
    conda install -y python=3.6
    conda install -y -c bioconda metaprokka
    conda update --all

%runscript
    exec "$@"
