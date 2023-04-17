Bootstrap: docker
From: debian:stretch

%labels
	Maintainer Mathieu Fourment

%post
 	apt-get update && apt-get install -y --no-install-recommends \
		build-essential \
		ca-certificates \
		cmake \
		git \
		libgsl0-dev \
		python2.7 \
		unzip \
		wget
	
	wget https://github.com/4ment/physher/archive/marginal-v1.0.zip && unzip marginal-v1.0.zip
	mkdir physher-marginal-v1.0/Release && cd physher-marginal-v1.0/Release
	cmake -DBUILD_SHARED_LIBS=OFF .. && make && make install

%runscript
	python2.7 run_simulations.py "$@"

%test
	physher