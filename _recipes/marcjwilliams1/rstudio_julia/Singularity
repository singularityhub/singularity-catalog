Bootstrap: docker
From: rocker/r-ver:4.0.3

%files
  /rocker_scripts

%environment
    export JULIA_DEPOT_PATH=$PWD/precompile:/user/.julia
    export PATH=/opt/julia/bin:$PATH

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


    mkdir -p /user
    export HOME=/user
    export JULIA_DEPOT_PATH=/user/.julia
    export PATH=/opt/julia/bin:$PATH

	apt-get update -qq && apt-get -y --no-install-recommends install \
	  curl \
	  tar \
	  gzip \
	  git \
	  openssh-client \
	  ca-certificates \
	  wget

    JULIA_MAJOR=1.5
    JULIA_MINOR=.3

	wget -O julia.tar.gz "https://julialang-s3.julialang.org/bin/linux/x64/1.5/julia-1.5.3-linux-x86_64.tar.gz"
	ls -lth julia.tar.gz
    mkdir /opt/julia
    tar xzf julia.tar.gz -C /opt/julia
    rm julia.tar.gz
    mv /opt/julia/$(cd /opt/julia; echo julia-*)/* opt/julia/
    rm -rf /opt/julia/$(cd /opt/julia; echo julia-*)

	ln -s /opt/julia/bin/julia /usr/local/bin/julia

    rm -rf /opt/julia/share/doc
    rm -rf /opt/julia/share/icons
    rm -rf /opt/julia/share/appdata
    rm -rf /opt/julia/share/applications
    rm -rf /opt/julia/share/man
    rm -rf /opt/julia/share/julia/test
    rm /opt/julia/LICENSE.md
    rm -rf /opt/julia/etc
    rm -rf /opt/julia/include

	mkdir -p /opt/julia/local/share/julia
  mkdir -p /user/.julia/environments/$JULIA_MAJOR
	mkdir -p /usr/.julia/
	mkdir -p /opt/.julia/

	julia -e 'using Pkg; Pkg.add("Distributions")'
	julia -e 'using Pkg; Pkg.add("ApproxBayes")'
	julia -e 'using Pkg; Pkg.add(PackageSpec(url="https://github.com/marcjwilliams1/CINulator.jl"))'
