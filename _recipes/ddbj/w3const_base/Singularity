Bootstrap: library
From: ubuntu:22.04
Stage: build

# path, BLASTMAT (blast matrices)
%environment
    export PATH=/home/w3const/systool/ncbitool:/opt/w3constbin:/opt/jParser:/opt/transChecker:/opt/ncbi-blast/bin:/opt/ncbitool:/opt/sratoolkit/bin:/opt/aspera/connect/bin:$PATH
    export BLASTDB=/opt/blastdb
    export BLASTMAT=/opt/blastmatrix

%setup
    echo "Wait for 15 sec to start building the container, or put the ncbi binary tools (e.g. vecscreen) in ./ncbitool directory by yourself if you want to include them in the container." > /dev/null
    sleep 15
    mkdir -p ${SINGULARITY_ROOTFS}/opt/w3constbin
    mkdir -p ${SINGULARITY_ROOTFS}/opt/ncbitool

%files
    curatortool/* /opt/w3constbin
    ncbi-blast-matrices.tar.gz /opt
    ncbitool/* /opt/ncbitool

%runscript

%post
    # sed -i.bak -e 's%deb http://archive.ubuntu.com%deb http://linux.yz.yamagata-u.ac.jp%g' /etc/apt/sources.list
    apt update
    apt -y upgrade
    apt -y install tzdata
    ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
    dpkg-reconfigure --frontend noninteractive tzdata
    apt -y install build-essential
    apt -y install autoconf bison libssl-dev libyaml-dev libreadline-dev zlib1g-dev libncurses-dev libffi-dev libgdm1 libgdbm-dev git bash-completion wget curl jq pigz lftp rsync openjdk-17-jre emboss emboss-data python3-pip rename
    apt -y install postgresql-client postgresql-client-common
    # Put base scripts, binaries
    chmod a+x /opt/w3constbin/*.sh /opt/w3constbin/*.py /opt/ncbitool/*
    #Python module
    pip install biopython
    # Parser, transchecker
    wget ftp://ftp.ddbj.nig.ac.jp/ddbj-cib/MSS/Parser_V*.gz -O /opt/jparser.tar.gz
    wget ftp://ftp.ddbj.nig.ac.jp/ddbj-cib/MSS/transChecker_V*.gz -O /opt/transChecker.tar.gz
    cd /opt
    for v in /opt/*.tar.gz; do
    tar xvfz $v
    done
    rm -f jparser.tar.gz transChecker.tar.gz
    sed -i -e 's%PARSER_DIR=./%PARSER_DIR=/opt/jParser%' ./jParser/jParser.sh
    sed -i -e 's%TRANS_DIR=./%TRANS_DIR=/opt/transChecker%' ./transChecker/transChecker.sh
    sed -i -e 's%DEFAULT_MAX_HEAP=[0-9]\+[MmGg]%DEFAULT_MAX_HEAP=128000m%' ./jParser/jParser.sh ./transChecker/transChecker.sh
    chmod +x ./jParser/jParser.sh ./transChecker/transChecker.sh
    chmod 644 ./jParser/jar/*.jar ./transChecker/jar/*.jar
    # blast bin
    VER=$(curl -s https://ftp.ncbi.nih.gov/blast/executables/blast+/VERSION)
    wget ftp://ftp.ncbi.nih.gov/blast/executables/blast+/${VER}/ncbi-blast-${VER}+-x64-linux.tar.gz
    tar xvfz ncbi-blast-${VER}+-x64-linux.tar.gz
    ln -s ncbi-blast-${VER}+ ncbi-blast
    # blast matrix; changed the method, former=from ncbiftp, current=from dowloaded archive
    # lftp -c "open -u anonymous,tkosuge@nig.ac.jp ftp.ncbi.nih.gov && mirror -v /blast/matrices /opt/blastmatrix && close && quit"
    tar xvfz ncbi-blast-matrices.tar.gz
    mv ncbi-blast-matrices blastmatrix
    rm ncbi-blast-${VER}+-x64-linux.tar.gz ncbi-blast-matrices.tar.gz
    # sra toolkit
    VER=$(curl -s https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current.version)
    wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/${VER}/sratoolkit.${VER}-ubuntu64.tar.gz
    tar xvfz sratoolkit.${VER}-ubuntu64.tar.gz
    ln -s sratoolkit.${VER}-ubuntu64 sratoolkit
    rm sratoolkit.${VER}-ubuntu64.tar.gz
    # aspera connect
    # VER="4.2.12.780"
    # wget -P /root https://ak-delivery04-mul.dhe.ibm.com/sar/CMA/OSA/0c9pt/0/ibm-aspera-connect_${VER}_linux_x86_64.tar.gz
    ASCPLATEST="https://d3gcli72yxqn2z.cloudfront.net/downloads/connect/latest/bin/ibm-aspera-connect_4.2.12.780_linux_x86_64.tar.gz"
    VER=$(echo ${ASCPLATEST} | awk -F'_' '{print $2}')
    wget -P /root ${ASCPLATEST}
    # former aspera to obtain pubkey
    wget -P /root https://ak-delivery04-mul.dhe.ibm.com/sar/CMA/OSA/0adrj/0/ibm-aspera-connect_4.1.3.93_linux.tar.gz
    tar xvfz /root/ibm-aspera-connect_${VER}_linux_x86_64.tar.gz -C /root
    tar xvfz /root/ibm-aspera-connect_4.1.3.93_linux.tar.gz -C /root
    bash /root/ibm-aspera-connect_4.1.3.93_linux.sh
    mv /root/.aspera /root/aspera-413193
    bash /root/ibm-aspera-connect_${VER}_linux_x86_64.sh
    mv /root/.aspera /root/aspera
    mv /root/aspera /opt
    cp -av /root/aspera-413193/connect/etc/asperaweb_id_dsa.openssh /root/aspera-413193/connect/etc/asperaweb_id_dsa.openssh.pub /opt/aspera/connect/etc
    # # NCBI cxx tools
    # wget -P /opt ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools%2B%2B/ARCHIVE/2021/Sep_30_2021/ncbi_cxx--25_2_0.tar.gz
    # FNAME="ncbi_cxx--25_2_0.tar.gz"
    # tar xvfz ${FNAME} && rm -f ${FNAME}
    # cd ${FNAME%%.*}
    # ./configure --with-flat-makefile --without-internal --without-gui
    # cd GCC1130-DebugMT64/build && make -f Makefile.flat app/

%labels
    Author tkosuge
    Version 1
