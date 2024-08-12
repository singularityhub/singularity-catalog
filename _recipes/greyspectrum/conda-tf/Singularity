Bootstrap:docker
From:centos:7.6.1810

%labels
	MAINTAINER greyspectrum

%environment
	TINI_SUBREAPER=true
	export TINI_SUBREAPER
	LANG=en_US.UTF-8
	PATH=/opt/conda/bin:$PATH

%post
	yum install -y wget bzip2 ca-certificates \
	libglib2.0-0 libxext6 libsm6 libxrender1 \
	git mercurial subversion
	echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
	wget --quiet https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh -O ~/anaconda.sh && \
	/bin/bash ~/anaconda.sh -b -p /opt/conda && \
	rm ~/anaconda.sh
	echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
	echo "conda activate base" >> ~/.bashrc

%runscript
	conda create -y --name renv python=2.7 r-essentials r-base scikit-learn tensorflow joblib rpy2
	conda activate renv
	# python -u myscript.py
	conda deactivate
