BootStrap: docker
From: continuumio/miniconda:latest
IncludeCmd: yes

%help

%setup

%files

%labels

%environment
	export QORTS_JAR=$(find /opt/conda/share | grep QoRTs.jar)
	export PATH=/sw/salmon-latest_linux_x86_64/bin:$PATH
	export PATH=/sw/subread-1.6.4-Linux-x86_64/bin:$PATH
	export PATH=/opt/conda/bin:$PATH

%post
	umask 0022
	apt update
	apt -y dist-upgrade
	apt -y install build-essential git environment-modules wget
	export PATH=/opt/conda/bin:$PATH
	conda install -c conda-forge -c bioconda -c defaults -c biobuilds -c anaconda bedtools=2.27.1 libgcc=5.2.0 biopython fastqc samtools=1.7 python=3.6 pysam=0.14 pybedtools=0.8.0 star=2.5.4 numpy=1.16.4 pandas=0.23.4 umi_tools qorts
	apt install -y libboost-all-dev libhts-dev libncurses5-dev libtinfo-dev zlib1g-dev lcov
	mkdir -p /sw
	mkdir -p /scratch
	mkdir -p /gpfs
	mkdir -p /lab
	cd /sw && wget https://github.com/COMBINE-lab/salmon/releases/download/v0.14.1/salmon-0.14.1_linux_x86_64.tar.gz && tar -xvzf salmon-0.14.1_linux_x86_64.tar.gz && cd ..
	cd /sw && wget https://sourceforge.net/projects/subread/files/subread-1.6.4/subread-1.6.4-Linux-x86_64.tar.gz && tar -xvzf subread-1.6.4-Linux-x86_64.tar.gz
