Bootstrap: docker
From: ubuntu:14.04
#########
%setup
#########
mkdir -p $SINGULARITY_ROOTFS/src
cp silent.cfg $SINGULARITY_ROOTFS/src

#########
%post
#########
apt-get update
apt-get install -y lsb-core wget


cd /src
wget http://registrationcenter-download.intel.com/akdlm/irc_nas/9019/opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25.tgz 
tar -xvzf opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25.tgz
mv silent.cfg opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25
cd opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25
./install.sh --silent silent.cfg --cli-mode

apt-get install -y libblas-dev liblapack-dev
apt-get install -y python3 python3-pip python3-pyopencl python3-numpy python3-scipy python3-pyqt5 python3-matplotlib python3-six python3-yaml libpng-dev libfreetype6-dev libxft-dev
pip3 install mdt


