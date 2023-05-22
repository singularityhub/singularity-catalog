Bootstrap: docker
From: ubuntu:16.04

IncludeCmd: yes

%runscript
    exec /bin/bash "$@"

%post
    echo "Update aptitude"
    /usr/bin/apt-get update && apt-get install -y --no-install-recommends apt-utils
    /usr/bin/apt-get -y upgrade
    /usr/bin/apt-get update --fix-missing
    /usr/bin/apt-get --assume-yes install libxext-dev
    /usr/bin/apt-get install -y software-properties-common
    /usr/bin/add-apt-repository ppa:webupd8team/java
    /usr/bin/apt-get update && apt-get upgrade -y
    /usr/bin/apt-get install -y openjdk-8-jdk

    /usr/bin/apt-get install -y build-essential git \
        unzip \
		xorg \
		xserver-xorg \
		wget \
		tree \
		pandoc \
		curl \
		vim
	
    echo "Downloading Matlab MCR 2018b"
    mkdir /mcr-install && \
    mkdir /opt/mcr
    cd /mcr-install && \
    wget -nc http://ssd.mathworks.com/supportfiles/downloads/R2018b/deployment_files/R2018b/installers/glnxa64/MCR_R2018b_glnxa64_installer.zip && \
    cd /mcr-install && \
    echo "Unzipping container" && \
    unzip -q MCR_R2018b_glnxa64_installer.zip && \
    ./install -destinationFolder /opt/mcr -agreeToLicense yes -mode silent && \
    cd / && \
    echo "Removing temporary files" && \
    rm -rvf mcr-install
    
    echo "Configuring Environment for MCR"
    # mv -v /opt/mcr/v95/sys/os/glnxa64/libstdc++.so.6 /opt/mcr/v95/sys/os/glnxa64/libstdc++.so.6.old
    echo 'export LD_LIBRARY_PATH=/opt/mcr/v95/runtime/glnxa64:/opt/mcr/v95/bin/glnxa64:/opt/mcr/v95/sys/os/glnxa64' >>$SINGULARITY_ENVIRONMENT
    echo 'export XAPPLRESDIR=/opt/mcr/v95/X11/app-defaults' >>$SINGULARITY_ENVIRONMENT
	
    echo "Configuring Environment for User" 
    USERNAME=murphylab
    UID=1000
    useradd -m -s /bin/bash -N -u $UID $USERNAME
    if [ ! -d /home/$USERNAME/ ]; then mkdir /home/$USERNAME/; fi
	
