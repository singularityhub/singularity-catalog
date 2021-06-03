Bootstrap: docker
From: nvidia/cuda:9.0-devel-ubuntu16.04

%exportironment
	# TensorFlow version is tightly coupled to CUDA and cuDNN so it should be selected carefully
	export TENSORFLOW_VERSION=1.12.0
	export PYTORCH_VERSION=1.0.0
	export CUDNN_VERSION=7.4.1.5-1+cuda9.0
	export NCCL_VERSION=2.4.2-1+cuda9.0

	# Python 2.7 or 3.5 is supported by Ubuntu Xenial out of the box
	# ARG python=3.5
	export PYTHON_VERSION=3.5
	
%post
	apt-get update && apt-get install -y --no-install-recommends --allow-downgrades --allow-change-held-packages \
			build-essential \
			cmake \
			git \
			curl \
			vim \
			wget \
			ca-certificates \
			# libcudnn7=${CUDNN_VERSION} \
			# libnccl2=${NCCL_VERSION} \
			# libnccl-dev=${NCCL_VERSION} \
			libjpeg-dev \
			libpng-dev \
			python${PYTHON_VERSION} \
			python${PYTHON_VERSION}-dev
	wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libcudnn7_${CUDNN_VERSION}_amd64.deb
	wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libcudnn7-dev_${CUDNN_VERSION}_amd64.deb
	wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libnccl2_${NCCL_VERSION}_amd64.deb
	wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libnccl-dev_${NCCL_VERSION}_amd64.deb
	dpkg -i libcudnn7_${CUDNN_VERSION}_amd64.deb
	dpkg -i libcudnn7-dev_${CUDNN_VERSION}_amd64.deb
	dpkg -i libnccl2_${NCCL_VERSION}_amd64.deb
	dpkg -i libnccl-${NCCL_VERSION}_amd64.deb
	apt-get update
	# apt-get install libcudnn7-dev
	# apt-get install libnccl-dev

	ln -s /usr/bin/python${PYTHON_VERSION} /usr/bin/python

	curl -O https://bootstrap.pypa.io/get-pip.py && \
		python get-pip.py && \
		rm get-pip.py

	# Install TensorFlow, Keras and PyTorch
	pip install tensorflow-gpu==${TENSORFLOW_VERSION} keras h5py torch==${PYTORCH_VERSION} torchvision

	# Install Open MPI
	mkdir /tmp/openmpi && \
		cd /tmp/openmpi && \
		wget https://www.open-mpi.org/software/ompi/v3.1/downloads/openmpi-3.1.2.tar.gz && \
		tar zxf openmpi-3.1.2.tar.gz && \
		cd openmpi-3.1.2 && \
		./configure --enable-orte-prefix-by-default && \
		make -j $(nproc) all && \
		make install && \
		ldconfig && \
		rm -rf /tmp/openmpi

	# Install Horovod, temporarily using CUDA stubs
	ldconfig /usr/local/cuda-9.0/targets/x86_64-linux/lib/stubs && \
		HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_WITH_TENSORFLOW=1 HOROVOD_WITH_PYTORCH=1 pip install --no-cache-dir horovod && \
		ldconfig

	# Create a wrapper for OpenMPI to allow ning as root by default
	mv /usr/local/bin/mpi /usr/local/bin/mpi.real && \
		echo '#!/bin/bash' > /usr/local/bin/mpi && \
		echo 'mpi.real --allow--as-root "$@"' >> /usr/local/bin/mpi && \
		chmod a+x /usr/local/bin/mpi

	# Configure OpenMPI to  good defaults:
	#   --bind-to none --map-by slot --mca btl_tcp_if_exclude lo,docker0
	echo "hwloc_base_binding_policy = none" >> /usr/local/etc/openmpi-mca-params.conf && \
		echo "rmaps_base_mapping_policy = slot" >> /usr/local/etc/openmpi-mca-params.conf && \
		echo "btl_tcp_if_exclude = lo,docker0" >> /usr/local/etc/openmpi-mca-params.conf

	# Set default NCCL parameters
	echo NCCL_DEBUG=INFO >> /etc/nccl.conf

	# Install OpenSSH for MPI to communicate between containers
	apt-get install -y --no-install-recommends openssh-client openssh-server && \
		mkdir -p /var//sshd

	# Allow OpenSSH to talk to containers without asking for confirmation
	cat /etc/ssh/ssh_config | grep -v StrictHostKeyChecking > /etc/ssh/ssh_config.new && \
		echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config.new && \
		mv /etc/ssh/ssh_config.new /etc/ssh/ssh_config

	# Download examples
	apt-get install -y --no-install-recommends subversion && \
		svn checkout https://github.com/uber/horovod/tk/examples && \
		rm -rf /examples/.svn

