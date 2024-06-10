Bootstrap:docker  
From:ubuntu:latest  

%labels
MAINTAINER Simon Andrews

%environment

%runscript

%post  
apt -y update
apt -y install wget
wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b

echo ". ~/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc
. ~/miniconda3/etc/profile.d/conda.sh

conda config --add channels bioconda
conda config --add channels conda-forge
conda install --yes bwa fastqc

