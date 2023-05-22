# Generate Kive's default Singularity container to run old pipelines.
Bootstrap: docker
From: centos:7

%label
    MAINTAINER https://github.com/cfe-lab/kive-default-docker

%files
    # Configure pip to avoid a warning.
    root_config /root/.config

    # Install a minimal script to print out version numbers.
    hello-world.sh /hello-world.sh

%post
    cd /root

    yum update -q -y

    echo ======== Installing R ==========
    yum install -q -y epel-release
    yum install -q -y python34 python34-devel python2-devel wget fontconfig R perl
    yum groupinstall -q -y 'development tools'
    Rscript -e 'install.packages(c("ggplot2", "jsonlite"), repos="http://cran.cnr.berkeley.edu", quiet=TRUE)'

    echo ======== Installing bowtie2 =========
    mkdir /root/build
    cd /root/build

    # Install three versions of bowtie2, last one is the default.
    # Have to put links in /usr/local/bin and not binaries to make multiple
    # versions work side by side.
    wget -nv \
        https://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.2.1/bowtie2-2.2.1-linux-x86_64.zip \
        https://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.2.9/bowtie2-2.2.9-linux-x86_64.zip \
        https://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.2.8/bowtie2-2.2.8-linux-x86_64.zip
    for btver in 2.2.1 2.2.9 2.2.8; do
        unzip bowtie2-$btver-linux-x86_64.zip
        rm bowtie2-$btver-linux-x86_64.zip
        mkdir /usr/local/bowtie2-$btver
        cd bowtie2-$btver
        for cmd in bowtie2*; do
            mv $cmd /usr/local/bowtie2-$btver
            ln -s /usr/local/bowtie2-$btver/$cmd /bin/$cmd-$btver
            ln -sf /usr/local/bowtie2-$btver/$cmd /bin/$cmd
        done
        cd ..
        rm -r bowtie2-$btver
    done

    echo ======== Installing Samtools ========
    export SAMTOOLS_VERSION=1.3.1
    cd /root/build

    yum install -q -y ncurses-base zlib-devel bzip2-devel xz-devel ncurses-devel
    wget -nv \
        https://github.com/samtools/bcftools/releases/download/$SAMTOOLS_VERSION/bcftools-$SAMTOOLS_VERSION.tar.bz2 \
        https://github.com/samtools/samtools/releases/download/$SAMTOOLS_VERSION/samtools-$SAMTOOLS_VERSION.tar.bz2
    tar xjf bcftools-$SAMTOOLS_VERSION.tar.bz2
    tar xjf samtools-$SAMTOOLS_VERSION.tar.bz2
    cd bcftools-$SAMTOOLS_VERSION
    make
    make prefix=/usr install
    cd ../samtools-$SAMTOOLS_VERSION
    make
    make prefix=/usr install
    rm -r /root/build

    echo ========== Installing MiCall dependencies ==========
    cd /
    yum install -q -y python2-pip python34-pip

    pip3 install \
        cutadapt==1.11 \
        matplotlib==2.0.2 \
        numpy==1.13.0 \
        python-Levenshtein==0.12.0
    ln -s /bin/cutadapt /bin/cutadapt-1.11
    pip2 install \
        matplotlib==2.0.2 \
        numpy==1.13.0 \
        python-Levenshtein==0.12.0
    rm -r /root/.cache

    mkdir /root/build
    cd /root/build

    echo ========= Installing Hyphy and Gotoh =========
    yum install -q -y openssl-devel libcurl-devel
    wget -nv \
        https://github.com/veg/hyphy/archive/2.2.5.tar.gz \
        https://github.com/cfe-lab/MiCall/archive/v7.6.tar.gz \
        https://github.com/cfe-lab/MiCall/archive/v7.7.0.tar.gz
    tar xzf 2.2.5.tar.gz
    tar xzf v7.6.tar.gz
    tar xzf v7.7.0.tar.gz
    cd hyphy-2.2.5/src/lib
    python2 setup.py install
    cd ../../../MiCall-7.6/micall/alignment
    python2 setup.py install
    cd ../../../MiCall-7.7.0/micall/alignment
    python3 setup.py install

    cd /
    rm -r /root/build
    yum remove -q -y \
        wget \
        python34-devel \
        python2-devel \
        zlib-devel \
        bzip2-devel \
        xz-devel \
        ncurses-devel \
        epel-release
    #yum groupremove -q -y 'development tools'
    #yum autoremove -q -y
    ## Not sure why we have to install R again, but otherwise it disappears.
    #yum reinstall -q -y R
    yum clean all

%environment
    export PATH=/bin:/opt/bowtie2

%runscript
    /hello-world.sh
