Bootstrap: docker
From: ubuntu:20.04

%labels
MAINTAINER darachm

%help

    This container is for providing 'R', fairly basic.

%environment
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8

%post

    sed -i 's/main/main restricted universe/g' /etc/apt/sources.list
    echo 'export DEBIAN_FRONTEND=noninteractive' >> $SINGULARITY_ENVIRONMENT
    ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

    apt-get -qq update
    apt-get -qq install apt-transport-https software-properties-common

    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
    add-apt-repository 'deb [arch=amd64,i386] https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'
    apt-get -qq update

    apt-get -qq install r-base r-base-dev
    apt-get -qq install vim gnupg2 git wget g++ gcc libxml2-dev libssl-dev \
        curl libcurl4-openssl-dev pandoc \
        libfontconfig1-dev libgit2-dev

    apt-get -qq upgrade

    Rscript -e 'install.packages("tidyverse",dependencies=T);'
    Rscript -e 'install.packages("magrittr",dependencies=T);'
    Rscript -e 'install.packages("devtools",dependencies=T);'

%test

    Rscript -e 'library(tidyverse)'
    Rscript -e 'installed.packages();'
