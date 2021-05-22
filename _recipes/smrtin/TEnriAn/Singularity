Bootstrap: docker
From: ubuntu:18.04



%environment
export DEBIAN_FRONTEND=noninteractive

## set up tool config and deployment area:

export SRC=/usr/local/src
export BIN=/usr/local/bin
export LD_LIBRARY_PATH=/usr/local/lib
export PICARD_HOME=/usr/local/src


export LANG="en_US.utf8"
export LC_ALL="en_US.utf8"
export LANGUAGE="en_US.utf8"

export PATH=/opt/Orthograph:$PATH

%post

## update ubuntu installation and add software

apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y wget gcc g++ python3 automake make \
git curl checkinstall libdb-dev zlib1g zlib1g-dev bzip2 libncurses5-dev texlive-latex-base \
python3-pip python3-dev python3-setuptools python3-distutils \
gfortran build-essential libghc-zlib-dev libncurses-dev libbz2-dev liblzma-dev libpcre3-dev libxml2-dev \
libblas-dev gfortran git unzip ftp libzmq3-dev nano ftp fort77 libreadline-dev \
libcurl4-openssl-dev libx11-dev libxt-dev \
x11-common libcairo2 libcairo2-dev libpng-dev libreadline-dev libjpeg-dev pkg-config libtbb-dev \
cmake rsync libssl-dev tzdata locales cython3 openjdk-8-jre openjdk-8-jdk openjdk-8-demo openjdk-8-doc openjdk-8-jre-headless openjdk-8-source rsem libxext6 libsm6 libxrender1 \
libncursesw5-dev libboost-all-dev  cereal libcereal-dev libgff-dev apt-transport-https ca-certificates gnupg software-properties-common autoconf \
libjemalloc-dev patch libgomp1  \
sqlite sqlite3 libsqlite0 libsqlite3-0 libsqlite3-dev \
perl libfile-which-perl liburi-perl libwww-perl \
vim libglib2.0-0 rsem libopenjp2-7 xorg-dev libtinfo5 libssl-dev --reinstall \
&& apt-get clean \
&& locale-gen en_US.UTF-8

## installing conda 

cd /opt/ && \
    wget -c https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh && \
    /bin/bash Anaconda3-2020.02-Linux-x86_64.sh -bfp /usr/local/ && \
    conda config --file /.condarc --add channels defaults && \
    conda config --file /.condarc --add channels conda-forge && \
    conda update conda && \
    conda list

## software installations with conda

conda install -c conda-forge numpy

#conda install r-essentials r-base
conda install -c r r

conda install -c bioconda trinity=2.8.5 fastp fsa exonerate emboss samtools seqkit blat gmap hisat2 subread star salmon jellyfish bowtie2 blast kallisto fastqc rsem htseq mafft hmmer=3.3.1

pip3 install git+https://github.com/ewels/MultiQC.git

## Picard tools

cd /usr/local/src
wget https://github.com/broadinstitute/picard/releases/download/2.20.3/picard.jar

## Perl stuff
conda install -c bioconda perl-dbi perl-digest-sha perl-data-dumper perl-file-path perl-file-spec perl-file-temp perl-findbin perl-getopt-long perl-list-util perl-time-hires perl-parallel-forkmanager perl-autodie perl-archive-tar perl-carp perl-dbd-sqlite

#some modules are installed with cpanminus
conda install -c bioconda perl-app-cpanminus 
cd /opt/ \
&& cpanm install URI::Escape strict warnings Benchmark File::Basename 

## Orthograph

cd /opt/
git clone https://github.com/mptrsen/Orthograph.git


%runscript
cd /opt/src
exec /bin/bash "$@"
%startscript
cd /opt/src
exec /bin/bash "$@"

