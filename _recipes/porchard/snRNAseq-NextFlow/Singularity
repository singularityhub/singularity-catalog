BootStrap: docker
From: continuumio/miniconda:latest
IncludeCmd: yes

%help

%setup
	#chmod 755 /lab/work/porchard/singularity/archive/snRNA/2021-12-22/snRNA.simg

%files

%labels

%environment
	export PATH=/opt/conda/bin:$PATH

%post
	umask 0022
	apt --allow-releaseinfo-change update
	apt -y dist-upgrade
	apt -y install build-essential git environment-modules wget libboost-all-dev libhts-dev
	export PATH=/opt/conda/bin:$PATH
	conda install -c conda-forge -c bioconda python=3.8 fastqc samtools=1.9 star=2.7.3
	pip install pysam numpy scipy pandas matplotlib seaborn
	mkdir -p /sw
	mkdir -p /scratch
	mkdir -p /gpfs
	mkdir -p /lab
