BootStrap: docker
From: ubuntu:20.04

%runscript
  exec rserver "${@}"

%environment
  export PATH=/usr/lib/rstudio-server/bin:${PATH}

%post
  apt-get update
  apt-get install -y --no-install-recommends \
    locales \
    aptitude \
    gnupg \
    software-properties-common \
    dirmngr

  # Configure default locale
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
  locale-gen en_US.utf8
  /usr/sbin/update-locale LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8

  #echo "deb https://cran.r-project.org/bin/linux/ubuntu focal-cran40/" > /etc/apt/sources.list.d/r.list
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
  add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/"
  apt-get update

  # Install dependencies.
  aptitude install -y \
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
    libpng-dev \
    libfreetype6-dev \
    libtiff5-dev \
    libjpeg-dev \
    libgsl-dev \
    librsvg2-dev \
    libnode-dev \
    libv8-dev \
    software-properties-common \
    libharfbuzz-dev \
    librsvg2-dev \
    libproj-dev \
    libbz2-dev \
    liblzma-dev \
    zlib1g-dev \
    libfribidi-dev

  # Disable session timeout
  # echo "session-timeout-minutes=0" > /etc/rstudio/rsession.conf

  # Add a default CRAN mirror
  echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/lib/R/etc/Rprofile.site

  # Install RStudio
  apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    gdebi-core
  wget \
    --no-verbose \
    -O rstudio-server.deb \
    "https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1717-amd64.deb"
  gdebi -n rstudio-server.deb
  rm -f rstudio-server.deb
