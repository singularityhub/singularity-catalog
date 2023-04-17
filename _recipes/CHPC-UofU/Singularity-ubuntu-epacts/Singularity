# Defines a Singularity container with EPACTS
#



BootStrap: docker
From: ubuntu:16.04
#Include: rpm2cpio


%runscript


%setup
    # Runs from outside the container during Bootstrap



%post
    # Runs within the container during Bootstrap


    # Install the necessary packages (from repo)
    apt-get update && apt-get install -y --no-install-recommends \
        apt-utils \
        build-essential \
        curl \
        git \
        libopenblas-dev \
        libcurl4-openssl-dev \
        libfreetype6-dev \
        libpng-dev \
        libzmq3-dev \
        python-pip \
        pkg-config \
        python-dev \
        python-setuptools \
        rsync \
        software-properties-common \
        unzip \
        vim \
        zip \
        zlib1g-dev
    apt-get clean

    # Set up some required environment defaults
    #MC issue with locale (LC_ALL, LANGUAGE), to get it right:
    apt-get install -y language-pack-en
    locale-gen "en_US.UTF-8"
    dpkg-reconfigure locales
    export LANGUAGE="en_US.UTF-8"
    echo 'LANGUAGE="en_US.UTF-8"' >> /etc/default/locale
    echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale

    # Update to the latest pip (newer than repo)
    pip install --no-cache-dir --upgrade pip
    
    # Install other commonly-needed packages
    pip install --no-cache-dir --upgrade \
        future \
        matplotlib \
        scipy 

    #for OpenBLAS accelerated Python3 NumPy, install through pip3
    apt-get install -y python3-pip
    pip3 install --no-cache-dir --upgrade pip
    pip3 install --no-cache-dir --upgrade future matplotlib scipy

    # need to create mount point for home dir
    mkdir /uufs
    mkdir /scratch

    # git, wget
#    apt-get install -y git wget

#    apt-get install -y paraview  paraview-dev  paraview-python

    # LMod
    apt-get install -y liblua5.1-0 liblua5.1-0-dev lua-filesystem-dev lua-filesystem lua-posix-dev lua-posix lua5.1 tcl tcl-dev lua-term lua-term-dev lua-json

    echo "
if [ -f /uufs/chpc.utah.edu/sys/etc/profile.d/module.sh ]
then
   . /uufs/chpc.utah.edu/sys/etc/profile.d/module.sh
fi
   " > /etc/profile.d/91-chpc.sh

    echo "
. /etc/profile.d/91-chpc.sh
" >> /etc/bash.bashrc

#additional needs specific to EPACTS
 apt-get install -y ghostscript
 apt-get install -y gnuplot 
 apt-get install -y apt-transport-https
 apt-get install -y wget
# install the latest version of r
 add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial/'
 gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E084DAB9
 gpg -a --export E084DAB9 | apt-key add -
 apt-get update
 apt-get install -y r-base r-base-dev
#instaling rscript
 apt-get install -y gdebi-core
 wget https://download2.rstudio.org/rstudio-server-1.0.153-amd64.deb
 gdebi -n rstudio-server-1.0.153-amd64.deb
 apt-get install -y groff
    
#EPACTS
 git clone https://github.com/statgen/EPACTS.git
 cd EPACTS
 sed -i 's/1.14/1.15/g' configure
 sed -i 's/--foreign/--foreign --add-missing --force-missing/g' Makefile
 sed -i 's/--foreign/--foreign --add-missing --force-missing/g' Makefile.in
 ./configure 
 make
 make install

 # download reference files
 # https://genome.sph.umich.edu/wiki/EPACTS#Installation_Details suggests to use their download perl script, but, it fails to connect, so wget files directly
 cd /usr/local/share/EPACTS
 wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/human_g1k_v37.fasta.gz
 wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/human_g1k_v37.fasta.fai
 gunzip human_g1k_v37.fasta.gz || true
 
%test
 # Sanity check that the container is operating
 cd /root
 test_run_epacts.sh
 rm -rf out   
