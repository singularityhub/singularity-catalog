BootStrap: oras
From: ghcr.io/truatpasteurdotfr/singularity-docker-centos7-ci:latest

%post
yum -y update && yum -y upgrade && \
yum -y install wget bzip2 gcc gcc-c++ gcc-gfortran make && \
yum -y groupinstall development && \
yum -y clean all && \
date +"%Y-%m-%d-%H%M" > /last_update

cat <<EOF > /etc/yum.repos.d/oneAPI.repo
[oneAPI]
name=Intel® oneAPI repository
baseurl=https://yum.repos.intel.com/oneapi
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
EOF

yum -y install \
        intel-basekit
