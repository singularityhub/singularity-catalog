bootstrap: docker
From: ubuntu:18.04

%help
    This container provides portable & reproducible components for TSRchitect,
    including upstream components for read quality control and mapping.

%post
    apt -y update
    apt -y install build-essential
    apt -y install bc curl git tcsh unzip zip wget
    apt -y install automake
    apt -y install cpanminus
    apt -y install cython cython3
    apt -y install openjdk-8-jdk
    apt -y install software-properties-common
    apt -y install zlib1g-dev libbz2-dev liblzma-dev
    apt -y install libcairo2-dev libpango1.0-dev
    apt -y install libcurl4-openssl-dev
    apt -y install libcurl4-gnutls-dev
    apt -y install libgd-dev
    apt -y install libgtextutils-dev
    apt -y install libmariadb-client-lgpl-dev
    apt -y install libncurses-dev
    apt -y install libpq-dev
    apt -y install libssl-dev
    apt -y install libtool
    apt -y install libtbb-dev
    apt -y install libxml2-dev
    apt -y install libbz2-dev
    apt -y install m4
    apt -y install parallel
    apt -y install python-minimal
    apt -y install python-pip
    apt -y install python3-minimal
    apt -y install python3-pip
    apt -y install openmpi-bin openmpi-common openssh-client openssh-server
    apt -y install libopenmpi-dev

    cd /opt
    mkdir bin

###
# Utilities
#
    apt -y install python-numpy python-scipy
    apt -y install python3-numpy python3-scipy
    pip3 install --upgrade dinopy HTSeq

# genometools:
#
    echo 'Installing GENOMETOOLS from from http://genometools.org/ '
    cd /opt
    wget http://genometools.org/pub/genometools-1.5.10.tar.gz
    tar -xzf genometools-1.5.10.tar.gz
    cd genometools-1.5.10/
    make && make install
    cd ..

# fastq-multx:
#
    echo 'Installing fastx_multx from https://github.com/brwnj/fastq-multx.git '
    git clone https://github.com/brwnj/fastq-multx.git
    cd fastq-multx/
    make
    cp fastq-multx /usr/local/bin/
    cd ..

# fastx_toolkit:
#
    echo 'Installing fastx_toolkit from https://github.com/agordon/fastx_toolkit.git '
    git clone https://github.com/agordon/fastx_toolkit.git
    cd fastx_toolkit/
    sed -i -e "s/usage();$/usage();exit(1);/" src/fasta_formatter/fasta_formatter.cpp
   ./reconf
   ./configure
   make
   make install
   cd  ..

# SAMTOOLS:
#
    echo 'Installing htslib from http://www.htslib.org/ '
    git clone git://github.com/samtools/htslib.git
    cd htslib
    make && make install
    cd ..

    echo 'Installing samtools from http://www.htslib.org/ '
    git clone git://github.com/samtools/samtools.git
    cd samtools
    make && make install
    cd ..

# NGSUtils:
#
    echo 'Installing NGSutils from http://www.ncbi.nlm.nih.gov/books/NBK158900/ '
    git clone git://github.com/ngsutils/ngsutils.git
    cd ngsutils/
    sed -i -e "s/#pip install cython==0.16/pip install cython==0.26/;" init.sh
    make
    cd bin
    \cp * /opt/bin
    cd ../..

# SRATOOLKIT:
#
    echo 'Installing SRATOOLKIT from https://www.ncbi.nlm.nih.gov/books/NBK158900/ '
    wget ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.9.1-1/sratoolkit.2.9.1-1-ubuntu64.tar.gz
    tar -xzf sratoolkit.2.9.1-1-ubuntu64.tar.gz


###
# Evaluation and trimming of reads:
#

# FASTQC:
#
    echo 'Installing FASTQC from https://www.bioinformatics.babraham.ac.uk/projects/fastqc/ '
    wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip
    unzip fastqc_v0.11.9.zip
    chmod a+x FastQC/fastqc

# TRIM_GALORE:
    echo 'Installing TRIM_GALORE from http://www.bioinformatics.babraham.ac.uk/projects/trim_galore/ '
    #### Prerequisites
    pip install --upgrade cutadapt
    ### Install
    wget --content-disposition https://github.com/FelixKrueger/TrimGalore/archive/0.6.6.zip
    unzip TrimGalore-0.6.6.zip
    cp TrimGalore-0.6.6/trim_galore /opt/bin


# TagDust:
#
    echo 'Installing TagDust from https://sourceforge.net/projects/tagdust/files/latest/download '
    mkdir TagDust
    cd TagDust 
    wget --content-disposition https://sourceforge.net/projects/tagdust/files/tagdust-2.33.tar.gz/download
    tar -xzf tagdust-2.33.tar.gz 
    cd tagdust-2.33/
    ./configure
    make
    make install
    cd ../..


# TRIMMOMATIC:
#
     wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip
     unzip Trimmomatic-0.39.zip
#    Use:	java -jar /opt/Trimmomatic-0.39/trimmomatic-0.39.jar


###
# Read mapping tools:
#

# BOWTIE:
    apt -y install bowtie

# BOWTIE2:
    apt -y install bowtie2

# BWA:
    echo 'Installing bwa from https://sourceforge.net/projects/bio-bwa/files/bwa-0.7.17.tar.bz2/download '
    wget --content-disposition https://sourceforge.net/projects/bio-bwa/files/bwa-0.7.17.tar.bz2/download
    tar -xjf bwa-0.7.17.tar.bz2
    cd bwa-0.7.17/
    make
    cp bwa /opt/bin/
    cd ../

# HISAT2:
    echo 'Installing hisat2 from https://github.com/infphilo/hisat2/archive/0f01dc6397a.tar.gz '
    wget https://github.com/infphilo/hisat2/archive/0f01dc6397a.tar.gz
    tar -xzf 0f01dc6397a.tar.gz
    mv hisat2-0f01dc6397a hisat2-2.1.0
    cd hisat2-2.1.0
    make
    ls -lt
    cp hisat2 /opt/bin
    cd ../

# STAR:
    echo 'Installing STAR from https://github.com/alexdobin/STAR.git '
    git clone https://github.com/alexdobin/STAR.git
    cd STAR
    cd source
    make STAR
    cp STAR /opt/bin
    cd ../..


###
# Spliced alignment tools:
#
    echo 'Installing GeneSeqer spliced aligner '
    git clone https://github.com/BrendelGroup/GeneSeqer.git
    cd GeneSeqer/src
    make linux
    make clean
    cp makefile.lnxMPI makefile.lnxMPIorig
    sed -e "s/^#MPICC/MPICC/" makefile.lnxMPI | sed -e "0,/^MPICC/s/^MPICC/#MPICC/" > makefile.lnxMPIu
    make -f makefile.lnxMPIu
    make clean
    make install
    cd ../..


###
# Motif identification:
#

# GHOSTSCRIPT:
#
    echo 'Installing ghostscript from https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9533/ghostscript-9.53.3-linux-x86_64.tgz '
    wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9533/ghostscript-9.53.3-linux-x86_64.tgz
    tar -xzf ghostscript-9.53.3-linux-x86_64.tgz
    chown -R root:root ghostscript-9.53.3-linux-x86_64
    cd ghostscript-9.53.3-linux-x86_64
    chmod a+x gs-9533-linux-x86_64
    cp gs-9533-linux-x86_64 /opt/bin/gs
    cd ../

# MEME:
#
    echo 'Installing meme from http://meme-suite.org/meme-software/5.2.0/meme_5.2.0.tar.gz '
    wget http://meme-suite.org/meme-software/5.2.0/meme-5.2.0.tar.gz
    tar -xzf meme-5.2.0.tar.gz
    cd meme-5.2.0
    ./configure --prefix=/opt/meme \
	--enable-build-libxml2 --enable-build-libxslt --with-url="http://meme-suite.org"
    make
#    make test
    make install
    cd ../
    
# WEBLOGO:
#
    echo 'Installing weblogo from http://weblogo.berkeley.edu/release/weblogo.2.8.2.tar.gz '
    wget http://weblogo.berkeley.edu/release/weblogo.2.8.2.tar.gz
    tar -xzf weblogo.2.8.2.tar.gz 

# HOMER:
    echo 'Installing home from http://homer.salk.edu/homer/configureHomer.pl '
    mkdir HOMER; cd HOMER
    wget http://homer.salk.edu/homer/configureHomer.pl
    cpanm HTML::Template
    cpanm JSON
    cpanm XML::Simple
    cpanm XML::Compile::SOAP11
    cpanm XML::Compile::WSDL11
    cpanm XML::Compile::Transport::SOAPHTTP
    cpanm Log::Log4perl
    cpanm Math::CDF
    pip install --upgrade networkx
    perl configureHomer.pl -install homer
    chmod -R a+w data
    cd ../


###
# R and R packages, including TSRchitect
#
    echo 'Installing R 3.5'
    export DEBIAN_FRONTEND=noninteractive
    add-apt-repository -y ppa:marutter/rrutter3.5
    add-apt-repository -y ppa:marutter/c2d4u3.5
    apt -y update
    apt -y install r-base-core r-base-dev
    R CMD javareconf

    echo 'Installing CRAN packages'
    ######
    apt -y install r-cran-biocmanager
    apt -y install r-cran-dplyr
    apt -y install r-cran-gplots
    apt -y install r-cran-gridextra
    apt -y install r-cran-pastecs
    apt -y install r-cran-sqldf
    apt -y install r-cran-venneuler
    apt -y install r-cran-rcurl
    apt -y install r-cran-readxl
    apt -y install r-cran-statmod
    apt -y install r-cran-xml2

    echo 'Installing other CRAN and Bioconductor packages'
    ######
    echo 'BiocManager::install(c("BiocGenerics", "GenomicRanges", "genomation","TSRchitect"), ask=FALSE)'     > R2install
    echo 'BiocManager::install(c("bumphunter","seqLogo","ENCODExplorer"),                     ask=FALSE)'    >> R2install
    echo 'BiocManager::install(c("edgeR","R2HTML"),                                           ask=FALSE)'    >> R2install

    Rscript R2install
    
# Use the git repository only for installation of a TSRchitect version not yet in Bioconductor:
#
    git clone https://github.com/BrendelGroup/TSRchitect.git
    R CMD INSTALL TSRchitect


%environment
    export LC_ALL=C
    export PATH=$PATH:/opt/bin
    export PATH=$PATH:/opt/FastQC
    export PATH=$PATH:/opt/HOMER/bin
    export PATH=$PATH:/opt/meme/bin
    export PATH=$PATH:/opt/sratoolkit.2.9.1-1-ubuntu64/bin

    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/:/usr/lib64/openmpi/lib

%labels
    Maintainer vpbrendel
    Version v1.0
