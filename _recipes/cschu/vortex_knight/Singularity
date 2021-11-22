Bootstrap: docker
From: ubuntu:20.04
IncludeCmd: yes

%environment
#R_VERSION=4.1
#export R_VERSION
#R_CONFIG_DIR=/etc/R/
#export R_CONFIG_DIR
export LC_ALL=C
export PATH=$PATH:/opt/software/miniconda3/bin:/opt/software/mOTUs

%post
  apt-get update
  apt-get install -y apt-transport-https apt-utils software-properties-common
  apt-get install -y add-apt-key
  export DEBIAN_FRONTEND=noninteractive
  ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
  apt-get install -y tzdata
  dpkg-reconfigure --frontend noninteractive tzdata

  apt-get install -y wget python3-pip git

  mkdir -p /opt/software

  # all the conda packages won't work together.. ><;
  wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh 
  bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/software/miniconda3
  rm -f Miniconda3-latest-Linux-x86_64.sh

  #/opt/software/miniconda3/bin/conda install -y -c conda-forge -c bioconda 'samtools>=1.13' bwa kraken2 fastqc multiqc bbmap 'motus==2.6.0'

  /opt/software/miniconda3/bin/conda install -y -c conda-forge -c bioconda hmmer 'samtools>=1.13' bwa kraken2 'gatk4==4.1.6.0-0' fastqc multiqc bbmap

  # mOTUs installation
  # bwa and samtools via conda 

  cd /opt/software
  git clone https://github.com/motu-tool/mOTUs.git
  cd mOTUs
  mkdir -p db_mOTU/
  touch db_mOTU/db_mOTU_versions
  python3 setup.py

  # mTAGs installation
  # hmmer via conda

  # vsearch
  cd /opt/software
  # wget https://github.com/torognes/vsearch/archive/v2.18.0.tar.gz  # source
  # wget https://github.com/torognes/vsearch/releases/download/v2.15.0/vsearch-2.15.0-linux-x86_64.tar.gz  # mtags tested with 2.15.0
  # wget https://github.com/torognes/vsearch/releases/download/v2.18.0/vsearch-2.18.0-linux-x86_64.tar.gz
  wget https://github.com/torognes/vsearch/releases/download/v2.18.0/vsearch-2.18.0-linux-x86_64-static.tar.gz
  tar xvzf vsearch-2.18.0-linux-x86_64-static.tar.gz
  mv vsearch-2.18.0-linux-x86_64-static vsearch

  ln -s /opt/software/vsearch/bin/vsearch /usr/bin/
  
  pip install mTAGs
  mtags download # <- this is stupid


  # MAPseq installation
  cd /opt/software
  wget -q https://github.com/jfmrod/MAPseq/releases/download/2.0.1alpha/mapseq-2.0.1alpha-linux.tar.gz
  tar xzf mapseq-2.0.1alpha-linux.tar.gz
  rm mapseq-2.0.1alpha-linux.tar.gz
  mv mapseq-2.0.1alpha-linux mapseq

  ln -s /opt/software/mapseq/mapseq /usr/bin/
  ln -s /opt/software/mapseq/share /usr/bin/

  #  apt-get install -y build-essential wget subversion git libncurses5-dev libtool autotools-dev autoconf dh-autoreconf
  #  git clone https://github.com/jfmrod/MAPseq.git
  #  cd MAPseq
  #  ./setup.sh
  #  ./bootstrap  # <- this one causes issues, use autoreconf?
  #  ./configure
  #  make 
  #  make install

  

  

#  apt-get install -y wget nano
#  apt-get install -y libblas3 libblas-dev liblapack-dev liblapack3 curl
#  apt-get install -y gcc fort77 aptitude
#  aptitude install -y g++
#  aptitude install -y xorg-dev
#  aptitude install -y libreadline-dev
#  aptitude install -y gfortran
#  gfortran --version
#  apt-get install -y libssl-dev libxml2-dev libpcre3-dev liblzma-dev libbz2-dev libcurl4-openssl-dev 
#  apt-get install -y libhdf5-dev hdf5-helpers libmariadb-client-lgpl-dev
#
#  apt-get install -y r-base r-base-dev
#  
#  R --version
#  
#  # installing packages from cran
#  R --slave -e 'install.packages(c("devtools", "tidyverse", "cowplot"),repos="https://cran.rstudio.com/")'
#
#  # installing from bioc
#  R --slave -e 'if (!requireNamespace("BiocManager",quietly=TRUE)) install.packages("BiocManager")'
#  R --slave -e 'BiocManager::install(version = "3.13")'
#  R --slave -e 'BiocManager::install(c("dada2"))'
