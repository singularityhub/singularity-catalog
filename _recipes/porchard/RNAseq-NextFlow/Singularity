BootStrap: docker
From: continuumio/miniconda:latest
IncludeCmd: yes

%help

%setup

%files

%labels

%environment
	export QORTS_JAR=$(find /opt/conda/share | grep QoRTs.jar)
	export PATH=/opt/conda/bin:$PATH

%post
	umask 0022
	apt update
	apt -y dist-upgrade
	apt -y install build-essential git environment-modules wget
	export PATH=/opt/conda/bin:$PATH
	conda install -c conda-forge -c bioconda -c defaults -c biobuilds -c anaconda bedtools=2.27.1 libgcc=5.2.0 fastqc samtools=1.9 python=3.6 star=2.7.3 qorts
	apt install -y libboost-all-dev libhts-dev libncurses5-dev libtinfo-dev zlib1g-dev lcov
	mkdir -p /sw
	mkdir -p /scratch
	mkdir -p /gpfs
	mkdir -p /lab
