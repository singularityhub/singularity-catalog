############################################################
# Singularity to build mutAnalysis container
# Based on Ubuntu 18.04
#   sudo singularity build mutAnalysis.simg Singularity
#   singularity exec mutAnalysis.simg
############################################################

# Set the base format to docker
Bootstrap: docker

# Set the base image to Ubuntu
From: ubuntu:18.04

%labels
	Maintainer Aurélien BIRER <abirer@chu-clermontferrand.fr>
	Version v1.0

%environment
	PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bwa:/usr/local/bam-readcount/bin:
	# Set UTF8 for system
	LANG=en_US.UTF-8
	export LANG
	LC_ALL=en_US.UTF-8
	export LC_ALL
	LC_COLLATE=en_US.UTF-8
	export LC_COLLATE
	LC_TIME=en_US.UTF-8
	export LC_TIME
	LC_MESSAGES=en_US.UTF-8
	export LC_MESSAGES
	LC_MONETARY=en_US.UTF-8
	export LC_MONETARY
	LC_PAPER=en_US.UTF-8
	export LC_PAPER
	LC_MEASUREMENT=en_US.UTF-8
	export LC_MEASUREMENT
	LANGUAGE=en_US.UTF-8
	export LANGUAGE
	LC_CTYPE=en_US.UTF-8
	export LC_CTYPE
	LC_MESSAGES=en_US.UTF-8
	export LC_MESSAGES



%post
	export DEBIAN_FRONTEND=noninteractive

	apt-get update
 	apt-get install --no-install-recommends -y build-essential python3-dev python3-setuptools python3-pip git wget subversion unzip
	
  	#For Resolve encoding problems with docker
  	apt-get update --fix-missing 
   	apt-get install --no-install-recommends -y locales locales-all

	locale-gen en_US.UTF-8
	echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen

	cd /usr/local

	# Install Samtools
	apt-get install -y bzip2 curl zlib1g-dev libncurses5-dev cmake

	export SAMTOOLS_VERSION='1.3.1'

	mkdir samtools
	curl -fsSL https://github.com/samtools/samtools/releases/download/$SAMTOOLS_VERSION/samtools-$SAMTOOLS_VERSION.tar.bz2 | tar -jxC samtools --strip-components=1

	cd samtools
		./configure
		make all all-htslib
		make install install-htslib
	cd ..

	# Install BWA
	git clone https://github.com/lh3/bwa.git
	cd bwa
		make
	cd ..

	# install bam-readcount
	git clone https://github.com/genome/bam-readcount.git
	cd bam-readcount
		cmake ../bam-readcount
		make
	cd ..


	# UPGRADE PIP
	python3 -m pip install wheel
	python3 -m pip install --upgrade pip
	python3 -m pip install -U pip
	python3 -m pip install 'setuptools==47.3.2'
	python3 -m pip install pandas
	python3 -m pip install biopython
	
	export LC_CTYPE=en_US.UTF-8
	export LANG=en_US.UTF-8	

	python3 -m pip install git+https://github.com/CNRResistanceAntibiotic/mutAnalysis.git

	# remove un-necessary packages
	apt autoremove --purge --yes
	apt clean
