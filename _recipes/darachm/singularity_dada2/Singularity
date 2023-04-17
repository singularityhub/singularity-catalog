Bootstrap: docker
From: ubuntu:18.04
#Bootstrap: localimage
#From: ../ubuntu-1804-updated_container/ubuntu.simg

%labels
MAINTAINER darachm

%help

    This container is for providing `dada2` for some bioinformatic pipelines.
    
%post

    apt-get -y update
    apt-get -y install gnupg2 software-properties-common
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
    add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' 

    apt-get -y update
    apt-get -y upgrade
    apt-get -y install git wget g++ gcc-4.8 r-base r-base-dev curl libcurl4-openssl-dev

    Rscript -e 'install.packages("BiocManager"); BiocManager::install()'
    Rscript -e 'BiocManager::install(c("Rcpp","RCurl","Biostrings", "ggplot2", "data.table", "reshape2", "ShortRead", "RcppParallel", "IRanges", "XVector", "BiocGenerics"))'

    wget https://github.com/benjjneb/dada2/archive/v1.10.zip -O dada2_v1.10.zip
    unzip dada2_v1.10.zip
    Rscript -e 'install.packages("dada2-1.10",repos=NULL,type="source",dependencies=c("Depends","Suggests","Imports"))'

%test

    Rscript -e 'library(dada2);'

