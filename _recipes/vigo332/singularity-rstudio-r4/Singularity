BootStrap: docker
From: ubuntu:20.04

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
  export DEBIAN_FRONTEND=noninteractive

  # Get dependencies
  apt-get update -qq 
  apt-get install -y --no-install-recommends software-properties-common dirmngr
  apt-get install -y --no-install-recommends \
    locales \
    gnupg2 \
    wget \
    ca-certificates

  # Configure default locale
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
  locale-gen en_US.utf8
  /usr/sbin/update-locale LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8


  wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
  add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

  # Install R
  #  echo "deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/" > /etc/apt/sources.list.d/r.list
  #  cat /etc/apt/sources.list.d/r.list
  #  add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'
  # apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
  # apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

  apt-get install -y --no-install-recommends --allow-unauthenticated --fix-missing --fix-broken \
    r-base \
    r-base-core \
    r-base-dev \
    r-recommended \
    r-base-html \
    r-doc-html \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libcairo2-dev \
    libxt-dev \
    wget \
    libgsl-dev \
    gdebi-core

  # Add a default CRAN mirror
  echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/lib/R/etc/Rprofile.site

  # Install Rstudio
  wget \
    --no-verbose \
    -O rstudio-server.deb \
    "https://download2.rstudio.org/server/bionic/amd64/rstudio-server-${RSTUDIO_VERSION}-amd64.deb"
  gdebi -n rstudio-server.deb
  rm -f rstudio-server.deb

  # install some commonly used packages
  R --vanilla -e 'install.packages(c("DBI", "odbc", "shiny", "devtools", "ggplot2", "tidyverse", "tidymodels", "car", "dplyr", "tidyr"), repos="http://cran.us.r-project.org")'

  # Add a directory for host R libraries
  mkdir -p /library
  echo "R_LIBS_SITE=/library:\${R_LIBS_SITE}" >> /usr/lib/R/etc/Renviron.site

  # Add support for LDAP authentication
  wget \
    --no-verbose \
    -O get-pip.py \
    "https://bootstrap.pypa.io/get-pip.py"
  python3 get-pip.py
  rm -f get-pip.py
  pip3 install ldap3

  # Clean up
  rm -rf /var/lib/apt/lists/*

