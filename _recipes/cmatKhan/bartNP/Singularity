BootStrap: debootstrap
OSVersion: bionic
MirrorURL: http://archive.ubuntu.com/ubuntu/
Include: bash

%help

Help me. I'm in the container.

%labels

    Maintainer Vanessasaurus

    Version v1.0

%post

  # setting R cran mirror. see https://cran.r-project.org/bin/linux/ubuntu/fullREADME.html
  apt install -y apt-transport-https software-properties-common
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
  add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/'

  # add sources to source list
  {
    echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse"
    echo "deb http://security.ubuntu.com/ubuntu/ bionic-security main restricted universe multiverse"
    echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe multiverse"
  } >> /etc/apt/sources.list

  apt update && apt upgrade -y && apt install -y \
    build-essential \
    curl \
    locales \
    libcurl4-openssl-dev \
    libncurses5-dev  \
    libncursesw5-dev \
    build-essential \
    pkg-config \
    zlib1g-dev \
    bzip2 \
    r-base \
    libcr-dev \
    mpich \
    mpich-doc \
    vim \
    && apt-get clean \
    && apt-get purge

  # build R dependencies
  R --slave -e 'install.packages(c("remotes", "BiocManager"), dependencies = TRUE, Ncpus = 8)'

  # note -- can put options to R CMD build here, eg those configurations for Rmpi
  R --slave -e 'remotes::install_github("cmatKhan/bartNP", upgrade = "always", force = TRUE, Ncpus = 8)'

#  --configure-args="  \\
#   --with-Rmpi-include=/path/to/mpi_include_dir         \\
#   --with-Rmpi-libpath=/path/to/mpi_lib_dir             \\
#   --with-Rmpi-type=MPICH}"
