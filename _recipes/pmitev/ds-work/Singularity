Bootstrap: docker
From: ubuntu:20.04
 
%files
  install.R    /tmp
  installDS.R  /tmp

%environment
  export PYTHONNOUSERSITE=True
  export LANG=C.UTF-8 LC_ALL=C.UTF-8
  export XDG_RUNTIME_DIR=/tmp/.run_$(uuidgen)
 
%runscript
  export XDG_RUNTIME_DIR=/tmp/.run_$(uuidgen)
  mkdir -p $XDG_RUNTIME_DIR
  /bin/bash

 
%post
  export DEBIAN_FRONTEND=noninteractive
  export LC_ALL=C
  export NCPU=$(grep -c ^processor /proc/cpuinfo)
 
  apt-get update && \
  apt-get -y --no-install-recommends install --fix-missing \
        vim nano wget curl build-essential \
        python3-pip uuid-runtime \
        libxml2-dev libcairo2-dev libsqlite3-dev libmariadbd-dev libpq-dev libssh2-1-dev unixodbc-dev libcurl4-openssl-dev libssl-dev libbz2-dev liblzma-dev \
        libz-dev libpng-dev default-jre default-jdk libjpeg-dev libglpk-dev libxt-dev libv8-dev \
        libgl1-mesa-glx libdbus-1-3 libnss3 libxcomposite1 libxcursor1 libxi6 libxtst6

  python3 -m pip install --no-cache-dir umap-learn==0.5.0

  mkdir /installs && cd /installs

  # R-cran
  apt-get -y  install dirmngr gnupg apt-transport-https ca-certificates software-properties-common
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
  add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'
  apt-get update && apt-get -y  install r-base=4.0.3-1.2004.0
 
#  # R 4.0.3
#  export R_VERSION=4.0.3
#  curl -L https://rstd.io/r-install > r-install.sh
#  chmod +x r-install.sh
#  ./r-install.sh install $R_VERSION -y
#  /opt/R/${R_VERSION}/bin/R --version
#  ln -s /opt/R/${R_VERSION}/bin/R /usr/local/bin/R
#  ln -s /opt/R/${R_VERSION}/bin/Rscript /usr/local/bin/Rscript
 
  # Rstudio desktop
  wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.4.1103-amd64.deb
  apt-get -y --no-install-recommends install --fix-missing  ./rstudio-1.4.1103-amd64.deb
  
  # Install R packages ====================
  R -f /tmp/install.R
  R -f /tmp/installDS.R
  
  # Clean
  cd /
  rm -rf /var/lib/apt/lists/*
  rm -rf /installs
