BootStrap: docker
From: ubuntu:20.04

%labels
    Maintainer Yoshihiro okuda
    Version    v1.0

%files

%environment
    export LD_LIBRARY_PATH=/opt/NVIDIA-Linux-x86_64-460.73.01:$LD_LIBRARY_PATH
    export OMP_NUM_THREADS=1

%post
    apt-get update
    apt-get -y install git wget python3-pip
    INSTALLDIR=/opt/
    mkdir -p ${INSTALLDIR}
    cd ${INSTALLDIR}
    git clone https://github.com/HeliXonProtein/OmegaFold.git
    cd OmegaFold
    git checkout refs/tags/v1.1.0

    pip install -r requirements.txt

    # 遺伝研スパコンのGPUでcuda11を使用できるように、対応するバージョンのnvidia driverをインストール
    cd /usr/local/src
    wget https://us.download.nvidia.com/tesla/460.73.01/NVIDIA-Linux-x86_64-460.73.01.run
    chmod +x NVIDIA-Linux-x86_64-460.73.01.run
    ./NVIDIA-Linux-x86_64-460.73.01.run -x
    mv NVIDIA-Linux-x86_64-460.73.01 /opt
    cd /opt/NVIDIA-Linux-x86_64-460.73.01
    ln -s libcuda.so.460.73.01 libcuda.so.1
    ln -s libcuda.so.460.73.01 libcuda.so
    ln -s libnvidia-ptxjitcompiler.so.460.73.01 libnvidia-ptxjitcompiler.so.1
    ln -s libnvidia-ptxjitcompiler.so.460.73.01 libnvidia-ptxjitcompiler.so

    rm /usr/local/src/NVIDIA-Linux-x86_64-460.73.01.run

    # cuda-toolkitをインストール
    export DEBIAN_FRONTEND=noninteractive
    apt-get -y install libxml2-dev
    export TZ=Asia/Tokyo
    cd /usr/local/src
    wget https://developer.download.nvidia.com/compute/cuda/11.3.0/local_installers/cuda_11.3.0_465.19.01_linux.run
    chmod +x cuda_11.3.0_465.19.01_linux.run
    ./cuda_11.3.0_465.19.01_linux.run --toolkit --silent
    rm /usr/local/src/cuda_11.3.0_465.19.01_linux.run

