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
	conda install -c bioconda -c conda-forge -c defaults bedtools=2.27.1 bwa=0.7.15 macs2=2.1.1.20160309 picard fastqc samtools=1.9 python=2.7 
	# install ataqv...
	apt install -y libboost-all-dev libhts-dev libncurses5-dev libtinfo-dev zlib1g-dev lcov
	mkdir -p sw
	cd /sw && git clone https://github.com/ParkerLab/ataqv && cd ataqv && make install prefix=/usr/local && cd ..
	cd /sw && git clone https://github.com/ParkerLab/cta && cd cta && make install prefix=/usr/local && cd ..
	cd /usr/local/bin && wget http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64.v369/bedGraphToBigWig && chmod a+x bedGraphToBigWig
	cd /usr/local/bin && wget http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64.v369/bedClip && chmod a+x bedClip
	cd /usr/local/bin && wget http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64.v369/bedSort && chmod a+x bedSort
	mkdir -p /scratch
	mkdir -p /gpfs
