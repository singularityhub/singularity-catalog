BootStrap: shub
From: tpall/singularity-r:latest

%labels
  Maintainer tpall

%help
  This will run R tidyverse + some other packages

%post
  ## Download and install tidyverse & other packages
  apt-get update -qq \
  && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libgit2-dev \
    default-libmysqlclient-dev \
    libpq-dev \
    libsasl2-dev \
    libsqlite3-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libudunits2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libgdal-dev \
    libgsl-dev \
    libnode-dev \
    libharfbuzz-dev \
    libfribidi-dev \
  && install2.r --error \
    --deps TRUE \
    --skipinstalled \
    tidyverse \
    lubridate \
    remotes \
    rmarkdown \
    bookdown \
    vroom \
    gert \
    readxl \
    here
