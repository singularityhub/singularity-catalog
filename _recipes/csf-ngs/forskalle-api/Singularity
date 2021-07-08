bootstrap: docker
From: ubuntu:20.04

%labels
  Author Heinz Axelsson-Ekker <heinz.ekker@vbcf.ac.at>

%help
  Container for forskalle-cli

  Run with --help for details.

%setup
  mkdir -p ${SINGULARITY_ROOTFS}/usr/src/forskalle-api
  cp -r . ${SINGULARITY_ROOTFS}/usr/src/forskalle-api

%post
  apt-get update -y
  apt-get install --no-install-recommends -y bash locales
  locale-gen en_US.UTF-8
  apt-get install -y python3 python3-pip zlib1g-dev libbz2-dev liblzma-dev
  pip3 install /usr/src/forskalle-api
  apt-mark manual python3-six python3-idna
  apt-get autoremove -y liblzma-dev libbz2-dev zlib1g-dev python3-pip

%environment
  export LC_ALL=en_US.UTF-8
  export PYTHONNOUSERSITE=1


%runscript
  fsk-cli "$@"

%apprun lib
  exec "$@"
  

 
%test
  export LC_ALL=en_US.UTF-8
  fsk-cli --help
