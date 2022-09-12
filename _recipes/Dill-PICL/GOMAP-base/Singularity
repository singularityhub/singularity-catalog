Bootstrap: docker
From: ubuntu:bionic

%labels
BASE_OWNER Wimalanathan Kokulapalan
BASE_MAINTAINER Wimalanathan Kokulapalan
BASE_VERSION 'v1.1.3'

# %setup
#     mkdir -p ${SINGULARITY_ROOTFS}/data

%files
	data /

%environment
	export IRODS_HOST="data.cyverse.org"
	export  IRODS_PORT="1247"
    export  IRODS_USER_NAME="anonymous"
    export  IRODS_ZONE_NAME="iplant"

%post
	export LC_ALL=C
	export DEBIAN_FRONTEND=noninteractive
	export TZ=America/Chicago
	export MAKEFLAGS="-j32"

	echo "Running post.sh"
	apt-get -y update
	apt-get -y install bsdutils lsb-base passwd perl psmisc debconf libc6 \
		libevent-core-2.1-6 libgcc1 liblz4-1 libstdc++6 zlib1g gfortran rsync \
		build-essential less vim wget python-pip libfuse2 r-base openjdk-8-jdk \
		libidn11-dev libssl1.0-dev libssl1.0.0 git ncbi-blast+ octave \
		octave-dataframe sqlite3 libsqlite3-dev python3-pip
	update-java-alternatives -s java-1.8.0-openjdk-amd64

	R -e 'install.packages(c("data.table","futile.logger","ontologyIndex","yaml"), repos="https://mirror.las.iastate.edu/CRAN/", INSTALL_opts="--no-html")'

	pip install numpy==1.14.5
	pip install pyrsistent==0.14.0
	pip install scipy==1.2.0
	pip install jsonmerge==1.5.2
	pip install jsonschema==2.6.0
	pip install lxml==4.2.1
	pip install PyYAML==3.12
	pip install yamldirs==1.1.3
	pip install pyrocopy==0.8.0  
	pip install requests==2.20.0
	pip install requests-toolbelt==0.8.0
	pip install numpydoc==0.8.0
	pip install biopython==1.70
	pip install joblib==0.12.2
	pip install natsort==5.3.3

	wget "https://files.renci.org/pub/irods/releases/4.1.12/ubuntu14/irods-icommands-4.1.12-ubuntu14-x86_64.deb"
	dpkg -i irods-icommands-4.1.12-ubuntu14-x86_64.deb

	wget -q http://www.mpich.org/static/downloads/3.2.1/mpich-3.2.1.tar.gz  && \
	tar -xf  mpich-3.2.1.tar.gz && \
	cd mpich-3.2.1 &&  \
	./configure && make -j32 && make install &&  \
	cd .. && \
	pip install mpi4py==3.0.0  
	
	
	wget -O azcopy_v10.tar.gz https://aka.ms/downloadazcopy-v10-linux && \
	tar -xf azcopy_v10.tar.gz --strip-components=1 && \
	cp azcopy /usr/bin/ && \
	chmod 755 /usr/bin/azcopy
	
	mkdir -p /opt/GOMAP
	mkdir -p /data
	mkdir -p /tmpdir
	mkdir -p /workdir
	mkdir -p /work	  
	mkdir -p /scratch

	echo "=============================================="
	echo "Completed Post" 
	echo "=============================================="



%startscript
	chmod 777 /tmp

%runscript
	cd /opt/GOMAP/ 
	./gomap.py "$@"
