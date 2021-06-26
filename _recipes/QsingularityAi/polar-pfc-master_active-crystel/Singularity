Bootstrap: docker
From: debian:buster

%labels
  Author simon.praetorius@tu-dresden.de"
  Version v0.1

%files
  code /app

%post     # install system dependencies
  apt-get update -y
  apt-get install -y --no-install-recommends \
      build-essential \
      ca-certificates \
      cmake \
      g++-8 \
      gcc-8 \
      git \
      libalglib-dev \
      libboost-dev \
      libeigen3-dev \
      libfftw3-dev \
      zlib1g-dev
  apt-get clean
  rm -rf /var/lib/apt/lists/*

%post     # download external dependencies
  mkdir -p /tmp/sources && cd /tmp/sources
  git clone https://github.com/jlblancoc/nanoflann.git --single-branch --branch master
  git clone https://bitbucket.org/nschaeff/shtns.git --single-branch --branch master

  cd /tmp/sources/shtns
  ./configure --prefix=/opt/software/shtns --enable-openmp
  make && make install

  mkdir -p /opt/software/nanoflann/include
  cp /tmp/sources/nanoflann/include/*.hpp /opt/software/nanoflann/include

  rm -rf /tmp/sources

%post     # compile the project code
  mkdir /app/build && cd /app/build
  cmake -DCMAKE_BUILD_TYPE=Release \
        -DSHTNS_LIB:PATH=/opt/software/shtns/lib \
        -DSHTNS_INC:PATH=/opt/software/shtns/include \
        -DNANOFLANN_INC:PATH=/opt/software/nanoflann/include \
        -DALGLIB_INC:PATH=/usr/include/libalglib /app
  make

%environment
  export PATH=/app/build:$PATH

%runscript
  /app/build/polar_pfc $@
