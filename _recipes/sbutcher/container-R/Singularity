Bootstrap: docker
From: ubuntu:latest

%post

	echo "##### Installing Development Tools YUM group #####"
	apt-get update
        apt-get -y install build-essential wget git binutils binutils-dev cmake gcc g++ gfortran bzip2  xz-utils liblzma-dev make libcurl4-openssl-dev libreadline-dev libpcre3-dev libbz2-dev zlib1g-dev
        sleep 60
        echo "Sleeping for a bit"
	wget https://cran.r-project.org/src/base/R-latest.tar.gz
	tar zxf R-latest.tar.gz
	cd R-*
	./configure --enable-R-shlib --with-x=no
	make
	make install


	echo "##### getting the R code #####"

%test
        R --version

%runscript
	echo "##### Loading R #####"
	exec R 
