BootStrap: docker
From: centos:7
%post
    . /.singularity.d/env/10-docker*.sh

# GNU compiler
%post
    yum install -y \
        gcc \
        gcc-c++ \
        gcc-gfortran
    rm -rf /var/cache/yum/*


