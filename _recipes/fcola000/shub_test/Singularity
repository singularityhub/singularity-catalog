Bootstrap: docker
From: centos:centos7.4.1708
IncludeCmd: yes

%labels
AUTHOR f.cola@cineca.it
VERSION 1.0
Event 17th Adv School on HPC in CINECA
ContainerName Exercise 01 

%files
hello_world_openMP.c /data/

%post

yum -y update
yum install -y vim which wget tar bzip2

####### GNU 7.3.1 installation #######
# On CentOS, install package centos-release-scl available in CentOS repository
yum -y install centos-release-scl

# 2. Install the collection:
yum -y install devtoolset-7

####### GNU 7.3.1 General environment variables settings #######

export PATH=/opt/rh/devtoolset-7/root/usr/bin:${PATH}
export LD_LIBRARY_PATH=/opt/rh/devtoolset-7/root/usr/lib:${LD_LIBRARY_PATH}

####### Test the location and version of your GNU compiler #######
which gcc 
gcc --version 


####### Create a workdir directory #######
mkdir /workdir


%environment

export PATH=/opt/rh/devtoolset-7/root/usr/bin:${PATH}
export LD_LIBRARY_PATH=/opt/rh/devtoolset-7/root/usr/lib:${LD_LIBRARY_PATH}

