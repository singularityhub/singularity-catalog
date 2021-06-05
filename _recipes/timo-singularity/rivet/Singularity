#Bootstrap: library
#From: centos:8
Bootstrap: docker
From: centos:8

%help

  Base container with Rivet

%environment
  
  . /usr/local/rivetenv.sh

%post
  
  yum -y update
  #yum -y install python3 python3-devel python3-pip
  
  yum -y groupinstall 'Development Tools'
  yum -y install openssl-devel bzip2-devel libffi-devel
  yum -y install wget
  wget https://www.python.org/ftp/python/3.8.10/Python-3.8.10.tgz
  tar xf Python-3.8.10.tgz
  rm Python-3.8.10.tgz
  cd Python-3.8*
  ./configure --enable-optimizations
  make altinstall
  ln -fs /usr/local/bin/python3.8 /usr/bin/python
  
  yum -y install zlib-devel
  yum -y install gcc-gfortran cmake

  wget https://gitlab.com/hepcedar/rivetbootstrap/raw/3.1.0/rivet-bootstrap
  chmod +x rivet-bootstrap
  INSTALL_PREFIX=/usr/local ./rivet-bootstrap

  ldconfig
  yum clean all
