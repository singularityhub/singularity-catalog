Bootstrap: docker
From: centos:7
%post 
yum install -y git gcc-c++ make wget zlib-devel unzip
git clone https://github.com/alexdobin/STAR.git
cd STAR/source
make STAR
%environment
export PATH=/STAR/source:$PATH
