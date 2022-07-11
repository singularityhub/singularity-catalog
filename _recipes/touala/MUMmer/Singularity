Bootstrap:docker
From:debian:8

# Adapted from https://forgemia.inra.fr/gafl/singularity/mummer

%environment
LC_ALL=C
export LC_ALL
LC_NUMERIC=en_US.UTF-8
export LC_NUMERIC
export PATH="/usr/local/bin:$PATH"

%runscript
   exec mummer "$@"

%post
  apt-get update && apt-get -y install git man build-essential python-dev curl unzip libz-dev libbz2-dev gnuplot slang-xfig

  cd /opt
  curl -o mummer.tar.gz -L https://github.com/mummer4/mummer/releases/download/v4.0.0rc1/mummer-4.0.0rc1.tar.gz
  tar -xvzf mummer.tar.gz
  cd mummer-*/
  ./configure --prefix=/usr/local
  make -j10
  make install
  ldconfig

  # Clean up image
  cd /opt
  rm -fr mummer-*.tar.gz
  rm -fr mummer-*/
  apt-get autoremove --purge
  apt-get clean
