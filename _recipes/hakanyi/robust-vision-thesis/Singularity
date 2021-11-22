bootstrap: docker
from: nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

%files
  mitsuba.conf /media 
  NVIDIA-OptiX-SDK-7.1.0-linux64-x86_64.sh /media/NVIDIA-OptiX-SDK.sh
  libcuda.so /usr/lib64/libcuda.so

%environment
  export LC_ALL=en_US.utf8

  export PATH=$PATH:/poetry/bin

  export PATH=$PATH:/mitsuba2/dist
  export PYTHONPATH=/mitsuba2/dist/python

  export TMPDIR=$PWD/.tmp

  if [ -d ${PWD}/.tmp ];then
      rm -rf ${PWD}/.tmp
  fi
  mkdir ${PWD}/.tmp

  export POETRY_VIRTUALENVS_IN_PROJECT=1

%runscript
  exec bash "$@"

%post
  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y locales
  locale-gen en_US.utf8 
  export LC_ALL=en_US.utf8
  apt-get install -y \
                 git \
                 wget \
			           curl \
                 nano \
			           graphviz \
			           ffmpeg \
			           libglu1-mesa \
			           libxi6 \
			           tk-dev \
			           libx11-6 \
			           xvfb \
			           libaec0 \
			           libgfortran3 \
			           libhdf5-dev \
			           libsz2 \
			           hdf5-tools \
			           libaec0 \
			           libgfortran3 \
			           libsz2 \
			           python3-pip \
			           python3-venv \
                 python3-dev python3-distutils python3-setuptools \
                 python3-pytest python3-pytest-xdist python3-numpy \
                 clang-9 libc++-9-dev libc++abi-9-dev cmake ninja-build \
                 libz-dev libpng-dev libjpeg-dev libxrandr-dev libxinerama-dev libxcursor-dev
  apt-get clean

  # set up OptiX
  mkdir -p /opt/optix
  /bin/sh /media/NVIDIA-OptiX-SDK.sh --skip-license --prefix=/opt/optix
  rm -f /media/NVIDIA-OptiX-SDK.sh

  # set up mitsuba 2 
  export CC=clang-9
  export CXX=clang++-9
  export CUDACXX=/usr/local/cuda/bin/nvcc
  ## original repo
  git clone -b pathreparam-optix7 --single-branch --recursive https://github.com/mitsuba-renderer/mitsuba2 /mitsuba2-root
  mv /media/mitsuba.conf /mitsuba2-root
  mkdir /mitsuba2 && cd /mitsuba2
  cmake -GNinja /mitsuba2-root && ninja
  rm -rf /mitsuba2-root
  chmod +x /mitsuba2/dist/*

  # set up poetry (package manager for python)
  export POETRY_HOME=/poetry
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python3.6 -
  chmod +x /poetry/bin/*

  rm -rf /tmp/*
