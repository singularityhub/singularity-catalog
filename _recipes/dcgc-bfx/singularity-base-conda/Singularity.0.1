Bootstrap: docker
From: continuumio/miniconda3:latest

%labels
    Author fabian.rost@tu-dresden.de
    Organisation DcGC
    Version v0.0.1

%help
    Base container based on conda docker container with basic python and R
    packages installed.

%environment
  DEBIAN_FRONTEND=noninteractive

%post
  export PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

  apt-get update --fix-missing
  apt-get install -y \
    build-essential \
    gawk \
    git \
    p7zip-full \
    unzip

  apt-get clean
  rm -rf /var/lib/apt/lists/*

  conda update --quiet --yes conda
  conda config --add channels defaults
  conda config --add channels bioconda
  conda config --add channels conda-forge

  conda install --quiet --yes mamba

  mamba update --quiet --yes --all

  mamba install --quiet --yes \
    blosc \
    bottleneck \
    cmake \
    fastparquet \
    fsspec \
    gcsfs \
    html5lib \
    jinja2 \
    lxml \
    matplotlib \
    mscorefonts \
    numba \
    numexpr \
    openpyxl \
    pandas \
    pip \
    pyarrow \
    pyreadstat \
    pytables \
    pyyaml \
    rpy2 \
    scipy \
    seaborn \
    tabulate \
    zlib \
    `# R packages` \
    r-base>=4.0.3 \
    r-data.table \
    r-devtools \
    r-dplyr \
    r-essentials \
    r-ggplot2 \
    r-ggpubr \
    r-ggsci \
    r-ggsignif \
    r-hmisc \
    r-knitr \
    r-magrittr \
    r-matrix \
    r-purrr \
    r-usethis \
    r-r.utils \
    r-rcolorbrewer \
    r-reticulate \
    r-tidyr \
    r-tidyverse \
    r-xlsx

  mamba clean --quiet --yes --all

  chmod -R a+w /opt
