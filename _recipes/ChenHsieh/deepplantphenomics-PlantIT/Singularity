Bootstrap: docker
From: ubuntu:18.04

%labels
	Maintainer: CH

%post
	apt update && \
	apt install -y \
		build-essential \
		python3-setuptools \
		python3-pip \
		python3-numexpr \
		libgl1-mesa-glx \
		libsm6 \
		libxext6 \
		libfontconfig1 \
		libxrender1

	pip3 install --upgrade pip && \
	pip3 install -r requirement.txt && \
	pip3 install ./deepplantphenomics && \
	pip3 install numpy --upgrade
	mkdir /lscratch /db /work /scratch
