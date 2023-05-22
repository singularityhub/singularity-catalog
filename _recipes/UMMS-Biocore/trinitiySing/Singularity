BootStrap: docker
From: ubuntu:16.04

%labels

    AUTHOR Alper Kucukural <alper.kucukural@umassmed.edu>
    Version v1.0

%environment
    export SRC=/usr/local/src
    export BIN=/usr/local/bin
    export R_VERSION=R-3.4.1
    export TRINITY_VERSION="2.5.0"
    export TRINITY_HOME=/usr/local/bin/trinityrnaseq
    export PATH=${TRINITY_HOME}:${PATH}

%post

apt-get update && apt-get install -y gcc g++ perl python automake make \
                                       wget git curl libdb-dev \
                                       zlib1g-dev bzip2 libncurses5-dev \
				       texlive-latex-base \
                                       default-jre \
				       python-pip python-dev \
				       gfortran \
				       build-essential libghc-zlib-dev libncurses-dev libbz2-dev liblzma-dev libpcre3-dev libxml2-dev \
				       libblas-dev gfortran git unzip ftp libzmq3-dev nano ftp fort77 libreadline-dev \
				       libcurl4-openssl-dev libx11-dev libxt-dev \
				       x11-common libcairo2-dev libpng12-dev libreadline6-dev libjpeg8-dev pkg-config libtbb-dev \
                   && apt-get clean

curl -L https://cpanmin.us | perl - App::cpanminus

cpanm install DB_File

cpanm install URI::Escape


## set up tool config and deployment area:

export SRC=/usr/local/src
export BIN=/usr/local/bin


#####
# Install R

export R_VERSION=R-3.4.1

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
Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("goseq", dep = TRUE)'
Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("Glimma", dep = TRUE)'
Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("ROTS", dep = TRUE)'
Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("GOplot", dep = TRUE)'
Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("argparse", dep = TRUE)'
Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("sm", dep = TRUE)'


## bowtie
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


## Salmon
cd $SRC
wget https://github.com/COMBINE-lab/salmon/releases/download/v0.8.2/Salmon-0.8.2_linux_x86_64.tar.gz && \
    tar xvf Salmon-0.8.2_linux_x86_64.tar.gz && \
    ln -s $SRC/Salmon-latest_linux_x86_64/bin/salmon $BIN/.
    


## FASTQC
cd $SRC
wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.5.zip && \
    unzip fastqc_v0.11.5.zip && \
    chmod 755 /usr/local/src/FastQC/fastqc && \
    ln -s /usr/local/src/FastQC/fastqc $BIN/.


# blast
cd $SRC
wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.5.0/ncbi-blast-2.5.0+-x64-linux.tar.gz && \
    tar xvf ncbi-blast-2.5.0+-x64-linux.tar.gz && \
    cp ncbi-blast-2.5.0+/bin/* $BIN && \
    rm -r ncbi-blast-2.5.0+


## Bowtie2
cd $SRC
wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.3.1/bowtie2-2.3.3.1-linux-x86_64.zip/download -O bowtie2-2.3.3.1-linux-x86_64.zip && \
    unzip bowtie2-2.3.3.1-linux-x86_64.zip && \
    mv bowtie2-2.3.3.1-linux-x86_64/bowtie2* $BIN && \
    rm *.zip && \
    rm -r bowtie2-2.3.3.1-linux-x86_64



##########
## Trinity
cd $SRC

export TRINITY_VERSION="2.5.0"

cd $SRC

git clone https://github.com/trinityrnaseq/trinityrnaseq.git && \
    cd trinityrnaseq && \
    git checkout 88bfb01 && \
    make && make plugins && \
    make install && \
    cd ../ && rm -r trinityrnaseq

export TRINITY_HOME=/usr/local/bin/trinityrnaseq

cp $TRINITY_HOME/trinity-plugins/BIN/samtools $BIN

export PATH=${TRINITY_HOME}:${PATH}

    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer

    apt-get -y autoremove

    export JAVA_HOME=/usr/lib/jvm/java-8-oracle
    mkdir /data && cd /data
    curl -s https://get.nextflow.io | bash 
    mv /data/nextflow /usr/bin/.

    mkdir /project /nl /share /.nextflow


