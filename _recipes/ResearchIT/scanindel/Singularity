Bootstrap: docker
From: ubuntu:16.04

%post
    apt update
    apt -y install wget bzip2 git python2.7 python-pip zlib1g-dev libghc-bzlib-dev liblzma-dev cmake

    #
    # install samtools pipeline
    #

    export PNAME="samtools-bcftools-htslib-1.0_x64-linux"

    cd /tmp
    [ ! -e "${PNAME}.tar.bz2" ] && wget "https://downloads.sourceforge.net/project/samtools/samtools/1.0/${PNAME}.tar.bz2"
    tar -xvf ${PNAME}.tar.bz2

    cd ${PNAME}
    for i in bin include lib share; do
        cp -vr $i /usr
    done

    #
    # install bedtools
    #

    cd /tmp
    [ ! -e "bedtools-2.18.0.tar.gz" ] && wget https://github.com/arq5x/bedtools2/releases/download/v2.18.0/bedtools-2.18.0.tar.gz
    tar -xvf bedtools-2.18.0.tar.gz
    cd bedtools-2.18.0
    make
    cp -rv bin /usr

    #
    # install BWA
    #

    cd /tmp
    [ ! -e "bwa-0.7.10.tar.bz2" ] && wget https://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.10.tar.bz2
    tar -xvf bwa-0.7.10.tar.bz2
    cd bwa-0.7.10
    make
    cp -v bwa /usr/bin

    #
    # install blat binaries
    #

    cd /usr/bin
    for a in gfClient gfServer blat; do
        [ -e $a ] && continue
        rm -f $a
        wget http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/blat/$a
        chmod a+x $a
    done

    #
    # install freebayes
    #

    cd /tmp
    [ ! -d freebayes ] && git clone --recursive https://github.com/ekg/freebayes
    cd freebayes
    make
    make install

    #
    # install inchworm (trinity)
    #

    cd /tmp
    [ ! -d trinityrnaseq ] && git clone https://github.com/trinityrnaseq/trinityrnaseq
    cd trinityrnaseq/Inchworm
    make
    cp -rv bin /usr

    #
    # install required python modules
    #

    python -m pip install pysam==0.7.7 pyvcf==0.6.7 biopython==1.64 scipy==0.14.0 numpy==1.8.1

    #
    # prepare scanindel
    #

    cd /usr/lib
    [ ! -d scanindel ] && git clone https://github.com/cauyrd/scanindel
    chmod a+x scanindel/ScanIndel.py
    ln -rsf scanindel/ScanIndel.py /usr/bin/ScanIndel

%runscript
    exec /usr/bin/ScanIndel $@
