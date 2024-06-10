Bootstrap: docker
From: continuumio/miniconda3:4.5.12

%help
A Singularity image for Prokka

%labels
Maintainer Kristy Horan
Build 1.0
Genome annotation with Prokka

%environment
export VERSION=1.0
export PATH=/opt/conda/bin:$PATH

%post

export PATH=/opt/conda/bin:$PATH

conda config --add channels conda-forge
conda config --add channels defaults
conda config --add channels r
conda config --add channels bioconda

conda install -c conda-forge -c bioconda prokka