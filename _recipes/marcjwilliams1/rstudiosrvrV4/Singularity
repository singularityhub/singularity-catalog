Bootstrap: docker
From: rocker/r-ver:4.0.3

%files
  /rocker_scripts

%post
  export S6_VERSION=v1.21.7.0
  export RSTUDIO_VERSION=1.2.5042
  export PATH=/usr/lib/rstudio-server/bin:$PATH
  /rocker_scripts/install_rstudio.sh
  /rocker_scripts/install_pandoc.sh

  apt-get update
  apt-get install -y apt-utils

  set -e
  apt-get update -qq && apt-get -y --no-install-recommends install \
      libxml2-dev \
      libbz2-dev \
      zlib1g-dev \
      libncurses5-dev \
      libncursesw5-dev \
      liblzma-dev \
      libcairo2-dev \
      xz-utils \
      libgit2-dev \
      libglpk-dev \
      libxtst6 \
      default-libmysqlclient-dev \
      libpq-dev \
      libsasl2-dev \
      libsqlite3-dev \
      libssh2-1-dev \
      libgtk2.0-dev \
      xvfb \
      xauth \
      libxt-dev \
      xfonts-base \
      libpng-dev
	  ## other libraries listed in bioconductor https://hub.docker.com/r/bioconductor/bioconductor_full/dockerfile
apt-get update -qq && apt-get -y --no-install-recommends install \
	  libnetcdf-dev \
	  libhdf5-serial-dev \
	  libfftw3-dev \
	  libopenbabel-dev \
	  libopenmpi-dev \
	  libexempi8 \
	  libxt-dev \
	  libgdal-dev \
	  libjpeg8-dev \
	  libtiff5-dev \
	  libreadline-dev \
	  libgsl0-dev \
	  libgslcblas0 \
	  libgtk2.0-dev \
	  libgl1-mesa-dev \
	  libglu1-mesa-dev \
	  libgmp3-dev \
	  libhdf5-dev \
	  libncurses-dev \
	  libbz2-dev \
	  libxpm-dev \
	  liblapack-dev \
	  libv8-dev \
	  libgtkmm-2.4-dev \
	  libmpfr-dev \
	  libudunits2-dev \
	  libmodule-build-perl \
	  libapparmor-dev \
	  libgeos-dev \
	  libprotoc-dev \
	  librdf0-dev \
	  libmagick++-dev \
	  libsasl2-dev \
	  libpoppler-cpp-dev \
	  libprotobuf-dev \
	  libpq-dev \
	  libperl-dev \
	  libarchive-extract-perl \
	  libfile-copy-recursive-perl \
	  libcgi-pm-perl \
	  libdbi-perl \
	  libdbd-mysql-perl \
	  libxml-simple-perl \
	  sqlite \
	  openmpi-bin \
	  mpi-default-bin \
	  openmpi-common \
	  openmpi-doc \
	  tcl8.6-dev \
	  tk-dev \
	  default-jdk \
	  imagemagick \
	  tabix \
	  ggobi \
	  graphviz \
	  protobuf-compiler \
	  jags \
	  xfonts-100dpi \
	  xfonts-75dpi \
	  biber \
	  unixodbc-dev \
	  && apt-get clean && \
    rm -rf /var/lib/apt/lists/*
