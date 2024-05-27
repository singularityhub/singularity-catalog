Bootstrap: debootstrap
OSVersion: xenial
MirrorURL: http://us.archive.ubuntu.com/ubuntu/

###############################################################
# Command used to build:
# sudo singularity build lahontan.simg Singularity
###############################################################

%labels
    MAINTAINER Alberto Nava
    VERSION v1.0

%post
    locale-gen en_US.UTF-8

    echo "Installing necessary packages..."
    echo "deb http://us.archive.ubuntu.com/ubuntu/ xenial universe" >> /etc/apt/sources.list
    apt-get update && apt-get install --yes git cmake gcc g++ libncurses-dev libhdf5-cpp-11 libhdf5-dev python3-docopt vim unzip openjdk-8-jdk-headless wget gfortran libbz2-dev liblzma-dev libpcre++-dev libcurl4-openssl-dev libssl-dev pandoc texlive-latex-extra libxml2-dev libmariadb-client-lgpl-dev libreadline6-dev libreadline6 libtbb-dev bzip2

    cd /opt
    wget https://cran.r-project.org/src/base/R-3/R-3.4.3.tar.gz
    tar xzf R-3.4.3.tar.gz
    cd R-3.4.3
    ./configure --with-x=no 
    make && make install
    R -e 'source("https://bioconductor.org/biocLite.R");biocLite(ask=FALSE);biocLite(c("devtools","DESeq2","edgeR","ReportingTools","regionReport","pachterlab/sleuth","ballgown","DT","pheatmap"));devtools::install_github(c("docopt/docopt.R","alyssafrazee/RSkittleBrewer"))'
    
    echo "Cloning repository..."
    git clone --recursive https://github.com/UNR-CFB/lahontan.git /lahontan

    echo "Installing pipeline..."
    cd /lahontan
    echo 'export RNASEQDIR=/lahontan/bin' >> $SINGULARITY_ENVIRONMENT
    /lahontan/lib/autoSetup.sh

    ln -s /usr/local/bin/R /lahontan/bin/R
    ln -s /usr/local/bin/Rscript /lahontan/bin/Rscript

%environment
    RNASEQDIR=/lahontan/bin
    PATH="${PATH}:/lahontan/bin:/lahontan/lib"
    LANG=en_US.UTF-8
    LANGUAGE=en_US
    export RNASEQDIR PATH LANG LANGUAGE

%help
    Go to https://github.com/UNR-CFB/lahontan for more help OR try "./lahontan.simg -h" for pipeline help

%runscript
    exec /lahontan/lib/lahontan "$@"
