Bootstrap: docker
From: centos:7

%labels
Maintainer Matthew Flister

%help
This container includes Xfce desktop.

%environment 
    SHELL=/bin/bash
    export SHELL

%post
    # default mount points
    mkdir -p /scratch/global /scratch/local /rcc/stor1/refdata /rcc/stor1/projects /rcc/stor1/depts

    # Install necessary packages
    yum update -y && yum install -y epel-release
    yum -y groupinstall Xfce
    yum -y install xorg-x11-fonts-Type1 xorg-x11-fonts-misc
    yum clean all
