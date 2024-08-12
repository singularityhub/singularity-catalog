# Created using
# mkdir -p epg-overlay
# sudo singularity build epg.sif epg.def
# sudo singularity shell --bind $(dirname $(which icpc)):/opt/local --overlay epg-overlay epg.sif
# sing:> cd easy-parallel-graph/experiment
# sing:> ./get-libraries.sh

# Code taken from https://github.com/ResearchIT/spack-singularity

BootStrap: library
From: ubuntu:16.04

%post
	SPACK_ROOT=/opt/spack
	PATH=$SPACK_ROOT/bin/:$PATH
	export SPACK_ROOT PATH

	cd opt
	apt-get -y update

	apt-get -y install gcc g++ g++-4.8 gcc-4.8 gfortran-4.8
	update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 10
	update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 10

	apt-get -y install git curl wget vim python make cmake \
	  gnupg2 sed patch unzip gzip bzip2 findutils environment-modules \
      zlib1g-dev mpich libboost1.65-all-dev

	git clone https://github.com/spack/spack
	spack compiler find --scope system $(which gcc-4.8)
	# spack install boost%gcc@4.8
	# spack load boost%gcc@4.8

	git clone https://github.com/HPCL/easy-parallel-graph
	cd easy-parallel-graph/experiment
	CC=gcc
	CXX=gcc
	export CC CXX
	./get-libraries.sh

%environment
	SPACK_ROOT=/opt/spack
	PATH=$SPACK_ROOT/bin:$PATH
	export SPACK_ROOT PATH
	spack load boost

	# Add /opt/local/bin bind directory for intel compilers
	# PATH=/opt/local/bin:$PATH
	# Add in licence file etc.
	# LD_LIBRARY_PATH=...
	# export PATH LD_LIBRARY_PATH

%runscript
	. /etc/profile.d/modules.sh
	. $SPACK_ROOT/share/spack/setup-env.sh
	echo "Downloaded epg*, checking spack"
	spack help

%test
	echo "Running test from $(pwd)"
	cd /opt/easy-parallel-graph/experiment
	./gen-datasets.sh 10
	./run-synthetic.sh --no-graphmat 10 2

%labels
	MAINTAINER Samuel D. Pollard
	spack
	graph processing
