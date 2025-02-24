Bootstrap:docker
From:nfcore/base

%labels
	MAINTAINER Viktor henmyr <viktor.henmyr@skane.se>
	DESCRIPTION Singularity container for AnnotSV
	VERSION 2.3

%environment
	PATH=/opt/conda/envs/annotsv/bin:/opt/bin/AnnotSV/bin/AnnotSV:$PATH
	export ANNOTSV="/opt/bin/AnnotSV"

%files
    annotsv.yaml /
	
%post
	/opt/conda/bin/conda env create -f /annotsv.yaml
	rm -rf /var/lib/apt/lists/*
	apt -y clean
	apt -y update
    apt -y install libz-dev build-essential cmake libxml2-dev libcurl4-openssl-dev libssl-dev make csh tcsh gzip unzip
	git clone https://github.com/lgmgeo/AnnotSV.git
	cd AnnotSV
	make PREFIX=. install-human-annotation
