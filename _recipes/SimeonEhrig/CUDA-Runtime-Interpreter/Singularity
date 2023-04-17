Bootstrap: docker
From: nvidia/cuda:8.0-devel-ubuntu16.04

%help
	The container provide an environment to build the CUDA-Runtime-Interpreter prototype.
	It based on the cuda docker container: https://hub.docker.com/r/nvidia/cuda/

%setup

%files

%labels
	Maintainer Simeon Ehrig
	Email s.ehrig@hzdr.de
	Version 1.0

%environment

%post
	# This file contains all custom installations, which was installed during the post phase of building the container. It avoids errors caused by double installation, if the container is build again with a changed configuration.
	if [ ! -f /opt/installed_tools.txt ]; then
		touch /opt/installed_tools.txt
	fi
	cd /opt

	apt update
	# basic tools
	apt install -y nano less git wget
	# necessary librariers
	apt install -y clang-5.0 libclang-5.0-dev llvm-5.0-dev zlib1g-dev libedit-dev 

	if ! grep -q "cmake_3.12" "/opt/installed_tools.txt"; then
		wget https://cmake.org/files/v3.12/cmake-3.12.4.tar.gz
		tar -xzvf cmake-3.12.4.tar.gz
	    cd cmake-3.12.4
	    ./bootstrap
		make -j
		make install -j
		ln -s /usr/local/bin/cmake /usr/bin
		cd ..
		rm -r cmake-3.12.4 cmake-3.12.4.tar.gz
		echo "cmake_3.12" >> /opt/installed_tools.txt
	fi

%runscript