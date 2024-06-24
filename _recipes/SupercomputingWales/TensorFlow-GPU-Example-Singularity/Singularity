Bootstrap: docker
From: nvidia/cuda:9.0-devel

%help
    Container for Tensorflow
    To install run: 
	sudo singularity build tensorflow-gpu.img Singularity
    To run 
	singularity run --nv tensorflow-gpu.img

%labels
    MAINTAINER Colin Sauze

%environment


%post  
    pwd
    apt-get update
    apt-get -y install unzip wget build-essential git gdal-bin python-numpy python-opencv anaconda

    mkdir /usr/lib/nvidia
    apt-get -y install libcuda1-396

    cd /opt
    if [ ! -d "TensorFlow-GPU-Example-Singularity" ] ; then
	git clone https://github.com/SupercomputingWales/TensorFlow-GPU-Example-Singularity.git
	cd TensorFlow-GPU-Example-Singularity
	#git checkout test
	#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
	./tensorflow_setup.sh

	#we don't actually need the cuda libraries and the gigabyte of dependencies they installed if we run the container with the --nv option.
	apt-get -y purge libcuda1-396
	apt-get -y clean
	apt-get -y autoclean
	apt-get -y --purge autoremove

    fi


%runscript
    cd /opt/TensorFlow-GPU-Example-Singularity
    conda activate tensorflow-gpu
    python multilayer_perceptron.py
