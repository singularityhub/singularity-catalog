Bootstrap:docker
From:nfcore/base

%labels
	MAINTAINER Viktor henmyr <viktor.henmyr@skane.se>
	DESCRIPTION Singularity container for CADD 1.5 GRCh38
	VERSION 0.0.1

%environment
#	export TMPDIR=/data/tmp # test might inherit host environment TMPDIR
%files
	/trannel/cadd_1.5_hg38 /opt/cadd/
	cadd.patch /
%post
	/opt/conda/bin/conda env create -f /opt/cadd/src/environment_v1.5.yml
	/opt/conda/bin/conda clean -a
	patch /opt/cadd/CADD.sh cadd.patch