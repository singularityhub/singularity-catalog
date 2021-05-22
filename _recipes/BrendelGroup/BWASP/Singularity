bootstrap: docker
From: ubuntu:20.04

%help
    This container provides portable & reproducible components for BWASP:
    Bisulfite-seq data Workflow Automation Software and Protocols from the Brendel Group.
    Please see https://github.com/BrendelGroup/BWASP for complete documentation.

%post
    export DEBIAN_FRONTEND=noninteractive
    apt -y update
    apt -y install bc git pigz tcsh unar unzip zip wget tzdata \
                   build-essential \
                   openjdk-11-jre-headless \
                   python3-pip python3-pycurl python3-yaml python3-pandas \
                   cpanminus
    # Make sure "python" is found:
    ln -s /usr/bin/python3 /usr/bin/python


    echo 'Installing HTSLIB from http://www.htslib.org/ '
    ######
    ##### Prerequisites
    apt -y install libcurl4-openssl-dev zlib1g-dev libbz2-dev liblzma-dev
    ##### Install
    cd /opt
    git clone git://github.com/samtools/htslib.git htslib
    cd htslib
    git submodule update --init --recursive
    make && make install && make clean

    echo 'Installing SAMTOOLS from http://www.htslib.org/ '
    ######
    ##### Prerequisites
    apt -y install ncurses-dev
    ##### Install
    cd /opt
    git clone git://github.com/samtools/samtools.git samtools
    cd samtools
    make && make install && make clean

    echo 'Installing Bowtie2 from https://github.com/BenLangmead/bowtie2 '
    ######
    cd /opt
    wget --content-disposition https://github.com/BenLangmead/bowtie2/releases/download/v2.3.5.1/bowtie2-2.3.5.1-linux-x86_64.zip
    unzip bowtie2-2.3.5.1-linux-x86_64.zip

    echo 'Installing BISMARK from http://www.bioinformatics.babraham.ac.uk/projects/bismark/ '
    ######
    ##### Prerequisites
    apt -y install libgd-dev libgd-graph-perl
    ######
    cd /opt
    git clone https://github.com/BrendelGroup/Bismark
    # Note that we are using the slightly modified Brendel Group version of Bismark

    echo 'Installing FastQC from http://www.bioinformatics.babraham.ac.uk/projects/fastqc/ '
    ######
    cd /opt
    wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.8.zip
    unzip fastqc_v0.11.8.zip
    chmod +x FastQC/fastqc

    echo 'Installing SRA Toolkit from https://github.com/ncbi/sra-tools '
    ######
    cd /opt
    wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.10.7/sratoolkit.2.10.7-ubuntu64.tar.gz
    tar -xzf sratoolkit.2.10.7-ubuntu64.tar.gz

    echo 'Installing TRIM_GALORE from http://www.bioinformatics.babraham.ac.uk/projects/trim_galore/ '
    ######
    ##### Prerequisites
    pip3 install cutadapt
    ##### Install
    cd /opt
    wget --content-disposition https://github.com/FelixKrueger/TrimGalore/archive/0.6.3.zip
    unzip TrimGalore-0.6.3.zip

    echo 'Installing GENOMETOOLS from from http://genometools.org/ '
    ######
    ##### Prerequisites
    apt -y install libcairo2-dev libpango1.0-dev
    ##### Install
    cd /opt
    wget http://genometools.org/pub/genometools-1.6.1.tar.gz
    tar -xzf genometools-1.6.1.tar.gz
    cd genometools-1.6.1/
    make && make install && make clean

    echo 'Installing bedtools from https://github.com/arq5x/bedtools2/ '
    ######
    cd /opt
    git clone https://github.com/arq5x/bedtools2.git
    cd bedtools2/
    make && make install && make clean

    echo 'Installing meme from http://meme-suite.org/meme-software/5.3.3/meme_5.3.3.tar.gz '
    ######
    ##### Prerequisites
    apt -y install libexpat-dev libxml2-dev imagemagick
    cpanm File::Which HTML::Template HTML::TreeBuilder JSON
    cpanm XML::Simple XML::Parser::Expat Log::Log4perl Math::CDF
    cpanm XML::Compile::SOAP11 XML::Compile::WSDL11 XML::Compile::Transport::SOAPHTTP
    ##### Install
    cd /opt
    wget https://meme-suite.org/meme/meme-software/5.3.3/meme-5.3.3.tar.gz
    tar -xzf meme-5.3.3.tar.gz
    cd meme-5.3.3
    ./configure --prefix=/opt/meme \
	--enable-build-libxml2 --enable-build-libxslt --with-url="http://meme-suite.org"
    make && make install && make clean

    echo 'Installing AEGeAn from https://github.com/BrendelGroup/AEGeAn/ '
    ######
    cd /opt
    git clone https://github.com/BrendelGroup/AEGeAn.git
    cd AEGeAn/
    make && make install && make clean

    echo 'Installing BWASP from https://github.com/BrendelGroup/BWASP.git '
    ######
    ##### Prerequisites
    apt -y install python3-numpy python3-scipy
    cpanm Getopt::Long Math::BigFloat Array::Split Parallel::Loops
    ##### Install
    cd /opt
    git clone https://github.com/BrendelGroup/BWASP.git

%environment
    export LC_ALL=C
    export PATH=$PATH:/opt/bowtie2-2.3.5.1-linux-x86_64
    export PATH=$PATH:/opt/Bismark
    export PATH=$PATH:/opt/FastQC
    export PATH=$PATH:/opt/sratoolkit.2.10.7-ubuntu64/bin
    export PATH=$PATH:/opt/TrimGalore-0.6.3
    export PATH=$PATH:/opt/meme/bin
    export PATH=$PATH:/opt/BWASP/bin
    export PATH=$PATH:/opt/aspera/cli/bin

    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/

%labels
    Maintainer vpbrendel
    Version v1.0
