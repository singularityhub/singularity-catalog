BootStrap: shub
From: tpall/singularity-r:4.0.3

%labels
  Maintainer tpall

%help
  This will run R packages to fit stan models

%post
  ## Download and install tidyverse & other packages
  apt-get update -qq \
  && apt-get -y --no-install-recommends install \
    libssh2-1-dev \
    libudunits2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libgdal-dev \
    libgsl-dev \
    libnode-dev \
    libnlopt-dev \
    libfontconfig1-dev \
    libmagick++-dev \
    cargo \
    jags \
    libharfbuzz-dev \
    libfribidi-dev \
    git \
  && install2.r --deps TRUE \
    --skipinstalled \
    readr \
    dplyr \
    ggplot2 \
    stringr \
    lubridate \
    purrr \
    gt \
    extrafont \
    cowplot \
    patchwork \
    viridisLite \
    tidybayes \
    here \
    remotes \
  && Rscript -e 'remotes::install_github("stan-dev/rstan", ref = "develop", subdir = "rstan/rstan", build_opts = "")' \
  && install2.r --deps TRUE --skipinstalled brms
