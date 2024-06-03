bootstrap:docker
From:fedora

%labels

AUTHOR Yasasvy Nanyam ynanyam@iastate.edu

%environment

    PATH=/crispr-dav:/crispr-dav/Rscripts:$PATH
    export PATH



%post

dnf install -y wget
dnf install -y which
dnf install -y procps
dnf install -y bzip2
dnf install -y gcc
dnf install -y git
dnf install -y redhat-rpm-config
dnf install -y perl
dnf install -y python
dnf install -y java
dnf install -y R
dnf install -y python-devel
dnf install -y cpanminus

#install perl modules
cpanm https://cpan.metacpan.org/authors/id/R/RS/RSAVAGE/Config-Tiny-2.23.tgz 
cpanm https://cpan.metacpan.org/authors/id/J/JM/JMCNAMARA/Excel-Writer-XLSX-0.95.tar.gz 
cpanm https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/JSON-2.94.tar.gz

#install pysamstats
pip install pysam==0.8.4
pip install pysamstats==0.24.3

# install ABRA 
wget https://github.com/mozack/abra/releases/download/v0.97/abra-0.97-SNAPSHOT-jar-with-dependencies.jar \
    -O /usr/local/bin/abra-0.97-SNAPSHOT-jar-with-dependencies.jar

# install BWA
wget https://sourceforge.net/projects/bio-bwa/files/bwa-0.7.15.tar.bz2/download --no-check-certificate -O bwa-0.7.15.tar.bz2 \
	&& tar xvfj bwa-0.7.15.tar.bz2 \
	&& cd bwa-0.7.15 \
	&& make \
	&& mv bwa /usr/local/bin \
	&& cd .. \
	&& rm -r bwa-0.7.15* 

# install samtools
wget https://sourceforge.net/projects/samtools/files/samtools/1.3.1/samtools-1.3.1.tar.bz2/download -O samtools-1.3.1.tar.bz2 \
    && tar xvfj samtools-1.3.1.tar.bz2 \
    && cd samtools-1.3.1 \
    && ./configure --without-curses \
	&& make \
    && mv samtools /usr/local/bin \
	&& cd .. \
	&& rm -r samtools-1.3.1*

# install bedtools
wget https://github.com/arq5x/bedtools2/releases/download/v2.25.0/bedtools-2.25.0.tar.gz \
	&& tar xvfz bedtools-2.25.0.tar.gz \
	&& cd bedtools2 \
	&& make \
	&& mv bin/bedtools /usr/local/bin \
	&& cd .. \
	&& rm -r bedtools*

# install prinseq
wget https://sourceforge.net/projects/prinseq/files/standalone/prinseq-lite-0.20.4.tar.gz/download \
	--no-check-certificate -O prinseq-lite-0.20.4.tar.gz \
	&& tar xvfz prinseq-lite-0.20.4.tar.gz \
	&& mv prinseq-lite-0.20.4/prinseq-lite.pl /usr/local/bin \
	&& chmod +x /usr/local/bin/prinseq-lite.pl \
	&& rm -r prinseq-lite-0.20.4*

# install flash
git clone https://github.com/dstreett/FLASH2.git \
	&& cd FLASH2 \
	&& make \
	&& mv flash2 /usr/local/bin \
	&& cd .. \
	&& rm -r FLASH2

# install R packages
echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
Rscript -e "install.packages('ggplot2')"
Rscript -e "install.packages('naturalsort')"

# clone crispr-dav pipeline
git clone https://github.com/pinetree1/crispr-dav.git \
	&& cp crispr-dav/Docker/conf.txt crispr-dav/Examples/example1 \
	&& cp crispr-dav/Docker/conf.txt crispr-dav/Examples/example2
