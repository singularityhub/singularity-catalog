Bootstrap: docker
From: continuumio/miniconda3

%files
	project.scif
	Snakefile
	config.yaml
	concatenate_logs.py
	summarize_gene_exp.py

%environment
	PATH=/opt/conda/bin:$PATH
	export PATH

%post

    apt-get -y update
	apt-get -y install build-essential libboost-all-dev libgsl-dev libz-dev git

	echo "Setting up conda channels"
	/opt/conda/bin/conda config --add channels conda-forge
	/opt/conda/bin/conda config --add channels bioconda

	# Install scif and scif-apps
	/opt/conda/bin/pip install scif
	/opt/conda/bin/scif install /project.scif

	# Install snakemake
	/opt/conda/bin/conda install --yes snakemake=4.6.0
	/opt/conda/bin/conda install --yes docutils=0.14

	#Clean up conda to help with space.
	/opt/conda/bin/conda clean --all --yes

%runscript
	exec scif "$@"