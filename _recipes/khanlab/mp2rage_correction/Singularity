Bootstrap: docker
From: khanlab/neuroglia-core:latest



#########
%setup
#########
mkdir $SINGULARITY_ROOTFS/mp2rage_correction
cp -Rv . $SINGULARITY_ROOTFS/mp2rage_correction

#########
%post
#########


#MCR
/opt/mp2rage_correction/install_scripts/05.install_MCR.sh /opt v93 R2017b


#########
%environment

export MCRROOT=/opt/mcr/v93
export PATH=/opt/mp2rage_correction/mcr/v93/mp2rage_correction:/opt/mp2rage_correction/bin:$PATH

%runscript
exec /opt/mp2rage_correction/mp2rage_correction $@






