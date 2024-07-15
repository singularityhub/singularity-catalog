Bootstrap:docker
From:ubuntu:17.10

%environment
	export GMTU=/usr/share/gmtFoam
	export FOAM_TUTORIALS=/opt/openfoam-dev/tutorials
	export PATH=/opt/openfoam-dev/platforms/linux64GccDPInt32Opt/bin:/opt/openfoam-dev/bin:/opt/openfoam-dev/wmake:$PATH
	export LD_LIBRARY_PATH=/opt/openfoam-dev/platforms/linux64GccDPInt32Opt/lib/openmpi-system:/usr/lib/x86_64-linux-gnu/openmpi/lib:/opt/openfoam-dev/platforms/linux64GccDPInt32Opt/lib:/opt/openfoam-dev/platforms/linux64GccDPInt32Opt/lib/dummy
	export MPI_BUFFER_SIZE=20000000
	export FOAM_INST_DIR=/opt
	export WM_PROJECT_INST_DIR=/opt
	export WM_LDFLAGS=-m64
	export FOAM_APP=/opt/openfoam-dev/applications
	export WM_CXXFLAGS="-m64 -fPIC -std=c++0x"
	export FOAM_UTILITIES=/opt/openfoam-dev/applications/utilities
	export FOAM_APPBIN=/opt/openfoam-dev/platforms/linux64GccDPInt32Opt/bin
	export WM_PRECISION_OPTION=DP
	export FOAM_SOLVERS=/opt/openfoam-dev/applications/solvers
	export WM_CC=gcc
	export FOAM_SIGFPE=
	export WM_OPTIONS=linux64GccDPInt32Opt
	export WM_LINK_LANGUAGE=c++
	export WM_OSTYPE=POSIX
	export WM_PROJECT=OpenFOAM
	export FOAM_LIBBIN=/opt/openfoam-dev/platforms/linux64GccDPInt32Opt/lib
	export MPI_ARCH_PATH=/usr/lib/x86_64-linux-gnu/openmpi
	export WM_CFLAGS="-m64 -fPIC"
	export WM_ARCH=linux64
	export FOAM_SRC=/opt/openfoam-dev/src
	export FOAM_ETC=/opt/openfoam-dev/etc
	export FOAM_SETTINGS=
	export WM_COMPILER_LIB_ARCH=64
	export WM_COMPILER=Gcc
	export WM_DIR=/opt/openfoam-dev/wmake
	export WM_LABEL_SIZE=32
	export WM_ARCH_OPTION=64
	export WM_PROJECT_VERSION=dev
	export WM_LABEL_OPTION=Int32
	export WM_MPLIB=SYSTEMOPENMPI
	export WM_COMPILE_OPTION=Opt
	export WM_COMPILER_TYPE=system
	export WM_CXX=g++
	export FOAM_MPI=openmpi-system
	export FOAM_JOB_DIR=/opt/jobControl
	export WM_PROJECT_DIR=/opt/openfoam-dev

%post
	apt-get update -qq
	apt-get install wget software-properties-common apt-transport-https -y --no-install-recommends
	sh -c "wget -O - http://dl.openfoam.org/gpg.key | apt-key add -"
	add-apt-repository "http://dl.openfoam.org/ubuntu dev" -y
	add-apt-repository "http://atmosfoam-apt.s3-website-eu-west-1.amazonaws.com dev" -y
	apt-get update -qq --allow-insecure-repositories

	DEBIAN_FRONTEND=noninteractive \
        apt-get install -y --no-install-recommends \
               ninja-build \
               texlive-latex-base \
               texlive-latex-recommended \
               texlive-latex-extra \
	       texlive-extra-utils \
               texlive-fonts-recommended \
               texlive-fonts-extra \
               texlive-font-utils \
               texlive-science \
               texlive-publishers \
	       ps2eps \
	       gnuplot-nox \
               gnuplot \
	       git \
	       ca-certificates \
	       python3-setuptools \
	       python3-pip \
	       gettext-base \
	       subversion \
	       build-essential \
	       cmake \
	       libcurl4-gnutls-dev \
	       libnetcdf-dev \
	       libgdal-dev \
	       libfftw3-dev \
	       libpcre3-dev \
	       liblapack-dev \
	       libblas-dev

	git clone https://github.com/hertzsprung/ninjaopenfoam.git
	pip3 install ninjaopenfoam/

	svn checkout svn://gmtserver.soest.hawaii.edu/gmt/tags/5.4.3 gmt-5.4.3
        cd gmt-5.4.3
        cp cmake/ConfigUserTemplate.cmake cmake/ConfigUser.cmake
        mkdir build && cd build
        cmake ..
        make
        make install

	DEBIAN_FRONTEND=noninteractive \
	apt-get install openfoam-dev -y --no-install-recommends

	DEBIAN_FRONTEND=noninteractive \
	apt-get install atmosfoam-tools -y --no-install-recommends --allow-unauthenticated
