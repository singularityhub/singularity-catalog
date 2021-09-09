Bootstrap:docker
From:ubuntu:latest

%labels
MAINTAINER nterhoeven

%setup
mkdir ${SINGULARITY_ROOTFS}/reper
mkdir ${SINGULARITY_ROOTFS}/dependencies
mkdir ${SINGULARITY_ROOTFS}/dependencies/lib
mkdir ${SINGULARITY_ROOTFS}/reper/scripts

%environment
reperDir=/reper
export reperDir

depDir=/dependencies
export depDir

PATH=/reper:$PATH
export PATH

PERL5LIB=/dependencies/lib:$PERL5LIB
export PERL5LIB

TRINITY_HOME=/dependencies/trinityrnaseq-Trinity-v2.4.0
export TRINITY_HOME


%files
reper /reper
reper.conf /reper
scripts/* /reper/scripts/

%post
apt-get update && apt-get dist-upgrade && apt-get -y install wget g++ build-essential unzip libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev libtbb-dev git libipc-run-perl python emacs openjdk-8-jre icedtea-8-plugin bc

cd /dependencies
wget https://github.com/gmarcais/Jellyfish/releases/download/v2.2.6/jellyfish-2.2.6.tar.gz && tar xzf jellyfish-2.2.6.tar.gz && cd jellyfish-2.2.6 && ./configure && make && make install
cd /dependencies
wget https://github.com/trinityrnaseq/trinityrnaseq/archive/Trinity-v2.4.0.tar.gz && tar xzf Trinity-v2.4.0.tar.gz && cd trinityrnaseq-Trinity-v2.4.0 && make && make plugins
cd /dependencies
wget https://github.com/weizhongli/cdhit/releases/download/V4.6.7/cd-hit-v4.6.7-2017-0501-Linux-binary.tar.gz && tar xzf cd-hit-v4.6.7-2017-0501-Linux-binary.tar.gz
cd /dependencies
wget https://github.com/BenLangmead/bowtie2/releases/download/v2.3.2/bowtie2-2.3.2-linux-x86_64.zip && unzip bowtie2-2.3.2-linux-x86_64.zip
cd /dependencies
wget https://github.com/samtools/samtools/releases/download/1.4.1/samtools-1.4.1.tar.bz2 && tar xjf samtools-1.4.1.tar.bz2 && cd samtools-1.4.1 && ./configure && make && make install
cd /dependencies
wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.2.28/ncbi-blast-2.2.28+-x64-linux.tar.gz && tar xzf ncbi-blast-2.2.28+-x64-linux.tar.gz
cd /dependencies
git clone https://github.com/thackl/kmer-scripts.git

cd /dependencies/lib
wget http://search.cpan.org/CPAN/authors/id/M/MS/MSCHILLI/Log-Log4perl-1.49.tar.gz && tar xzf Log-Log4perl-1.49.tar.gz && cd Log-Log4perl-1.49 && perl Makefile.PL && make && make install
cd /dependencies/lib
git clone https://github.com/BioInf-Wuerzburg/perl5lib-Fastq.git && mv perl5lib-Fastq/lib/* .
cd /dependencies/lib
git clone https://github.com/BioInf-Wuerzburg/perl5lib-Fasta.git && mv perl5lib-Fasta/lib/* .
cd /dependencies/lib
git clone https://github.com/thackl/perl5lib-Jellyfish.git && mv perl5lib-Jellyfish/lib/* .
cd /dependencies/lib
wget http://search.cpan.org/CPAN/authors/id/P/PL/PLICEASE/File-Which-1.22.tar.gz && tar xzf File-Which-1.22.tar.gz && cd File-Which-1.22 && perl Makefile.PL && make && make install
cd /dependencies/lib
git clone https://github.com/thackl/perl5lib-Kmer.git && mv perl5lib-Kmer/lib/* .
cd /dependencies/lib
git clone https://github.com/BioInf-Wuerzburg/perl5lib-Verbose.git && mv perl5lib-Verbose/lib/* .
cd /dependencies/lib
git clone https://github.com/thackl/perl5lib-Sam.git && mv perl5lib-Sam/lib/* .

cd /reper
chmod -R ga+rwX /reper
chmod -R ga+rwX /dependencies

%runscript
exec reper "$@"