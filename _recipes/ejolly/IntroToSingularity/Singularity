# Singularity definition example with miniconda
# Matteo Visconti di Oleggio Castello; Eshin Jolly
# mvdoc.gr@dartmouth.edu; eshin.jolly.gr@dartmouth.edu
# May 2017

bootstrap: docker
from: neurodebian:jessie

# this command assumes singularity 2.3
%environment
    PATH="/usr/local/anaconda/bin:$PATH"
%post
    # install debian packages
    apt-get update
    apt-get install -y eatmydata
    eatmydata apt-get install -y wget bzip2 \
      ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 \
      git git-annex-standalone
    apt-get clean

    # install anaconda
    if [ ! -d /usr/local/anaconda ]; then
         wget https://repo.continuum.io/miniconda/Miniconda2-4.3.14-Linux-x86_64.sh \
            -O ~/anaconda.sh && \
         bash ~/anaconda.sh -b -p /usr/local/anaconda && \
         rm ~/anaconda.sh
    fi
    # set anaconda path
    export PATH="/usr/local/anaconda/bin:$PATH"

    # install the bare minimum
    conda install\
      numpy scipy
    conda clean --tarballs

    # make /data and /scripts so we can mount it to access external resources
    if [ ! -d /data ]; then mkdir /data; fi
    if [ ! -d /scripts ]; then mkdir /scripts; fi

%runscript
    echo "Now inside Singularity container woah..."
    exec /bin/bash
