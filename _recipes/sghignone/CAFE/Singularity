Bootstrap: docker
From: continuumio/miniconda3

%help
	Container with Hahn Lab's Computational Analysis of gene Family Evolution (CAFE)
	This installation is based on bioconda CAFE v.4.2.1

%labels
        author Stefano Ghignone
        maintainer sghignone
        name CAFE
        version 4.2.1

%post
        #SET CONDA ENVIRONMENT
        export PATH=/opt/conda/bin:${PATH}
	conda update -y conda
        conda update -n base -c defaults conda
        conda config --add channels conda-forge && \
        conda config --add channels bioconda && \
        conda config --add channels default
        #INSTALL SOFTWARE
        conda install -c bioconda cafe && conda clean -a
