Bootstrap: docker
From: continuumio/miniconda3:4.5.12

%help
A Singularity image for name

%labels
Maintainer Kristy Horan
Build 1.0
genome size tools

%environment
export VERSION=
export PATH=/opt/conda/bin:$PATH

%post
 # set versions of software to install
  export MASH_VERSION=2.2.2
  export KMC_VERSION=3.1.1

  export PATH=/opt/conda/bin:$PATH

  conda config --add channels conda-forge
  conda config --add channels defaults
  conda config --add channels r
  conda config --add channels bioconda
 
  conda install -c bioconda mash=${MASH_VERSION}
  conda install -c bioconda kmc=${KMC_VERSION}

  pip install toml

  echo "Done!"
