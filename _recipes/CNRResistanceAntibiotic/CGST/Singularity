############################################################
# Singularity to build CGST container
# Based on Julia 1
#   sudo singularity build CGST.simg Singularity
#   singularity exec CGST.simg cgst
############################################################

# Set the base format to docker
Bootstrap: docker

# Set the base image to Ubuntu
From: julia:1.4.1

%labels
    Maintainer Aurélien BIRER <abirer@chu-clermontferrand.fr>
    Version v1.0

%environment
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/julia/bin:/usr/local/MentaLiST/src:/usr/local/MentaLiST/scripts:/usr/local/SPAdes-3.13.0-Linux/bin::/usr/local/raxml-ng/bin:
    JULIA_DEPOT_PATH="/opt/.julia"
    export JULIA_DEPOT_PATH
    # Set UTF8 for system
    LANG=en_US.UTF-8
	export LANG
	LC_ALL=en_US.UTF-8
	export LC_ALL
	LC_COLLATE=en_US.UTF-8
    export LC_COLLATE
    LC_TIME=en_US.UTF-8
    export LC_TIME
    LC_MESSAGES=en_US.UTF-8
    export LC_MESSAGES
    LC_MONETARY=en_US.UTF-8
    export LC_MONETARY
    LC_PAPER=en_US.UTF-8
    export LC_PAPER
    LC_MEASUREMENT=en_US.UTF-8
    export LC_MEASUREMENT
    LANGUAGE=en_US.UTF-8
    export LANGUAGE
    LC_CTYPE=en_US.UTF-8
    export LC_CTYPE
    LC_MESSAGES=en_US.UTF-8
    export LC_MESSAGES

%post
	export DEBIAN_FRONTEND=noninteractive

    apt-get update
 	apt-get install --no-install-recommends -y build-essential python3-dev python3-setuptools python3-pip git wget subversion unzip
	
  	#For Resolve encoding problems with docker
  	apt-get update --fix-missing 
   	apt-get install --no-install-recommends -y locales locales-all

	locale-gen en_US.UTF-8
    echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen

	cd /usr/local

    # Install Julia
    export JULIA_DEPOT_PATH=/opt/.julia
    export PATH=/usr/local/julia/bin:$PATH

    # Install packages for MentaLiST
    julia -e 'using Pkg;pkg"add JSON Distributed ArgParse BioSequences@1.1.0 DataStructures JLD GZip Blosc FileIO TextWrap LightXML;precompile"'

    chown -R root:users /opt/.julia
    chmod -R 777 /opt

	# INSTALL MentaLiST
	apt-get install --no-install-recommends -y libz-dev
	git clone https://github.com/CNRResistanceAntibiotic/MentaLiST.git

	# UPGRADE PIP
	python3 -m pip install wheel
	python3 -m pip install --upgrade pip
    python3 -m pip install -U pip
    python3 -m pip install 'setuptools==47.3.2'

	# INSTALL ARIBA
	# dependencies Ariba

	wget -q http://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.2.9/bowtie2-2.2.9-linux-x86_64.zip &&\
        unzip bowtie2-2.2.9-linux-x86_64.zip  &&\
        rm bowtie2-2.2.9-linux-x86_64.zip 

	#ariba env

	# Need MPLBACKEND="agg" to make matplotlib work without X11, otherwise get the error 
	# _tkinter.TclError: no display name and no $DISPLAY environment variable

	echo 'export ARIBA_BOWTIE2=/usr/local/bowtie2-2.2.9/bowtie2' >>$SINGULARITY_ENVIRONMENT
	export ARIBA_BOWTIE2=/usr/local/bowtie2-2.2.9/bowtie2
	echo 'export MPLBACKEND="agg"' >>$SINGULARITY_ENVIRONMENT
	export MPLBACKEND="agg"
	echo 'export ARIBA_CDHIT=cdhit-est' >>$SINGULARITY_ENVIRONMENT
	export ARIBA_CDHIT=cdhit-est

	#Install SPAdes
	wget http://cab.spbu.ru/files/release3.13.0/SPAdes-3.13.0-Linux.tar.gz
	tar -xvf SPAdes-3.13.0-Linux.tar.gz
	rm SPAdes-3.13.0-Linux.tar.gz


	apt-get install --no-install-recommends -y mummer python3-matplotlib cd-hit python python-pip python-dev python-setuptools
	python3 -m pip install ariba

	# INSTALL R
	apt-get install --no-install-recommends -y r-base r-base-dev libcurl4-openssl-dev libnlopt-dev r-cran-car

	R -e "install.packages('optparse')"
	R -e "install.packages('questionr')"
	R -e "install.packages('cluster')"
	R -e "install.packages('fastcluster')"
	R -e "install.packages('factoextra')"
	R -e "install.packages('cowplot')"

	# INSTALL MAFFT
    apt-get install --no-install-recommends -y mafft

    # Install python dependencies
	python3 -m pip install --trusted-host pypi.python.org --upgrade pip
	python3 -m pip --version
	python3 -m pip install certifi
	python3 -m pip install nose
	python3 -m pip install pillow
	python3 -m pip install dendropy
	python3 -m pip install biopython
	python3 -m pip list

    # Install RAxML for Gubbins
    apt-get install --no-install-recommends -y gcc pkg-config zlib1g-dev libsubunit-dev
	export raxml_version='8.2.12'
	curl -L https://github.com/stamatak/standard-RAxML/archive/v${raxml_version}.tar.gz -o standard-RAxML-${raxml_version}.tar.gz
	tar xzf standard-RAxML-${raxml_version}.tar.gz
	cd standard-RAxML-${raxml_version}
		make -f Makefile.gcc
		make -f Makefile.PTHREADS.gcc
		cp raxmlHPC /usr/local/bin/
		cp raxmlHPC-PTHREADS /usr/local/bin/
	cd ..
	rm -rf standard-RAxML-${raxml_version}

    # Install FastTree for Gubbins
	export fasttree_version='2.1.10'
	curl http://www.microbesonline.org/fasttree/FastTree-${fasttree_version}.c -o FastTree.c
	gcc -O3 -finline-functions -funroll-loops -Wall -o FastTree FastTree.c -lm
	mv FastTree /usr/local/bin/
	rm FastTree.c

	# Install IQTree for Gubbins
	export iqtree_version='1.6.6'
	curl -L https://github.com/Cibiv/IQ-TREE/releases/download/v${iqtree_version}/iqtree-${iqtree_version}-Linux.tar.gz -o iqtree-${iqtree_version}-Linux.tar.gz
	tar xzf iqtree-${iqtree_version}-Linux.tar.gz
	cp iqtree-${iqtree_version}-Linux/bin/iqtree /usr/local/bin
	rm -rf iqtree-${iqtree_version}-Linux

    # Install Gubbins
    apt-get install --no-install-recommends -y  autoconf libtool automake check
	git clone https://github.com/sanger-pathogens/gubbins.git
	cd gubbins
		autoreconf -i
		 ./configure
		make
		make check
		make install
		cd python
			python3 setup.py install
		cd ..
	cd ..

	# Rename executable for backwards compatibility
    mv /usr/local/bin/run_gubbins.py /usr/local/bin/run_gubbins

	# Install RaXml-ng
	apt-get install --no-install-recommends -y cmake flex bison libgmp3-dev
    git clone --recursive https://github.com/amkozlov/raxml-ng
	cd raxml-ng
		mkdir build
		cd build
			cmake ..
			make
		cd ..
	cd ..

	# INSTALL CGST
    python3 -m pip install pandas
    python3 -m pip install biopython
	python3 -m pip install git+https://github.com/CNRResistanceAntibiotic/CGST.git

    # remove un-necessary packages
    apt autoremove --purge --yes
    apt clean
