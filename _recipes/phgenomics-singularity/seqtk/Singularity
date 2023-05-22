Bootstrap: docker
From: continuumio/miniconda3:4.5.12

%help
A Singularity image for seqtk

%labels
Maintainer Kristy Horan
Build 1.0
seqtk version-1.3

%environment

%files


%post
  export SEQTK_VERSION=1.3
  
  export PATH=/opt/conda/bin:$PATH

  conda config --add channels conda-forge
  conda config --add channels defaults
  conda config --add channels r
  conda config --add channels bioconda

  conda install -c bioconda seqtk=${SEQTK_VERSION}
  pip install pandas
  pip install toml
  
  echo "Done"