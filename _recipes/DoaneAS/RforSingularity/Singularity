Bootstrap: docker
From: bioconductor/release_core2:latest

%setup
mkdir /scratchLocal
mkdir /pbtech_mounts
mkdir /athena
mkdir /cluster001


%environment
R_LIBS_USER="/athena/elementolab/scratch/asd2007/singularity/mylibrary"
export R_LIBS_USER

%post
mkdir -p /athena
mkdir -p /scratchLocal
locale-gen "en_US.UTF-8"
dpkg-reconfigure locales
export LANGUAGE="en_US.UTF-8"
echo 'LANGUAGE="en_US.UTF-8"' >> /etc/default/locale
echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale
mkdir /share /local-scratch /Software /scratch
mkdir /scratchLocal
mkdir /pbtech_mounts
mkdir -p /scratch/data
mkdir -p /scratch/logs
chmod -R 777 /scratch
chmod 777 /tmp
chmod +t /tmp
chmod 777 /Software
apt-get update
apt-get install -y apt-transport-https build-essential cmake curl libsm6 libxrender1 libfontconfig1 wget vim git unzip python-setuptools ruby bc
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9
echo "deb https://cloud.r-project.org/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list
apt-get update
apt-get install -y libcairo2-dev libxt-dev 
apt-get install -y tk8.5
apt-get install -y r-base-dev r-recommended gdebi-core
apt-get install -y libopenblas-dev libcurl4-openssl-dev libopenmpi-dev openmpi-bin openmpi-common openmpi-doc openssh-client openssh-server libssh-dev libcairo2-dev wget vim git libssl-dev libcurl4-openssl-dev nano git cmake gfortran g++ curl wget python autoconf bzip2 libtool libtool-bin python-pip python-dev
apt-get update
apt-get clean
R --slave -e 'install.packages("devtools", repos="https://cloud.r-project.org/")'
R --slave -e 'devtools::install_github("rstudio/tensorflow")'
R --slave -e 'source("https://bioconductor.org/biocLite.R"); biocLite(); biocLite("BSgenome.Hsapiens.UCSC.hg19"); biocLite("BSgenome.Mmusculus.UCSC.mm9"); biocLite("BSgenome.Hsapiens.UCSC.hg19"); biocLite("BSgenome.Hsapiens.UCSC.hg38")'
R --slave -e 'devtools::install_github("GreenleafLab/chromVAR")'
R --slave -e 'install.packages("Cairo", repos="https://cloud.r-project.org/")'
R --slave -e 'install.packages(c("hash", "digest", "data.table"))'
echo "All Set!"

