Bootstrap: docker
From: centos:7

%help
SPar-K singularity container.
To run SPar-K, use : singularity exec <imagename> spark <options>
To get SPar-K help, use : singularity exec <imagename> spark -h

%post
    	yum install -y wget && \
	# unzip
	yum install -y unzip
	# install development tools
	yum install -y gcc && \
	yum install -y gcc-c++ && \
	yum install -y make && \
	# cmake
	yum install -y cmake && \
	# pip
	yum install -y epel-release && \
	yum install -y python-pip && \
	pip install --upgrade pip && \
	# SCons
	pip install -U setuptools && \
	pip install -U wheel && \
	pip install -U scons && \
	# R and libraries
	yum install -y R && \
	R -e 'install.packages("optparse", repos="http://cran.us.r-project.org")' && \
	R -e 'install.packages("RColorBrewer", repos="http://cran.us.r-project.org")' && \
	# boost
	yum install -y boost-devel.x86_64 && \
	# unittest++
	wget https://github.com/unittest-cpp/unittest-cpp/archive/master.zip && \
	unzip master.zip && \
	rm -f master.zip && \
	cd unittest-cpp-master/ && \
	cmake -G "Unix Makefiles" && \
	make && \
	make install && \
	cd .. && \
	rm -rf unittest-cpp-master && \
	# SPar-K
	wget https://github.com/romaingroux/SPar-K/archive/release.zip && \
	unzip release.zip && \
	mv SPar-K-release SPar-K && \
	rm release.zip && \
	cd SPar-K && \
	chmod a+x bin/*.R && \
	scons && \
	cd ..

%environment
	PATH="$PATH:/SPar-K/bin/"
	export PATH
	LANG="en_US.utf8"
	export LANG

%labels
	Maintainer Romain Groux
	Version v1.01
