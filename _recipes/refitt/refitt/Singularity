# SPDX-FileCopyrightText: 2019-2021 REFITT Team
# SPDX-License-Identifier: Apache-2.0

BootStrap: docker
From: ubuntu:20.04

%help
    Recommender Engine for Intelligent Transient Tracking

%labels
    App         refitt
    Version     0.16.5
    Website	    github.com/refitt/refitt
    Maintainer  Geoffrey Lentner
    CreatedBy   glentner@purdue.edu
    BaseImage   Ubuntu 20.04 LTS

%setup
    wget -c https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

%environment
    export CONDA_SHLVL=1
    export CONDA_EXE=/opt/conda/bin/conda
    export CONDA_PREFIX=/opt/conda
    export CONDA_ENVS_PATH=/opt/conda/envs
    export CONDA_PYTHON_EXE=/opt/conda/bin/python
    export CONDA_DEFAULT_ENV=base
    export PATH=/opt/conda/bin:$PATH
    export PKG_CONFIG_PATH=/opt/conda/lib/pkgconfig:$PKG_CONFIG_PATH
    export LD_LIBRARY_PATH=/opt/conda/lib:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=/opt/conda/lib/python3.8:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=/opt/conda/lib/python3.8/site-packages:$LD_LIBRARY_PATH
    export LANG=C
    export LC_ALL=C

%files
    Miniconda3-latest-Linux-x86_64.sh /Miniconda3-latest-Linux-x86_64.sh

%post
    mkdir -p /home /apps /scratch /depot
    mkdir -p /var/opt /run/user

    apt-get update && apt-get upgrade -y
    apt-get --yes clean

    bash /Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda
    rm /Miniconda3-latest-Linux-x86_64.sh

    /opt/conda/bin/conda update -n base -c defaults conda
    /opt/conda/bin/conda install python=3.8
    /opt/conda/bin/conda install numpy scipy "pyarrow>=3" "tensorflow>=2.4.1" "blas=*=blis" -c conda-forge
    /opt/conda/bin/conda install pandas numba astropy sqlalchemy psycopg2 requests flask gunicorn \
                                 matplotlib seaborn h5py pytables -c conda-forge
    /opt/conda/bin/pip install cryptography cmdkit toml streamkit names_generator \
                               antares-client slackclient rich parsl astroplan timezonefinder pytz bs4 jinja2

    /opt/conda/bin/pip install . --no-deps

%runscript
    exec refitt "$@"
