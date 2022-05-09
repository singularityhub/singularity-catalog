Bootstrap: docker
From: ubuntu:16.04

%labels
Author "Randall Cab White - rcwhite@stanford.edu"

#########
#%setup


#########
%post
	
	alias sudo='' #makes it easier to copy and paste tutorials =P
	apt-get -ym update
	apt-get -ym install git kdiff3 curl 
    apt-get -ym install cmake gcc # BUILD UTILS
    
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
    apt-get -ym install git-lfs
    
    git lfs install #redundant
    
    apt-get -ym install libcunit1 hdf5-tools libhdf5-10 libopenblas-base # Running libraries
	apt-get -ym install libcunit1-dev libhdf5-dev libopenblas-dev

	##apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	##echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
	##apt-get -ym update
	##apt-get -ym install mono-complete
	
	
	git clone https://github.com/nanoporetech/flappie
	cd flappie
	make flappie
	
%environment
	export IMAGE_NAME="FLAGPIE"
	export PATH="/flappie/build:$PATH" #setting the path for flapp
	
