Bootstrap: docker
From: continuumio/miniconda3

%help

This file is a singularity definition file to create simg with conda
It starts with a docker image of miniconda continuumio/miniconda3
It allows direct creation of the env by specifying in arguments of the condacreate2sig.sh script
1st arg is image name, 2nd is conda env name and 3rd are apps names (as an array, between " " eg "samtools fastqc, star")
App names should be given as they are present in conda recepies

based on documentation https://singularity.lbl.gov/docs-recipes

%labels
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Maintainer Olivier Kirsh <olivier.kirsh@u-paris.fr>					
	Version v1.6 20220624
	Apptainer 1.0.0

%files
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Copy files for building
	Singularity /setupfile/Singularity

%post
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# What is executed during the build process

# Set conda channels 
	/opt/conda/bin/conda config --add channels defaults
	/opt/conda/bin/conda config --add channels bioconda
	/opt/conda/bin/conda config --add channels conda-forge

# Update conda
	/opt/conda/bin/conda update -n base conda  			## Optionnal. Or specify version

# Install mamba
	/opt/conda/bin/conda install -c conda-forge mamba  
	
# Create conda env
	defname=DEFNAME 						## Set environment name
	/opt/conda/bin/mamba create -n DEFNAME APPS			## package name or python version. 
	/opt/conda/bin/mamba clean --tarballs				## Clean and light weight env

# Export FAIR Files
	cd /setupfile
	/opt/conda/bin/conda list -n DEFNAME > DEFNAME_installed_packages.md
	/opt/conda/bin/conda env export --no-build -n DEFNAME > DEFNAME.yml


%environment
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# set Conda env bin in the PATH	
	export PATH=/opt/conda/envs/DEFNAME/bin:$PATH
	
	
%runscript
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This executes commands
	echo "image startup"
    	exec echo "$@"
