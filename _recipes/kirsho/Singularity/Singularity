Bootstrap: docker
From: continuumio/miniconda3

# This file is a singularity definition file to create simg with conda
# It starts with a docker image of miniconda continuumio/miniconda3
# It allows direct creation of the env by specifying which package or with a .yml file
# unlock desired method by removing # and set variable (defname) or file name (xxxx.yml) 
# future dev: if else, yml or package names as argument for $ singularity build command
# Image build with ($ sudo singularity build imagename.simg Singularity )


%labels
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Maintainer Olivier Kirsh <olivier.kirsh@u-paris.fr>					
    Version v1.4 20200717 > not up to date
    

%files
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# load the definition files

# If .yml
    	env-name.yml							## Change .yml name or hide with # 

	Singularity							## Definition file (keep this name to allow shub cloud build)

%environment
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Set global environment variables for anything run within the container

# If .yml
	defile="$(ls *.y*ml)"						## Read yml file
	PATH=/opt/conda/envs/${defile%%.y*ml}/bin:$PATH 			## put the environment in the PATH (no $ conda activate xx required)
	
# If Conda install
	#defname=xxx 							## Set environment name
	#PATH=/opt/conda/envs/$defname/bin:$PATH			## Put the environment in the PATH (no $ conda activate xx required)

%post
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# What is executed during the build process

# Edit .bashrc to run conda    	
	echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc		## Enable conda for the current user
									## Better than $ echo "conda activate" >> ~/.bashrc
									## or $ export PATH="/opt/miniconda3/bin:$PATH" (not recommanded)

# Set conda channels 
	/opt/conda/bin/conda config --add channels defaults
	/opt/conda/bin/conda config --add channels bioconda
	/opt/conda/bin/conda config --add channels conda-forge

# Update conda
	/opt/conda/bin/conda update -n base conda  			## Optionnal. Or specify version


# If .yml
	defile="$(ls *.y*ml)"						## Read yml definition file	
    	/opt/conda/bin/conda env create -n ${defile%%.y*ml} -f $defile	## Create env with the yml file recipe
	/opt/conda/bin/conda clean --tarballs				## Clean and light weight env
	mkdir -p /setupfile						## Create /setupfile directory to save and trace env recipe
	mv $defile Singularity /setupfile
	cd /setupfile
	/opt/conda/bin/conda list -n ${defile%%.y*ml} > ${defile%%.y*ml}_installed_packages.md

# If Conda install
	#defname=xxx 							## Set environment name
	#/opt/conda/bin/conda create -n $defname python=3.7		## package name or python version. 
									## Note that python=3.7 (latest) different of python==3.7 (3.7.0)
	#/opt/conda/bin/conda install -n $defname riri fifi loulou	## change packages (eg : rsem salmon kallisto) and/or set version
	#/opt/conda/bin/conda clean --tarballs				## Clean and light weight env
	#mkdir -p /setupfile						## Create /setupfile directory to save and trace env recipe
	#mv Singularity /setupfile
	#cd /setupfile
	#/opt/conda/bin/conda list -n $defname > $defname_installed_packages.md	
	

%runscript
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This executes commands
    	exec "$@"
