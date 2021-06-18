Bootstrap: docker
From: nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

%files
    environment.yml

%labels
	PyTorch Container for DeepCAM

%post
	# Downloads the latest package lists (important).
	apt-get update -y

	# Install python and other tools
	# Non-interactive is used to ensure prompts are omitted.
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	python3-dev \
	python3-tk \
	python3-pip \
	python3-setuptools \
	systemd \
	imagemagick \
	curl \
	openslide-tools
	
	# Install nodejs
	#curl -sL https://deb.nodesource.com/setup_15.x | bash -
	#apt-get install -y nodejs

	# Reduce image size
	#rm -rf /var/lib/apt/lists/*

	# Update pip
	python3 -m pip install --upgrade pip

	# Install python libraries
	python3 -m pip install wheel
	python3 -m pip install h5py
	python3 -m pip install mpi4py
	python3 -m pip install git+https://github.com/ildoonet/pytorch-gradual-warmup-lr.git
	python3 -m pip install torch torchvision numpy matplotlib torchsummary tensorboardX \
	scikit-learn Pillow pandas scikit-image scipy opencv-python pylint jupyterlab \
	captum fastai albumentations kornia optuna pytorch-lightning==1.3.3 lightning-bolts["extra"] \
	lightning-flash tensorly seaborn altair ipywidgets h5py lmdb pyarrow msgpack torch-lr-finder \
	numba umap-learn[plot] tables openslide-python hdbscan

	#get conda to the path
	#/opt/conda/bin/conda env create -f environment.yml

#%runscript
    #exec /opt/conda/envs/$(head -n 1 environment.yml | cut -f 2 -d ' ')/bin/"$@"