# Read in singularity heudiconv image version 0.5.3.1
Bootstrap: docker
From: ubuntu:xenial-20210429


%environment
	export DEBIAN_FRONTEND=noninteractive
	export PYTHONPATH=""

%runscript
	. /usr/local/miniconda/etc/profile.d/conda.sh
    conda activate heudiconv
	python /run.py "$@"


%files
	run.py /run.py
	heuristics /heuristics
	IntendedFor.py /IntendedFor.py

%post

	# Make script executable
	chmod +x /run.py

	# Make local folders
	mkdir /output_dir 
    mkdir /dicom_dir
    mkdir /tmp_dir 
    touch /heuristic.py

	# Install needed UBUNTU packages
	apt-get update && \
    apt-get install -y curl git

	# Install python 3.7 most recent stable miniconda version 4.9.2
	echo "Installing miniconda ..."
    curl -sSLO https://repo.anaconda.com/miniconda/Miniconda3-py37_4.9.2-Linux-x86_64.sh
    bash Miniconda3-py37_4.9.2-Linux-x86_64.sh -b -p /usr/local/miniconda
    rm Miniconda3-py37_4.9.2-Linux-x86_64.sh

	# Add miniconda to path and set other environment variables
	export DEBIAN_FRONTEND=noninteractive
	export PYTHONPATH=""
	export PATH="/usr/local/miniconda/bin:$PATH"
    export CPATH="/usr/local/miniconda/include:$CPATH"
    export LANG="C.UTF-8"
    export LC_ALL="C.UTF-8"
    PYTHONNOUSERSITE=1


	# create conda environment and download heudiconv repo
	conda create -n heudiconv && \
	. /usr/local/miniconda/etc/profile.d/conda.sh && \
	conda activate heudiconv && \
	conda install pip && \
	conda install -c conda-forge dcm2niix && \
	mkdir github && \
	cd github && \
	git clone https://github.com/nipy/heudiconv.git && \
	cd heudiconv && \
	git checkout tags/debian/0.9.0-2 -b debian-0.9.0-2 && \
	pip install -r /github/heudiconv/requirements.txt
	


