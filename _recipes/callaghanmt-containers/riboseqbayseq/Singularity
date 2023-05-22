Bootstrap: docker
From: ubuntu:16.04

%post

apt-get -y update && apt-get install -y apt-utils

apt-get install -y build-essential

apt-get install -y gfortran
apt-get install -y libopenblas-base
apt-get install -y wget
apt-get install -y ed
apt-get install -y nano
apt-get install -y git-all
apt-get install -y software-properties-common #required for apt-add-repository
apt-get -y update
apt-get -y install libcurl4-openssl-dev libxml2-dev

#Set correct locale for R
apt-get -y update && apt-get install -y locales
locale-gen en_GB.UTF-8
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

# Install R
echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | tee -a /etc/apt/sources.list
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | apt-key add -
apt-get -y update
apt-get -y install r-base r-base-dev

#Install R packages
Rscript -e 'install.packages("RCurl")'
Rscript -e 'install.packages("XML")'
Rscript -e 'source("https://bioconductor.org/biocLite.R");biocLite("riboSeqR")'
Rscript -e 'source("https://bioconductor.org/biocLite.R");biocLite("baySeq")'

#Set stub /nobackup directory for Singularity

mkdir -p /nobackup
