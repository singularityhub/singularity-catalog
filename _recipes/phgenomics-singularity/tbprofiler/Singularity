Bootstrap: docker
From: continuumio/miniconda3:4.5.12

%help
A Singularity image for TB-profiler

%labels
Maintainer Kristy Horan
Build 1.0
tb-profiler v2.8.1

%environment
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

conda install -c bioconda tb-profiler=2.8.1

