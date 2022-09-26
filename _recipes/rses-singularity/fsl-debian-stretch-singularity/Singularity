Bootstrap:docker
From:debian:stretch
 
%labels
MAINTAINER willfurnass

#%setup
#    mkdir ${SINGULARITY_ROOTFS}/somedir
#    cp somefile ${SINGULARITY_ROOTFS}/

%post
    DEBIAN_FRONTEND=noninteractive apt-get update 
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl gnupg2
    curl -sSL http://neuro.debian.net/lists/stretch.de-md.full > /etc/apt/sources.list.d/neurodebian.sources.list
    DEBIAN_FRONTEND=noninteractive apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9
    DEBIAN_FRONTEND=noninteractive apt-get update 
    DEBIAN_FRONTEND=noninteractive apt-get install -y fsl-complete fsl-feeds
    rm -r /var/lib/apt/lists/*
    ln -s /usr/share/fsl/5.0/etc/fslconf/fsl.sh /usr/share/fsl/5.0/etc/fslconf/fsl.csh /etc/profile.d

#%environment
#    export SOMEVAR=some_value
 
#%runscript
#    someprogram arg1 arg2
