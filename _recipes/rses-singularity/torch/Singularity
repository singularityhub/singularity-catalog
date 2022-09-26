Bootstrap: docker
From: nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04

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

	#Export torch paths
	LUA_PATH="/usr/local/torch/install/share/lua/5.1/?.lua"
	LUA_PATH="/usr/local/torch/install/share/lua/5.1/?/init.lua;$LUA_PATH"
	LUA_PATH="./?.lua;$LUA_PATH"
	LUA_PATH="/usr/local/torch/install/share/luajit-2.1.0-beta1/?.lua;$LUA_PATH"
	LUA_PATH="/usr/local/share/lua/5.1/?.lua;$LUA_PATH"
	LUA_PATH="/usr/local/share/lua/5.1/?/init.lua;$LUA_PATH"
	LUA_PATH="${HOME}/.luarocks/share/lua/5.1/?.lua;$LUA_PATH"
	LUA_PATH="${HOME}/.luarocks/share/lua/5.1/?/init.lua;$LUA_PATH"

	LUA_CPATH="/usr/local/torch/install/lib/lua/5.1/?.so"
	LUA_CPATH="./?.so;$LUA_CPATH"
	LUA_CPATH="/usr/local/lib/lua/5.1/?.so;$LUA_CPATH"
	LUA_CPATH="/usr/local/lib/lua/5.1/loadall.so;$LUA_CPATH"
	LUA_CPATH="${HOME}/.luarocks/lib/lua/5.1/?.so;$LUA_CPATH"

	PATH=/usr/local/torch/install/bin:$PATH
	LD_LIBRARY_PATH=/usr/local/torch/install/lib:$LD_LIBRARY_PATH
	DYLD_LIBRARY_PATH=/usr/local/torch/install/lib:$DYLD_LIBRARY_PATH
	LUA_CPATH="/usr/local/torch/install/lib/?.so;$LUA_CPATH"

	export PATH LD_LIBRARY_PATH CPATH LUA_PATH LUA_CPATH DYLD_LIBRARY_PATH CUDA_HOME

%setup
	#Runs on host
	#The path to the image is $SINGULARITY_ROOTFS



%post
	#Post setup script

	#Load environment variables
	. /environment

	#Default mount paths
	mkdir /scratch /data /shared /fastdata

	#Nvidia Library mount paths
	mkdir /nvlib /nvbin

	#Updating and getting required packages
	apt-get update
	apt-get install -y wget git cmake
	apt-get install -y libreadline-dev
	apt-get install -y unzip

	#Creates a build directory
	BUILD_ROOT="/build"

	mkdir -p $BUILD_ROOT

	#Back to build root
	cd $BUILD_ROOT

	git clone https://github.com/xianyi/OpenBLAS.git openblas
	cd openblas
	make
	make install

	#Back to build root
	cd $BUILD_ROOT



	#Download and install torch
	git clone https://github.com/torch/distro.git /usr/local/torch --recursive
	cd /usr/local/torch
	#Remove all the sudo commands from install deps
	sed -i  "s/sudo //" install-deps
	bash install-deps
	./install.sh


	luarocks install --server=http://luarocks.org/dev paths
	luarocks install tds bit32

	apt-get install zlib1g-dev
	luarocks install lua-zlib


%runscript
	#Executes with the singularity run command
	#delete this section to use existing docker ENTRYPOINT command


%test
	#Test that script is a success
