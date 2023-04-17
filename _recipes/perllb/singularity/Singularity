Bootstrap:docker
From:nfcore/base

%labels
	MAINTAINER Per Brattås <per.brattas@med.lu.se>
	DESCRIPTION Container for various sequence analysis sw
	VERSION 0.0.1

%environment
	PATH=/opt/bin:/opt/conda/envs/rnatools/bin/:$PATH

%setup
	cp -R /fs1/resources/ref/hg38/gtf/gencode.v33.annotation.gtf.gz  ${SINGULARITY_ROOTFS}/opt
	cp -R /fs1/resources/ref/hg38/data/star_refGenome_index/star_ref_index ${SINGULARITY_ROOTFS}/opt

	
%files
	/data/bnf/sw/bcl2fastq2-v2.20.0.422-Source.tar.gz /opt   
	environment.yml /
	
%post
	rm -rf /var/lib/apt/lists/*
	apt -y clean
	apt -y update
	apt -y install libz-dev build-essential gettext cmake libxml2-dev libcurl4-openssl-dev libssl-dev make libbz2-dev libboost-dev python3-pip sudo

	mkdir -p /usr/share/man/man1

	/opt/conda/bin/conda env create -f /environment.yml
	
	# Setup multiqc
	pip3 install multiqc

	# Setup Umi_tools
	pip3 install Cython
	pip3 install umi_tools
	

	
	   