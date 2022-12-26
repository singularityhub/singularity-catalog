Bootstrap: docker
From: nvidia/digits:5.0

%environment

	#Environment variables

	#Use bash as default shell
	SHELL=/bin/bash

	#Add nvidia driver paths
	PATH="/nvbin:$PATH"
	LD_LIBRARY_PATH="/nvlib;$LD_LIBRARY_PATH"

	#Add CUDA paths
	CPATH="/usr/local/cuda/include:$CPATH"
	PATH="/usr/local/cuda/bin:$PATH"
	LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
	CUDA_HOME="/usr/local/cuda"


	#Adding DIGITS paths
	DIGITS_VERSION="5.0"
	DIGITS_JOBS_DIR="/jobs"
	DIGITS_LOGFILE_FILENAME="/jobs/digits.log"

	export PATH LD_LIBRARY_PATH CPATH CUDA_HOME DIGITS_VERSION DIGITS_JOBS_DIR DIGITS_LOGFILE_FILENAME

%setup
	#Runs on host
	#The path to the image is $SINGULARITY_ROOTFS


%post
	#Post setup script

	#Make environment file executable
	chmod +x /environment

  #Default mount paths
	mkdir /scratch /data /shared /fastdata

  #Nvidia Library mount paths
	mkdir /nvlib /nvbin


  #Making a jobs dir
	mkdir -p /data
  mkdir -p /jobs




%runscript
	#Executes with the singularity run command
	#delete this section to use existing docker ENTRYPOINT command
	python -m digits




%test
	#Test that script is a success
