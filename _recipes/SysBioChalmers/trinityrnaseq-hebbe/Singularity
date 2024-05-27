Bootstrap: docker
From: ubuntu:16.04

%labels
  MAINTAINER SysBioChalmers
  VERSION v2.8.5

%post
  apt-get update && apt-get install -y gcc g++ perl python automake make \
    wget git curl libdb-dev zlib1g-dev bzip2 libncurses5-dev \
    texlive-latex-base default-jre python-pip python-dev gfortran \
    build-essential libghc-zlib-dev libncurses-dev libbz2-dev liblzma-dev libpcre3-dev libxml2-dev \
    libblas-dev gfortran unzip libzmq3-dev nano ftp fort77 libreadline-dev \
    libcurl4-openssl-dev libx11-dev libxt-dev \
    x11-common libcairo2-dev libpng-dev libreadline-dev libjpeg-dev pkg-config libtbb-dev \
  && apt-get clean

  curl -L https://cpanmin.us | perl - App::cpanminus
  cpanm install DB_File
  cpanm install URI::Escape


## set up tool config and deployment area:
  SRC=/usr/local/src
  BIN=/usr/local/bin

## Install R
  cd $SRC
  R_VERSION=R-3.5.2
  curl https://cran.r-project.org/src/base/R-3/$R_VERSION.tar.gz -o $R_VERSION.tar.gz && \
  tar xvf $R_VERSION.tar.gz && \
  cd $R_VERSION && \
  ./configure && make && make install

  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("tidyverse", dep = TRUE)'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("edgeR", dep = TRUE)'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("DESeq2", dep = TRUE)'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("ape", dep = TRUE)'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("ctc", dep = TRUE)'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("gplots", dep = TRUE)'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("Biobase", dep = TRUE)'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("qvalue", dep = TRUE)'
## Beware 'goseq' failed to install because dependency 'geneLenDataBase' is not available for package 'goseq'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("goseq", dep = TRUE)'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("Glimma", dep = TRUE)'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("ROTS", dep = TRUE)'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("GOplot", dep = TRUE)'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("argparse", dep = TRUE)'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("sm", dep = TRUE)'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("fastcluster", dep = TRUE)'
## Beware 'vioplot' failed to install because dependency 'sm' is not available for package 'vioplot'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("vioplot", dep = TRUE)'
## Beware 'DEXSeq' failed to install because dependency 'biomaRt' is not available for package 'DEXSeq'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("DEXSeq", dep = TRUE)'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("tximport", dep = TRUE)'
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("tximportData", dep = TRUE)'

## Bowtie
  cd $SRC
  wget https://sourceforge.net/projects/bowtie-bio/files/bowtie/1.2.1.1/bowtie-1.2.1.1-linux-x86_64.zip/download -O bowtie-1.2.1.1-linux-x86_64.zip && \
  unzip bowtie-1.2.1.1-linux-x86_64.zip && \
  mv bowtie-1.2.1.1/bowtie* $BIN

## RSEM
  mkdir /usr/local/lib/site_perl
  cd $SRC
  wget https://github.com/deweylab/RSEM/archive/v1.3.0.tar.gz && \
  tar xvf v1.3.0.tar.gz && \
  cd RSEM-1.3.0 && \
  make && \
  cp rsem-* $BIN && \
  cp rsem_perl_utils.pm /usr/local/lib/site_perl/ && \
  cd ../ && rm -r RSEM-1.3.0

## Kallisto
  cd $SRC
  wget https://github.com/pachterlab/kallisto/releases/download/v0.43.1/kallisto_linux-v0.43.1.tar.gz && \
  tar xvf kallisto_linux-v0.43.1.tar.gz && \
  mv kallisto_linux-v0.43.1/kallisto $BIN

## FASTQC
  cd $SRC
  wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.5.zip && \
  unzip fastqc_v0.11.5.zip && \
  chmod 755 /usr/local/src/FastQC/fastqc && \
  ln -s /usr/local/src/FastQC/fastqc $BIN/.

## BLAST
  cd $SRC
  wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.5.0/ncbi-blast-2.5.0+-x64-linux.tar.gz && \
  tar xvf ncbi-blast-2.5.0+-x64-linux.tar.gz && \
  cp ncbi-blast-2.5.0+/bin/* $BIN && \
  rm -r ncbi-blast-2.5.0+

## Bowtie2
  cd $SRC
  wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.4.1/bowtie2-2.3.4.1-linux-x86_64.zip/download -O bowtie2-2.3.4.1-linux-x86_64.zip && \
  unzip bowtie2-2.3.4.1-linux-x86_64.zip && \
  mv bowtie2-2.3.4.1-linux-x86_64/bowtie2* $BIN && \
  rm *.zip && \
  rm -r bowtie2-2.3.4.1-linux-x86_64

## Samtools
  wget https://github.com/samtools/samtools/releases/download/1.7/samtools-1.7.tar.bz2 && \
  tar xvf samtools-1.7.tar.bz2 && \
  cd samtools-1.7/ && \
  ./configure && make && make install

## Jellyfish
  wget https://github.com/gmarcais/Jellyfish/releases/download/v2.2.7/jellyfish-2.2.7.tar.gz && \
  tar xvf jellyfish-2.2.7.tar.gz && \
  cd jellyfish-2.2.7/ && \
  ./configure && make && make install

## Salmon
  cd $SRC
  wget https://github.com/COMBINE-lab/salmon/releases/download/v0.9.1/Salmon-0.9.1_linux_x86_64.tar.gz && \
  tar xvf Salmon-0.9.1_linux_x86_64.tar.gz && \
  ln -s $SRC/Salmon-latest_linux_x86_64/bin/salmon $BIN/.

  LD_LIBRARY_PATH=/usr/local/lib
  pip install numpy
  Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("fastcluster", dep = TRUE)'

## patch the RSEM install... need convert-sam-for-rsem  too!
  cd $SRC
  wget https://github.com/deweylab/RSEM/archive/v1.3.0.tar.gz && \
  tar xvf v1.3.0.tar.gz && \
  cd RSEM-1.3.0 && \
  make && \
  cp rsem-* $BIN && \
  cp convert-sam-for-rsem $BIN && \
  cp rsem_perl_utils.pm /usr/local/lib/site_perl/ && \
  cd ../ && rm -r RSEM-1.3.0

## MultiQC
  pip install git+https://github.com/ewels/MultiQC.git

## Trinity
  apt-get update && apt-get install -y cmake rsync
  TRINITY_VERSION="2.8.5"
  TRINITY_CO="d35f3c1149bab077ca7c83f209627784469c41c6"

  cd $SRC
  git clone https://github.com/trinityrnaseq/trinityrnaseq.git && \
  cd trinityrnaseq && \
  git checkout $TRINITY_CO && \
  make && make plugins && \
  make install && \
  cd ../ && rm -r trinityrnaseq

  TRINITY_HOME=/usr/local/bin/trinityrnaseq
  PATH=${TRINITY_HOME}:${PATH}

## Hebbe cluster setup
  mkdir -p /c3se
  mkdir -p /local
  mkdir -p /apps
  mkdir -p /priv
  mkdir -p /usr/share/lmod/lmod
  mkdir -p /var/hasplm
  mkdir -p /var/opt/thinlinc
  mkdir -p /usr/lib64
  touch /usr/lib64/libdlfaker.so
  touch /usr/lib64/libvglfaker.so
  touch /usr/bin/nvidia-smi

%environment
  export SRC=/usr/local/src
  export BIN=/usr/local/bin
  export R_VERSION=R-3.5.2
  export LD_LIBRARY_PATH=/usr/local/lib
  export TRINITY_VERSION="2.8.5"
  export TRINITY_CO="d35f3c1149bab077ca7c83f209627784469c41c6"
  export TRINITY_HOME=/usr/local/bin/trinityrnaseq
  export PATH=${TRINITY_HOME}:${PATH}

%runscript
  cd $SRC
  exec /bin/bash "$@"

%startscript
  cd $SRC
  exec /bin/bash "$@"
