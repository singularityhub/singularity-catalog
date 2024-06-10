#!/bin/bash/
BootStrap:docker
From: ubuntu:18.04

%environment
PATH=/opt/conda/envs/qiime1.9.1/bin:/opt/conda/bin:$PATH
export PATH

%post
apt-get update -y
apt-get install -y build-essential libsm6 libxext6 libgtk2.0-dev
apt-get install -y git curl python3 vim wget tar bzip2 gzip lzma
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda
export PATH=/opt/conda/bin:$PATH
conda install -y conda
conda update -y conda
mkdir /lus
mkdir /lus/scratch
conda create -n qiime1.9.1 python=2.7  qiime matplotlib=1.4.3 mock nose -c bioconda -y

%runscript
source activate qiime1.9.1
