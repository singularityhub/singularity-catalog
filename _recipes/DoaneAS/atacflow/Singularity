Bootstrap:docker
From: intelpython/intelpython2_full:latest

%setup

%environment

%files

%post
  conda config --add channels defaults
  conda config --add channels conda-forge
  conda config --add channels bioconda
  conda install  -y cython scipy samtools pysam matplotlib python=2
  
  pip --no-cache-dir install \
        git+https://github.com/GreenleafLab/NucleoATAC.git
  
  mkdir -p /athena
  mkdir /scratchLocal
