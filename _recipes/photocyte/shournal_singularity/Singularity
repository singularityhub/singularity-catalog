Bootstrap: docker
From: ubuntu:18.04

%labels
MAINTAINER Timothy R. Fallon 

%files

%environment

%post
    PACKAGE_VER="2.3"
    PACKAGE_NAME="shournal_${PACKAGE_VER}_amd64.deb"
    BUILD_PACKAGES="wget apt-utils apt-transport-https htop"
    DEBIAN_FRONTEND=noninteractive

    apt-get update
    apt-get install --yes $BUILD_PACKAGES
    apt-get install --yes locales
    locale-gen "en_US.UTF-8"
    dpkg-reconfigure locales
    
    ### For shournal
    cd /tmp
    wget -q https://github.com/tycho-kirchner/shournal/releases/download/v${PACKAGE_VER}/${PACKAGE_NAME}
    dpkg -I ${PACKAGE_NAME} ##Print some information about the package dependencies
    apt-get install -y -f /tmp/${PACKAGE_NAME}
    ###
    
    chown root /usr/bin/shournal-run
    chmod u+s /usr/bin/shournal-run      
  
    ### Cleanup
    rm -f *.deb
    apt-get autoremove --purge --yes
    apt-get clean
    rm -rf /var/lib/apt/lists/*
    
%runscript
