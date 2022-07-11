Bootstrap: docker
From: continuumio/miniconda3

%labels
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Set labels
    Maintainer olivier.kirsh@u-paris.fr					
    Version v1.1 20190704

%files
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# load the definition files

# If .yml
    	rst36-20190814.yml	## change .yml name

	Singularity	# definition file

%environment
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Set global environment variables for anything run within the container

# If .yml
	defile="$(ls *.yml)"
	PATH=/opt/conda/envs/${defile%%.yml}/bin:$PATH
	
# If Conda install
	#defname=xxx 	## change name
	#PATH=/opt/conda/envs/$defname/bin:$PATH

%post
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    	
	echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
	/opt/conda/bin/conda config --add channels defaults
	/opt/conda/bin/conda config --add channels bioconda
	/opt/conda/bin/conda config --add channels conda-forge


# If .yml
	defile="$(ls *.yml)"
   	echo "source activate ${defile%%.yml}" > ~/.bashrc
    	/opt/conda/bin/conda env create -n ${defile%%.yml} -f $defile
	/opt/conda/bin/conda clean --tarballs
	mkdir -p /home/setupfile
	cp $defile Singularity /home/setupfile
	cd /home/setupfile
	/opt/conda/bin/conda list -n ${defile%%.yml} > ${defile%%.yml}_installed_packages.md

# If Conda install
	#defname=xxx 	## change name
   	#echo "source activate $defname" > ~/.bashrc
	#/opt/conda/bin/conda create -n $defname python==3.7
	#/opt/conda/bin/conda install -n $defname rsem salmon kallisto
	#/opt/conda/bin/conda clean --tarballs
	#mkdir -p /home/setupfile
	#cp Singularity /home/setupfile
	#cd /home/setupfile
	#/opt/conda/bin/conda list -n $defname > $defname_installed_packages.md	
	

%runscript
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This executes commands
    	exec "$@"
