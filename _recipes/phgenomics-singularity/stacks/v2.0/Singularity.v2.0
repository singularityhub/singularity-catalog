Bootstrap: docker
From: ubuntu:trusty-20170817

%help
A Singularity image for Stacks v2.0

%labels
Maintainer Anders Goncalves da Silva
Build 1.0
Stacks v2.0 (with SparseHash)

%post

  STACKS_VERSION=2.0

  sudo locale-gen en_US.UTF-8
  sudo update-locale

  sudo apt-get --yes update
  sudo apt-get --yes install build-essential autoconf automake wget git zlib1g-dev libbz2-dev libncurses5-dev curl unzip
  sudo apt-get --yes install libdbd-mysql-perl

  sudo apt-get --yes install software-properties-common
  sudo add-apt-repository --yes ppa:ubuntu-toolchain-r/test
  sudo apt-get --yes update
  sudo apt-get --yes install g++-4.9

  cd /tmp

  echo "Installing Stacks"

  STACKS_URL="http://catchenlab.life.illinois.edu/stacks/source/stacks-${STACKS_VERSION}.tar.gz"
  STACKS_ZIP=stacks.tar.gz
  wget -O ${STACKS_ZIP} "${STACKS_URL}"
  tar xf ${STACKS_ZIP}
  cd stacks-${STACKS_VERSION}
  CC=gcc-4.9 CXX=g++-4.9 ./configure --enable-sparsehash
  make -j4
  sudo make install
  sudo mkdir /tests
  sudo mv tests/* /tests

  echo "Sorting some env variables..."
  sudo echo 'LANGUAGE="en_US:en"' >> $SINGULARITY_ENVIRONMENT
  sudo echo 'LC_ALL="en_US.UTF-8"' >> $SINGULARITY_ENVIRONMENT
  sudo echo 'LC_CTYPE="UTF-8"' >> $SINGULARITY_ENVIRONMENT
  sudo echo 'LANG="en_US.UTF-8"' >>  $SINGULARITY_ENVIRONMENT

  echo "Done"

%runscript
  echo "Welcome to STACKS 2.0" >&2
  exec "$@"

%test
  echo "Testing STACKS"
  # for testfile in $(ls /tests/*.t);
  # do
  #   bash ${testfile};
  # done
