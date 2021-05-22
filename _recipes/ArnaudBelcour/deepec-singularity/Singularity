Bootstrap: docker
From: debian:9

%labels
    Maintainer Belcour A.
    Version v0.0.1
    Description DeepEC Singularity recipe.

%environment
    export PATH=/opt/conda/bin:${PATH}

%post
	apt-get update && \
    apt-get update && apt-get -y upgrade
    apt-get -y install \
    wget \
    git ;\
    mkdir /programs ;\
    cd /programs;\
    git clone https://bitbucket.org/kaistsystemsbiology/deepec.git;\
    cd deepec;\
    wget -c https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh ;\
    /bin/bash Miniconda3-latest-Linux-x86_64.sh -bfp /usr/local ;\
    conda update conda ;\
    conda install python=3.6 ;\
    conda install -c bioconda diamond=0.9.24 ;\
    conda install -c defaults pip=19.0.3 ;\
    conda install -c conda-forge tensorflow=1.5.0 ;\
    pip install pyparsing ;\
    pip install pandas==0.19.2 biopython==1.70 keras==2.1.6 pydot markdown==2.6.11 h5py==2.7.1 mock==2.0.0 scipy==1.1.0 scikit-learn==0.19.0
