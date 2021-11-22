BootStrap: docker
From: ubuntu:14.04

%post
	apt-get -y update
	apt-get install -y libxp6
	apt-get -qq -y install curl
	curl -sSL https://repo.continuum.io/archive/Anaconda2-5.0.1-Linux-x86_64.sh -o /tmp/miniconda.sh
	curl -sSL http://collaborations.gis.a-star.edu.sg/~cmb6/kumarv1/dfilter/DFilter-v1.5.tar.gz -o /tmp/Dfilter.tar.gz
	tar -xvf /tmp/Dfilter.tar.gz -C /usr/local/
	bash /tmp/miniconda.sh -bfp /usr/local
	rm -rf /tmp/miniconda.sh
	apt-get -qq -y install libxpm4
	apt-get -qq -y install libxtst6
	apt-get -qq -y install libxt6
	apt-get -qq -y install libxmu6
	apt-get -qq -y install python2.7
	apt-get -qq -y install gawk

	conda install -y python=2
	conda update conda

	apt-get -qq -y remove curl bzip2

%environment	
	export PATH=/usr/local/bin:$PATH
	export PATH=/usr/lib/x86_64-linux-gnu/:/usr/local/bin:$PATH
	export PATH=/usr/local/DFilter1.5/:$PATH
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/DFilter1.5/R2013b/runtime/glnxa64:/usr/local/DFilter1.5/R2013b/bin/glnxa64
