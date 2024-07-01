Bootstrap: docker
From: ubuntu:18.04

%post
	######### download and install Macaulay2
	apt-get update -q
	apt-get install -y curl libblas3 libgfortran4 liblapack3 libquadmath0 libgc1c2 libgdbm5 libreadline7 libxml2
	curl -O https://faculty.math.illinois.edu/Macaulay2/Repositories/Ubuntu/dists/bionic/main/binary-amd64/Macaulay2-1.14-amd64-Linux-Ubuntu-18.04.deb
	curl -O https://faculty.math.illinois.edu/Macaulay2/Repositories/Ubuntu/dists/bionic/main/binary-amd64/Macaulay2-1.14-common.deb
	dpkg -i *.deb

	########## download PHCpack

	# get the m2 code for interfacing with PHCpack
	curl -LO http://www.math.uic.edu/~jan/PHCpack.m2

	# get compiled Linux binary from https://github.com/janverschelde/PHCpack/releases/tag/v2.4.72
	curl -LO https://github.com/janverschelde/PHCpack/files/3564263/x86_64phcv24p.tar.gz
	tar -xf x86_64phcv24p.tar.gz 
	mv phc /usr/bin
	rm x86_64phcv24p.tar.gz

%runscript

  exec /usr/bin/M2 "$@"
