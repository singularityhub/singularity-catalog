Bootstrap: docker
From: continuumio/miniconda3:4.5.4

%help
A Singularity image for chewBBACA v 2.0.16

%labels
Maintainer Kristy Horan
Build 1.1

%post
	export PATH=/opt/conda/bin:$PATH

	conda config --add channels defaults
	conda config --add channels bioconda
	conda config --add channels conda-forge

	conda install shovill

%environment
	export PYTHONNOUSERSITE=NO
        export PYTHONPATH=/opt/conda/lib/python3.6/site-packages

%runscript
        echo " A container for shovill "
        

%test
	export PATH=/opt/conda/bin:$PATH
	shovill --check        


