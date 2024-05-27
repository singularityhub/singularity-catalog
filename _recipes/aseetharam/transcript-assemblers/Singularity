Bootstrap: docker
From: ubuntu:20.04

%labels
   MAINTAINER Arun Seetharam
   EMAIL arnstrm@iastate.edu

%test
    python3 --version
    python3 -c "import numpy"
    mikado --help

%environment
    export PYTHONDONTWRITEBYTECODE=true
    export TRINITY_HOME=/usr/local/bin/trinityrnaseq
    export PATH=$PATH:/usr/local/bin/trinityrnaseq:/usr/local/bin/trinityrnaseq/util

%post

    ### Install your packages ###
    export PYTHONDONTWRITEBYTECODE=true
    apt update
    apt install -y software-properties-common
    add-apt-repository universe
    add-apt-repository multiverse
    add-apt-repository restricted
    DEBIAN_FRONTEND=noninteractive
    apt update
    apt install -y build-essential wget curl git autoconf automake
    apt install -y gcc g++ bison make cmake
    apt install -y perl zlib1g-dev libbz2-dev liblzma-dev libcurl4-gnutls-dev libssl-dev libncurses5-dev liblpsolve55-dev rsync librsync-dev
    apt install -y libboost-dev '^libboost-.*71-dev'
    apt install -y bowtie2 jellyfish salmon samtools
    apt install -y python3 python3-numpy python3-dev python3-scipy python3-pandas python3-pip libtool liblzma-dev

    # Mikado
    pip3 install wheel
    pip3 install python-rapidjson
    pip3 install "Mikado>=2.0"

    # Samtools
    export hts_version=1.11;
    cd /usr/local/src/;
    curl -L https://github.com/samtools/samtools/releases/download/${hts_version}/samtools-${hts_version}.tar.bz2 | tar xj
    cd samtools-${hts_version} && autoreconf && ./configure && make -j 10 && make install

    # Portcullis
    cd /usr/local/src
    export port_version=1.2.2
    curl -L https://github.com/maplesond/portcullis/archive/${port_version}.tar.gz | tar -xz
    cd portcullis-${port_version}
    ./autogen.sh
    ./configure
    make -j 10
    make -j 10 check
    make install

    # Diamond
    export dmd_version=2.0.6
    mkdir -p /usr/local/src/ && cd /usr/local/src
    curl -L https://github.com/bbuchfink/diamond/releases/download/v2.0.6/diamond-linux64.tar.gz | tar -xz -C /usr/local/bin/

    # Prodigal
    export prod_version=2.6.3
    curl -L https://github.com/hyattpd/Prodigal/releases/download/v2.6.3/prodigal.linux > /usr/local/bin/prodigal
    chmod +x /usr/local/bin/prodigal

    # Create global folder
    mkdir -p /global && cd /global

    # strawberry
    cd /usr/local/src
    git clone https://github.com/ruolin/strawberry.git
    cd strawberry && \
      sh cmake.sh && \
      cd build && \
      make && \
      make install
 
    # install class2
    cd /usr/local/src
    wget https://downloads.sourceforge.net/project/splicebox/CLASS-2.1.7.tar.gz
    tar -xf CLASS-2.1.7.tar.gz 
    cd CLASS-2.1.7
    sh build.sh
    chmod +x class junc clnb grader addXS run_class.pl
    mv class junc clnb grader addXS run_class.pl /usr/bin/

    # install psi-calss
    cd /usr/local/src
    curl -L https://github.com/splicebox/PsiCLASS/archive/refs/tags/v1.0.2.tar.gz | tar -xz
    cd PsiCLASS-1.0.2/
    make
    chmod +x psiclass subexon-info combine-subexons classes vote-transcripts junc grader trust-splice addXS add-genename *.pl
    mv psiclass subexon-info combine-subexons classes vote-transcripts junc grader trust-splice addXS add-genename *.pl /usr/bin/
   
    # instll stringtie
    cd /usr/local/src
    git clone https://github.com/gpertea/stringtie
    cd stringtie
    make release
    mv stringtie /usr/bin/
    
    # install cufflinks
    apt-get install -y cufflinks
    
    # trinity
    cd /usr/local/src
    git clone --recursive https://github.com/trinityrnaseq/trinityrnaseq.git  
    cd trinityrnaseq
    make
    make plugins
    sed -i.bak 's/python/python3/g'  util/support_scripts/trinity_installer.py
    make install
    
    # transdecoder
    apt install -y transdecoder

    # orfipy
    pip3 install orfipy
 

%apprun snakemake
	snakemake "@"

%apprun mikado
	mikado "@"

%apprun daijin
    daijin "@"

%apprun prodigal
    prodigal "@"

%apprun samtools
    samtools "@"

%apprun diamond
    diamond "@"

%apprun portcullis
    portcullis "@"

%apprun stringtie
    stringtie "@"

