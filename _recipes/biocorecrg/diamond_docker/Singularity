BootStrap: docker
From: continuumio/miniconda3:4.5.12

%environment
	PATH=/opt/conda/envs/diamond-conda/bin:$PATH
	export PATH

%post
	PATH=/opt/conda/bin:$PATH
	export PATH
	conda env create -f /environment.yml && conda clean -a

%files
	environment.yml

%labels
	Maintainer Biocorecrg
	Version 0.1.0

