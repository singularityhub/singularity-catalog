bootstrap: docker
From: ubuntu:18.04

%help
    This container provides portable & reproducible components for BWASP:
    Bisulfite-seq data Workflow Automation Software and Protocols from Brendel Group.
    Please see https://github.com/BrendelGroup/BWASP for complete documentation.

%post
    apt -y update
    apt -y install build-essential
    apt -y install bc git tcsh tzdata unzip zip wget
    apt -y install cpanminus
    apt -y install openjdk-8-jdk
    apt -y install software-properties-common
    apt -y install libcurl4-openssl-dev
    apt -y install libcurl4-gnutls-dev
    apt -y install libgd-dev
    apt -y install libmariadb-client-lgpl-dev
    apt -y install libpq-dev
    apt -y install libssl-dev
    apt -y install libtbb-dev
    apt -y install libxml2-dev
    apt -y install python-minimal
    apt -y install python-pip
    apt -y install python3-minimal
    apt -y install python3-pip



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
    apt -y install ncurses-dev
    #### Install
    cd /opt
    git clone git://github.com/samtools/samtools.git samtools
    cd samtools
    make && make install

    echo 'Installing BOWTIE2 from http://bowtie-bio.sourceforge.net/bowtie2 '
    ######
    apt -y install bowtie2

    echo 'Installing BISMARK from http://www.bioinformatics.babraham.ac.uk/projects/bismark/ '
    ######
    cd /opt
    git clone https://github.com/BrendelGroup/Bismark
    # Note that we are using the slightly modified Brendel Group version of Bismark

    echo 'Installing FASTQC from http://www.bioinformatics.babraham.ac.uk/projects/fastqc/ '
    #### Install
    cd /opt
    wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.5.zip
    unzip fastqc_v0.11.5.zip
    chmod +x FastQC/fastqc

    echo 'Installing SRATOOLKIT from http://www.ncbi.nlm.nih.gov/books/NBK158900/ '
    ######
    cd /opt
    wget http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.8.2/sratoolkit.2.8.2-ubuntu64.tar.gz
    tar -xzf sratoolkit.2.8.2-ubuntu64.tar.gz

    echo 'Installing TRIM_GALORE from http://www.bioinformatics.babraham.ac.uk/projects/trim_galore/ '
    #### Prerequisites
    pip install --upgrade cutadapt
    #### Install
    cd /opt
    wget http://www.bioinformatics.babraham.ac.uk/projects/trim_galore/trim_galore_v0.4.1.zip
    unzip trim_galore_v0.4.1.zip

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
    apt -y install python-numpy python-scipy
    cpanm --configure-timeout 3600  GD::Graph::lines
    cpanm --configure-timeout 3600  LWP::UserAgent
    cpanm --configure-timeout 3600  Math::Pari
    #### Install
    cd /opt
    git clone https://github.com/BrendelGroup/BWASP.git


    echo 'Installing R'
    #### 
    export DEBIAN_FRONTEND=noninteractive
    add-apt-repository -y ppa:marutter/rrutter3.5
    add-apt-repository -y ppa:marutter/c2d4u3.5
    apt -y update
    apt -y install r-base-core r-base-dev
    R CMD javareconf

    echo 'Installing CRAN packages'
    ######
    apt -y install r-cran-dplyr
    apt -y install r-cran-gplots
    apt -y install r-cran-gridextra
    apt -y install r-cran-pastecs
    apt -y install r-cran-rjava
    apt -y install r-cran-sqldf
    apt -y install r-cran-venneuler
    apt -y install r-cran-rcurl
    apt -y install r-cran-xml2
   
    echo 'Installing other CRAN and Bioconductor packages'
    ######
    echo 'install.packages("R.devices", repos="http://ftp.ussg.iu.edu/CRAN", dependencies=TRUE)'  > R2install
    echo 'source("https://bioconductor.org/biocLite.R")'                                         >> R2install
    echo 'biocLite(c("BiocGenerics", "GenomicRanges", "genomation","methylKit"),ask=FALSE)'      >> R2install

    Rscript R2install

    echo 'Installing BWASPR from https://github.com/BrendelGroup/BWASPR/ '
    ######
    cd /opt
    git clone https://github.com/BrendelGroup/BWASPR.git
    R CMD INSTALL BWASPR


%environment
    export LC_ALL=C
    export PATH=$PATH:/opt/Bismark
    export PATH=$PATH:/opt/FastQC
    export PATH=$PATH:/opt/sratoolkit.2.8.2-ubuntu64/bin
    export PATH=$PATH:/opt/trim_galore_zip
    export PATH=$PATH:/opt/BWASP/bin

    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/

%labels
    Maintainer vpbrendel
    Version v1.0
