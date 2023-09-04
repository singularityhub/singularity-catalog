Bootstrap: docker
From: continuumio/miniconda3:4.5.12

%help
A Singularity image for Roary

%labels
Maintainer Kristy Horan
Build 1.0
Genome annotation with Roary

%environment
export VERSION=3.13.0
export PATH=/opt/conda/bin:$PATH

%post

export PATH=/opt/conda/bin:$PATH

conda upgrade -c defaults --override-channels conda
conda config --add channels conda-forge
conda config --add channels defaults
conda config --add channels r
conda config --add channels bioconda

conda install -c conda-forge -c bioconda roary=3.13.0