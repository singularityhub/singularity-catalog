Bootstrap: library
From: ubuntu:22.04
Stage: build

# path, BLASTMAT (blast matrices)
%environment
    export PATH=/opt/w3constbin:/opt/jParser:/opt/transChecker:/opt/ncbi-blast-2.13.0+/bin:/opt/aspera/connect/bin:$PATH
    export BLASTMAT=/opt/blastmatrix

%files
    sendgmail_w3const.py /opt
    getblastdb_ncbi.sh /opt
    makeUniVec_blastdb.sh /opt

%runscript

%post
    sed -i.bak -e 's%deb http://archive.ubuntu.com%deb http://linux.yz.yamagata-u.ac.jp%g' /etc/apt/sources.list
    sed -i.bak -e 's%deb http://security.ubuntu.com%deb http://linux.yz.yamagata-u.ac.jp%g' /etc/apt/sources.list
    apt update
    apt -y upgrade
    apt -y install tzdata
    echo Asia/Tokyo > /etc/timezone
    dpkg-reconfigure --frontend noninteractive tzdata
    apt -y install build-essential
    apt -y install autoconf bison libssl-dev libyaml-dev libreadline-dev zlib1g-dev libncurses-dev libffi-dev libgdm1 libgdbm-dev git
    apt -y install wget curl jq pigz lftp rsync
    apt -y install openjdk-17-jre
    # Put base scripts
    mkdir /opt/w3constbin
    mv /opt/*.sh /opt/*.py /opt/w3constbin
    chmod +x /opt/w3constbin/*.sh /opt/w3constbin/*.py
    # Parser, transchecker
    wget https://ddbj.nig.ac.jp/public/ddbj-cib/MSS/Parser_V6.69.tar.gz -O /opt/jparser.tar.gz
    wget https://ddbj.nig.ac.jp/public/ddbj-cib/MSS/transChecker_V2.22.tar.gz -O /opt/transChecker.tar.gz
    cd /opt
    for v in /opt/*.tar.gz; do
    tar xvfz $v
    done
    rm -f jparser.tar.gz transChecker.tar.gz
    sed -i -e 's%PARSER_DIR=./%PARSER_DIR=/opt/jParser%' ./jParser/jParser.sh
    sed -i -e 's%TRANS_DIR=./%TRANS_DIR=/opt/transChecker%' ./transChecker/transChecker.sh
    sed -i -e 's%HEAP_SIZE=128m%HEAP_SIZE=128000m%' ./jParser/jParser.sh ./transChecker/transChecker.sh
    chmod +x ./jParser/jParser.sh ./transChecker/transChecker.sh
    # blast bin
    wget ftp://ftp.ncbi.nih.gov/blast/executables/blast+/2.13.0/ncbi-blast-2.13.0+-x64-linux.tar.gz
    tar xvfz ncbi-blast-2.13.0+-x64-linux.tar.gz
    # blast matrix
    lftp -c "open -u anonymous,tkosuge@nig.ac.jp ftp.ncbi.nih.gov && mirror -v /blast/matrices /opt/blastmatrix && close && quit"
    # aspera connect
    wget -P /root https://d3gcli72yxqn2z.cloudfront.net/downloads/connect/latest/bin/ibm-aspera-connect_4.2.4.265_linux.tar.gz
    wget -P /root https://ak-delivery04-mul.dhe.ibm.com/sar/CMA/OSA/0adrj/0/ibm-aspera-connect_4.1.3.93_linux.tar.gz
    tar xvfz /root/ibm-aspera-connect_4.2.4.265_linux.tar.gz -C /root
    tar xvfz /root/ibm-aspera-connect_4.1.3.93_linux.tar.gz -C /root
    bash /root/ibm-aspera-connect_4.1.3.93_linux.sh
    mv /root/.aspera /root/aspera-413193
    bash /root/ibm-aspera-connect_4.2.4.265_linux.sh
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
