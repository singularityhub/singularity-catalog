Bootstrap: docker
From: continuumio/miniconda3:4.5.12

%help
A Singularity image for Snippy

%labels
Maintainer Kristy Horan
Build 1.0
snippy_version 4.4.5

%environment
export VERSION=1.0
export PATH=/opt/conda/bin:$PATH

%post

apt-get update
apt-get -y install locales sudo

export PATH=/opt/conda/bin:$PATH
conda upgrade -c defaults --override-channels conda
conda config --add channels conda-forge
conda config --add channels defaults
conda config --add channels r
conda config --add channels bioconda

conda install -c conda-forge -c bioconda snippy=4.4.5
conda install -c conda-forge -c bioconda snp-dists=0.6.3
conda install -c bioconda samtools=1.9

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
