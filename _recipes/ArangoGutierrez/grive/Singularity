# Google Drive client
#

  Bootstrap: docker
  From: ubuntu

%post
# Set up the basics
  apt-get -y update
  apt-get install -y build-essential
  apt-get install -y git cmake build-essential libgcrypt11-dev libyajl-dev \
  libcurl4-openssl-dev libexpat1-dev binutils-dev
  apt-get -y update
  apt-get install -y zlib1g-dev libncurses5-dev libssl-dev pkg-config \
  libboost-all-dev libcppunit-dev
# Install grive 
  mkdir -p /home/grive/Driveclient
  cd /home/grive/Driveclient
  git clone https://github.com/vitalif/grive2
  cd grive2
  mkdir build
  cd build
  cmake ..
  make -j4
  make install

%runscript 
  grive "$@"
