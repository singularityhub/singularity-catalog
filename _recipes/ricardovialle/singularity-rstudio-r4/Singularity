BootStrap: docker
From: centos:centos7.9.2009
Stage: build

%labels
  Maintainer Wei Guo
  R_Version 4.0.3
  RStudio_Version 1.3.1903
  Adopted_from https://github.com/nickjer/singularity-rstudio

%help
  This will run RStudio Server

%apprun rserver
  exec rserver "${@}"

%runscript
  exec rserver "${@}"

%environment
  export PATH=/usr/lib/rstudio-server/bin:${PATH}

%setup
  install -Dv \
    rstudio_auth.sh \
    ${SINGULARITY_ROOTFS}/usr/lib/rstudio-server/bin/rstudio_auth
  install -Dv \
    ldap_auth.py \
    ${SINGULARITY_ROOTFS}/usr/lib/rstudio-server/bin/ldap_auth
  install -Dv \
    pam-helper.sh \
    ${SINGULARITY_ROOTFS}/usr/lib/rstudio-server/bin/pam-helper

%post
  # Software versions
  export R_VERSION=4.0.3
  export RSTUDIO_VERSION=1.3.1093

  # Install Dependencies
  yum install -y \
    ca-certificates \
    wget \
    build-essential \
    gcc \
    gcc-c++ \
    gcc-gfortran \
    make \
    which

  yum install -y xorg-x11-server-devel \
	libX11-devel libXt-devel \
	zlib zlib-devel \
	bzip2 bzip2-devel \
	xz xz-devel xz-libs \
	lzma lzma-devel lzma-libs \
	pcre2 pcre2-devel \
	curl libcurl libcurl-devel \
	readline readline-devel \
	openssl openssl-devel openssl-libs \
	libxml2 libxml2-devel \
	libgit2 libgit2-devel \
	unixODBC unixODBC-devel 

  # install R 4.0.3
  wget https://cran.r-project.org/src/base/R-4/R-${R_VERSION}.tar.gz -O R-${R_VERSION}.tar.gz
  tar -zxf R-${R_VERSION}.tar.gz
  cd R-${R_VERSION}
  ./configure --enable-R-shlib
  make -j6
  make install
  cd ..
  rm R-${R_VERSION}.tar.gz -f
  rm R-${R_VERSION} -rf

  # install some commonly used packages
  R --vanilla -e 'install.packages(c("DBI", "odbc", "shiny", "devtools", "ggplot2", "tidyverse", "tidymodels", "car", "dplyr", "tidyr"), repos="http://cran.us.r-project.org")'

  wget \
    --no-verbose \
    -O rstudio-server.rpm \
    "https://download2.rstudio.org/server/centos6/x86_64/rstudio-server-rhel-${RSTUDIO_VERSION}-x86_64.rpm"

  yum localinstall -y rstudio-server.rpm
  rm -f rstudio-server.rpm

  chmod 777 /var/run/rstudio-server

  # Add support for LDAP authentication
  wget \
    --no-verbose \
    -O get-pip.py \
    "https://bootstrap.pypa.io/get-pip.py"
  python get-pip.py
  rm -f get-pip.py
  pip install ldap3

  # Clean up
  rm -rf /var/lib/apt/lists/*
  yum clean all


