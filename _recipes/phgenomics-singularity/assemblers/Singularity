Bootstrap: docker
From: continuumio/miniconda3:4.5.12

%help
A Singularity image for assemblers

%labels
Maintainer Kristy Horan
Build 1.0
assemblers

%environment
export VERSION=1.0

%post
 # set versions of software to install
  export VERSION=1.0
  export SPADES_VERSION=3.13.0
  export SHOVILL_VERSION=1.0.9
  export SKESA_VERSION=2.3.0
  
  export PATH=/opt/conda/bin:PATH
  conda upgrade -c defaults --override-channels conda
  conda config --add channels conda-forge
  conda config --add channels defaults
  conda config --add channels r
  conda config --add channels bioconda
 
  conda install -c bioconda spades=${SPADES_VERSION}
  conda install -c bioconda shovill=${SHOVILL_VERSION}
  conda install -c bioconda skesa=${SKESA_VERSION}

  pip install toml
  pip install biopython
  
  echo "Done"