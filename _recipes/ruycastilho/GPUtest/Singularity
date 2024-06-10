# Automatic

Bootstrap: docker
From: nvidia/cuda:8.0-runtime-ubuntu14.04

%post

    apt-get update
    apt-get -y install build-essential
    apt-get -y install apt-utils
    apt-get -y install make
    apt-get -y install cmake
	apt-get -y install wget
    apt-get -y install flex
    apt-get -y install automake
    apt-get -y install autoconf
    apt-get -y install autotools-dev
    apt-get -y install libtool
    apt-get -y install gcc
    export TERM=xterm
    apt-get install -y linux-headers-generic
    
    # OpenCL	
    cd /tmp
    wget -q "http://registrationcenter-download.intel.com/akdlm/irc_nas/vcp/11705/intel_sdk_for_opencl_2017_7.0.0.2511_x64.tgz"
    tar -zxvf intel_sdk_for_opencl_2017_7.0.0.2511_x64.tgz
    cd intel_sdk_for_opencl_2017_7.0.0.2511_x64/
    chmod +x install_GUI.sh
    sed "s/ACCEPT_EULA=decline/ACCEPT_EULA=accept/g" silent.cfg > accept.cfg
    ./install.sh -s accept.cfg

    cd /tmp
    wget -q "http://registrationcenter-download.intel.com/akdlm/irc_nas/9019/opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25.tgz"
    tar -zxvf opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25.tgz
    cd opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25/
    chmod +x install.sh
    sed "s/ACCEPT_EULA=decline/ACCEPT_EULA=accept/g" silent.cfg > accept.cfg
    ./install.sh -s accept.cfg
    
    apt-get update
    apt-get -y install nvidia-opencl-icd-375
    apt-get -y install nvidia-modprobe
    apt-get -y install ocl-icd-opencl-dev
    apt-get -y install clinfo

    # openmpi
    apt-get update
    apt-get -y install openmpi-bin
    apt-get -y install openmpi-doc
    apt-get -y install libopenmpi-dev