BootStrap: docker
From: r-base:4.0.4

%labels
  Maintainer Wei Guo
  R_Version 4.0.4
  RStudio_Version 1.3.1093
  Adopted_from https://github.com/nickjer/singularity-rstudio

%help
  This will run RStudio Server

%apprun rserver
  exec rserver "${@}"

%runscript
  exec rserver "${@}"

%environment
  export PATH=/usr/lib/rstudio-server/bin:${PATH}

%files
  jranke.asc /tmp/jranke.asc

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

  install -Dv \
    jranke.asc \
    ${SINGULARITY_ROOTFS}/tmp/jranke.asc
  
%post
  # Software versions
  export R_VERSION=4.0.4
  export RSTUDIO_VERSION=1.3.1093
  export DEBIAN_FRONTEND=noninteractive

  apt-get update -y
  apt-get install -y software-properties-common dirmngr
  apt-get install -y \
    locales \
    gnupg2 \
    wget \
    libatlas3-base \
    ca-certificates

  # Configure default locale
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
  locale-gen en_US.utf8
  /usr/sbin/update-locale LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8


  # Install R
  apt-key add /tmp/jranke.asc
  add-apt-repository "deb http://cloud.r-project.org/bin/linux/debian $(lsb_release -cs)-cran40/"

  apt-get update -y
  apt-get upgrade -y
  apt-get install -y --no-install-recommends --allow-unauthenticated --fix-missing --fix-broken \
    r-base=${R_VERSION}* \
    r-base-core=${R_VERSION}* \
    r-base-dev=${R_VERSION}* \
    r-base-html=${R_VERSION}* \
    r-doc-html=${R_VERSION}* \
    r-recommended=${R_VERSION}* \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libcairo2-dev \
    unixodbc-dev \
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
  R --vanilla -e 'options(Ncpus=4); install.packages(c("DBI", "odbc", "shiny", "devtools", "ggplot2", "tidyverse", "tidymodels", "car", "dplyr", "tidyr", "BiocManager"), repos="http://cran.us.r-project.org")'

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

