BootStrap: docker
From: continuumio/miniconda3:latest
IncludeCmd: yes

%help

%setup
	#chmod 755 /lab/work/porchard/singularity/archive/snATAC/2021-12-23/snATAC.simg
	cp -r /home/porchard/github/ataqv ${SINGULARITY_ROOTFS}/opt/

%files

%labels

%environment
	export PICARD_JAR=/sw/picard/picard.jar

%post
	umask 0022
	apt --allow-releaseinfo-change update
	apt update
	apt -y dist-upgrade
	mkdir -p /usr/share/man/man1
	apt -y install build-essential git environment-modules wget libboost-all-dev libhts-dev libncurses5-dev libtinfo-dev zlib1g-dev lcov libbz2-dev unzip default-jdk
	export PATH=/opt/conda/bin:$PATH
	conda install -c bioconda bwa=0.7.15
	pip install matplotlib seaborn pandas numpy pygenometracks biopython pysam macs2
	# install ataqv...
	mkdir -p /sw
	cd /sw && mkdir -p samtools && cd samtools && wget https://github.com/samtools/samtools/releases/download/1.14/samtools-1.14.tar.bz2 && bzip2 -d samtools-1.14.tar.bz2 && tar -xvf samtools-1.14.tar && cd samtools-1.14 && ./configure --prefix=/usr/local/ && make && make install
	cd /sw && mkdir -p fastqc && cd fastqc && wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip && unzip fastqc_v0.11.9.zip && chmod a+x /sw/fastqc/FastQC/fastqc && ln -s /sw/fastqc/FastQC/fastqc /usr/local/bin/fastqc
	cd /sw && mkdir -p picard && cd picard && wget https://github.com/broadinstitute/picard/releases/download/2.26.9/picard.jar
	cd /sw && cp -r /opt/ataqv . && cd ataqv && git checkout single-cell && make install prefix=/usr/local && cd ..
	cd /sw && git clone https://github.com/porchard/cta-tmp.git cta && cd cta && make install prefix=/usr/local && cd ..
	mkdir -p /scratch
	mkdir -p /gpfs
