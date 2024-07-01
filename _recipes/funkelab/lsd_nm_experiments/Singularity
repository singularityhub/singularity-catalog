Bootstrap: library
From: ubuntu:18.04

%setup
  mkdir -p ${SINGULARITY_ROOTFS}/src/files

%files
  lsd_legacy.yml /src/files/lsd_legacy.yml
  cudatoolkit-8.0-3.tar.bz2 /src/files/cudatoolkit-8.0-3.tar.bz2
  cudnn-6.0.21-cuda8.0_0.tar.bz2 /src/files/cudnn-6.0.21-cuda8.0_0.tar.bz2

%post
  apt update
  apt install -y --no-install-recommends \
  build-essential \
  ca-certificates \
  cmake \
  git \
  libmlpack-dev \
  liblzma-dev \
  libboost-all-dev \
  wget && \
  rm -rf /var/lib/apt/lists/*

  wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
  bash miniconda.sh -b -p /opt/conda

  cd /src/files

  /opt/conda/bin/conda env create -f lsd_legacy.yml
  /opt/conda/bin/conda install -n lsd_legacy cudatoolkit-8.0-3.tar.bz2
  /opt/conda/bin/conda install -n lsd_legacy cudnn-6.0.21-cuda8.0_0.tar.bz2

%runscript
    exec /opt/conda/envs/lsd_legacy/bin/"$@"
