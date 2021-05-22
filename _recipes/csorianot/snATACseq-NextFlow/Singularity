BootStrap: docker
From: continuumio/miniconda:latest
IncludeCmd: yes

%help

%setup

%files

%labels

%environment
	export PICARD_JAR=$(find /opt/conda/share | grep picard.jar)

%post
	umask 0022
	apt update
	apt -y dist-upgrade
	apt -y install build-essential git environment-modules wget
	export PATH=/opt/conda/bin:$PATH
	conda install -c conda-forge -c bioconda -c defaults bedtools=2.27.1 biopython bwa=0.7.15 picard fastqc samtools=1.9 python=3.6 pysam=0.14 pybedtools=0.8.0 
	# install ataqv...
	apt install -y libboost-all-dev libhts-dev libncurses5-dev libtinfo-dev zlib1g-dev lcov
	mkdir -p sw
	cd /sw && git clone https://github.com/ParkerLab/ataqv && cd ataqv && make install prefix=/usr/local && cd ..
	cd /sw && git clone https://github.com/porchard/cta && cd cta && make install prefix=/usr/local && cd ..
	mkdir -p /scratch
