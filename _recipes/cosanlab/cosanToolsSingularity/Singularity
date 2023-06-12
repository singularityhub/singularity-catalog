#COSANLAB SINGULARITY BOOTSTRAP SPEC
#MAINTAINER ESHIN JOLLY <eshin.jolly.gr@dartmouth.edu>

Bootstrap: docker
From: ubuntu:xenial-20161213

%labels
	Maintainer eshin.jolly.gr@dartmouth.edu

%post
	# Install required system packages
	apt-get update --fix-missing && apt-get install -y eatmydata
	eatmydata apt-get install -y wget bzip2 ca-certificates \
	    libglib2.0-0 libxext6 libsm6 libxrender1 libfreetype6-dev \
	    git \
	    mercurial \
	    subversion \
	    curl grep sed \
	    dpkg \
	    graphviz \
	    vim nano \
	    libgl1-mesa-glx \
	    ffmpeg \
	    fonts-liberation \
	    build-essential \
	    gcc \
	    pkg-config \
	    ca-certificates \
	    xvfb \
	    autoconf \
	    libtool

	# Add Neurodebian package repositories (i.e. for FSL)
	curl -sSL http://neuro.debian.net/lists/trusty.us-nh.full >> /etc/apt/sources.list.d/neurodebian.sources.list && \
	    apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9 && \
	    apt-get update

	#######################
	### Setup Anaconda ####
	#######################

	# Download and install
	echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
	    wget --quiet https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh -O ~/anaconda.sh && \
	    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
	    rm ~/anaconda.sh

	# Setup path for further installs below
	export PATH="/opt/conda/bin:$PATH"

	# Conda > 5.0.0 uses 3 new compiler packages vs old single 'gcc'
	conda install -y gcc_linux-64 gxx_linux-64 gfortran_linux-64
	conda update -y --all

	# Set the appropriate Matplotlib backend by specifying an rc file and setting the environment variable to search for it
    mkdir /opt/matplotlib
    echo "backend: Agg" > /opt/matplotlib/matplotlibrc
	export MATPLOTLIBRC=/opt/matplotlib

	###################
	### Setup ANTS ####
	###################

	# Download and install (NeuroDocker build)
	ANTSPATH="/usr/lib/ants"
	mkdir -p $ANTSPATH && \
	    curl -sSL "https://dl.dropbox.com/s/2f4sui1z6lcgyek/ANTs-Linux-centos5_x86_64-v2.2.0-0740f91.tar.gz" \
	    | tar -xzC $ANTSPATH --strip-components 1

	# Setup path
	export PATH=$ANTSPATH:$PATH

	#################
	## Setup FSL ####
	#################

	# Install
	apt-get install -y fsl-core && \
	    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

	########################################
	## Setup Additional Python packages ####
	########################################

	pip install \
	    hypertools nibabel nipy dask mne pynv nipype nltools
    pip install git+https://github.com/cosanlab/cosanlab_preproc

	#############################################################
	## Setup for Discovery cluster file system overlay issue ####
	#############################################################

	# Make folders necessary for proper Discovery file system overlay
    mkdir -p /afs /inbox /ihome /opt /idata /environment
    chmod a+rX /afs /inbox /ihome /opt /idata /environment
    chmod a+rwX -R /opt

%environment
	export PATH=/opt/conda/bin:$PATH
	export PATH=/usr/lib/ants:$PATH
	export ANTSPATH=/usr/lib/ants
	export PYTHONPATH=/opt/conda/lib/python2.7/site-packages
	export MATPLOTLIBRC=/opt/matplotlib
	export FSLDIR=/usr/share/fsl/5.0
	export FSLOUTPUTTYPE=NIFTI_GZ
	export PATH=/usr/lib/fsl/5.0:$PATH
	export FSLMULTIFILEQUIT=TRUE
	export POSSUMDIR=/usr/share/fsl/5.0
	export LD_LIBRARY_PATH=/usr/lib/fsl/5.0:$LD_LIBRARY_PATH
	export FSLTCLSH=/usr/bin/tclsh
	export FSLWISH=/usr/bin/wish
	export FSLOUTPUTTYPE=NIFTI_GZ
	export LANG=C.UTF-8
	export LC_ALL=C.UTF-8

%runscript
	    echo "YOU are the singularity...."
	    /bin/bash
