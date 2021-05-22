bootstrap: docker
From: ubuntu:18.04

%help
    This container provides portable & reproducible components for BWASP:
    Bisulfite-seq data Workflow Automation Software and Protocols from the Brendel Group.
    Please see https://github.com/BrendelGroup/BWASP for complete documentation.

%post
    export DEBIAN_FRONTEND=noninteractive
    apt -y update
    apt -y install bc git tcsh unzip zip wget tzdata \
                   build-essential \
                   openjdk-11-jre-headless \
                   python-minimal  \
                   python3-pip \
                   cpanminus

    echo 'Installing HTSLIB from http://www.htslib.org/ '
    #### Prerequisites
    apt -y install zlib1g-dev libbz2-dev liblzma-dev
    #### Install
    cd /opt
    git clone git://github.com/samtools/htslib.git htslib
    cd htslib
    make && make install

    echo 'Installing SAMTOOLS from http://www.htslib.org/ '
    #### Prerequisites
    apt -y install ncurses-dev libcurl4-openssl-dev
    #### Install
    cd /opt
    git clone git://github.com/samtools/samtools.git samtools
    cd samtools
    make && make install

    echo 'Installing Bowtie2 from https://github.com/BenLangmead/bowtie2 '
    ######
    cd /opt
    wget --content-disposition https://github.com/BenLangmead/bowtie2/releases/download/v2.3.5.1/bowtie2-2.3.5.1-linux-x86_64.zip
    unzip bowtie2-2.3.5.1-linux-x86_64.zip

    echo 'Installing BISMARK from http://www.bioinformatics.babraham.ac.uk/projects/bismark/ '
    #### Prerequisites
    apt -y install libgd-dev libgd-graph-perl
    #####
    cd /opt
    git clone https://github.com/BrendelGroup/Bismark
    # Note that we are using the slightly modified Brendel Group version of Bismark

    echo 'Installing FastQC from http://www.bioinformatics.babraham.ac.uk/projects/fastqc/ '
    #### Install
    cd /opt
    wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.8.zip
    unzip fastqc_v0.11.8.zip
    chmod +x FastQC/fastqc

    echo 'Installing Aspera'
    ######
    wget https://download.asperasoft.com/download/sw/cli/3.9.1/ibm-aspera-cli-3.9.1.1401.be67d47-linux-64-release.sh
    chmod +x ibm-aspera-cli-3.9.1.1401.be67d47-linux-64-release.sh
    sed  -ie 's/~\/\.aspera/\/opt\/aspera/' ibm-aspera-cli-3.9.1.1401.be67d47-linux-64-release.sh
    ./ibm-aspera-cli-3.9.1.1401.be67d47-linux-64-release.sh

    echo 'Installing SRA Toolkit from https://github.com/ncbi/sra-tools '
    ######
    cd /opt
    wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.9.6-1/sratoolkit.2.9.6-1-ubuntu64.tar.gz
    tar -xzf sratoolkit.2.9.6-1-ubuntu64.tar.gz

    echo 'Installing TRIM_GALORE from http://www.bioinformatics.babraham.ac.uk/projects/trim_galore/ '
    #### Prerequisites
    pip3 install cutadapt
    #### Install
    cd /opt
    wget --content-disposition https://github.com/FelixKrueger/TrimGalore/archive/0.6.3.zip
    unzip TrimGalore-0.6.3.zip

    echo 'Installing GENOMETOOLS from from http://genometools.org/ '
    #### Prerequisites
    apt -y install libcairo2-dev libpango1.0-dev
    #### Install
    cd /opt
    wget http://genometools.org/pub/genometools-1.5.10.tar.gz
    tar -xzf genometools-1.5.10.tar.gz
    cd genometools-1.5.10/
    make && make install

    echo 'Installing AEGeAn from https://github.com/BrendelGroup/AEGeAn/ '
    ######
    cd /opt
    git clone https://github.com/BrendelGroup/AEGeAn.git
    cd AEGeAn/
    make && make install

    echo 'Installing BWASP from https://github.com/BrendelGroup/BWASP.git '
    #### Prerequisites
    apt -y install python3-numpy python3-scipy
    cpanm Getopt::Long Math::BigFloat Array::Split Parallel::Loops

    #### Install
    cd /opt
    git clone https://github.com/BrendelGroup/BWASP.git

%environment
    export LC_ALL=C
    export PATH=$PATH:/opt/bowtie2-2.3.5.1-linux-x86_64
    export PATH=$PATH:/opt/Bismark
    export PATH=$PATH:/opt/FastQC
    export PATH=$PATH:/opt/sratoolkit.2.9.6-1-ubuntu64/bin
    export PATH=$PATH:/opt/TrimGalore-0.6.3
    export PATH=$PATH:/opt/BWASP/bin
    export PATH=$PATH:/opt/aspera/cli/bin

    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/

%labels
    Maintainer vpbrendel
    Version v1.0
