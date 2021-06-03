################################################################################# 
# Singularity Definition File
# 
# Version:          2.1
# Software:         Molecular electrostatics singularity image
# Software Version: 2019.4.23
# Description:      Docker image for BrownDye, APBS and PDB2PQR
# Website:          https://browndye.ucsd.edu
# Github:           https://github.com/nbcrrolls/electrostatics-singularity
# Tags:             Electrostatics|Brownian Dynamics|Solvation
# Build command:    singularity build electrostatics.simg Singularity
# Pull command:     singularity pull shub://nbcrrolls/electrostatics-singularity
# Run command:      singularity shell nbcrrolls-electrostatics-singularity-master-latest.simg
# Run command:      singularity exec [image name] apbs input.in
# Run command:      singularity run --app apbs [image name] arguments
# Run command:      singularity run --app pdb2pqr [image name] arguments
#
################################################################################# 

Bootstrap: debootstrap
MirrorURL: http://us.archive.ubuntu.com/ubuntu
OSVersion: xenial # 16.04

#Bootstrap: docker
#From: ubuntu:16.04

%labels

    APPLICATION_NAME apbs-pdb2pqr-browndye
    APPLICATION_VERSION 1.5 + 2.1.0 + 2.0
    APPLICATION_URL http://www.poissonboltzmann.org + https://browndye.ucsd.edu

    SYSTEM_NAME comet
    SYSTEM_SINGULARITY_VERSION 2.6.1
    SYSTEM_URL http://www.sdsc.edu/support/user_guides/comet.html

    SINGULARITY_IMAGE_SIZE 1024

    ORIGINAL_AUTHOR_NAME Robert Konecny
    ORIGINAL_AUTHOR_EMAIL rok@ucsd.edu
    ORIGINAL_DEFINITION_FILE https://github.com/nbcrrolls/electrostatics-singularity/blob/master/Singularity

    MODIFYING_AUTHOR_NAME Marty Kandes
    MODIFYING_AUTHOR_EMAIL mkandes@sdsc.edu

    LAST_UPDATED 20190423

%help

    This is a singularity image with molecular electrostatics tools:
    apbs, pdb2pqr and BrownDye. All applications are intalled in /opt
    sub-directories and are in your $PATH.

%runscript
# this will get copied to /.singularity.d/runscript indide the container
# which will run whenever the container is called as an executable

#if [ $# -eq 0 ]
#then
  echo
  echo "========================================================================="
  echo "    This container includes the following apps:"
  echo
  echo "      APBS v1.5       https://www.poissonboltzmann.org"
  echo "      PDB2PQR v2.1.0  https://www.poissonboltzmann.org"
  echo "      BrownDye v2.0   https://browndye.ucsd.edu"
  echo
  echo " Please register your use of APBS and PDB2PQR at http://eepurl.com/by4eQr"
  echo
  echo " To list all available applications do 'singularity apps [image name]'"
  echo "========================================================================="
  echo
#else
  echo "Executing arguments: $*"
  exec "$@"
#fi

%post -c /bin/bash
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8
    set -o errexit
    #
    APBS_VERSION=1.5
    PDB2PQR_VERSION=2.1.0
    BD1_VERSION="1.0-13_Feb_2019"
    BD2_VERSION="2.0-11_Mar_2019"
    #
    #APBS_URL=https://versaweb.dl.sourceforge.net/project/apbs/apbs/apbs-${APBS_VERSION}
    APBS_URL=https://downloads.sourceforge.net/apbs
    APBS_PKG=APBS-${APBS_VERSION}-linux64
    #PDB2PQR_URL=https://versaweb.dl.sourceforge.net/project/pdb2pqr/pdb2pqr/pdb2pqr-${PDB2PQR_VERSION}
    PDB2PQR_URL=https://downloads.sourceforge.net/pdb2pqr
    PDB2PQR_PKG=pdb2pqr-linux-bin64-${PDB2PQR_VERSION}
    BD_URL=https://browndye.ucsd.edu
    BD1_PKG=browndye.tar.gz
    BD2_PKG=browndye2.tar.gz
    OCAML_VERSION=4.06
    OCAML_VERSION_MINOR=0
    OCAML_PKG=ocaml-${OCAML_VERSION}.${OCAML_VERSION_MINOR}
    OCAML_URL=http://caml.inria.fr/pub/distrib/ocaml-${OCAML_VERSION}
    # needed for Ubuntu 18.04 (Bionic)
    #RL_URL=https://mirrors.edge.kernel.org/ubuntu/pool/main/r/readline6
    #RL_PKG=libreadline6_6.3-8ubuntu8_amd64.deb

    DEBIAN_FRONTEND=noninteractive
    apt-get -y install ubuntu-standard
    apt-get -y install software-properties-common
    add-apt-repository universe
    # Upgrade all packages to their latest versions
    apt-get -y update && apt-get -y upgrade
    apt-get -y install build-essential
    apt-get -y install curl
    #apt-get -y install ocaml
    apt-get -y install libexpat-dev
    apt-get -y install libgfortran3
    apt-get -y install libboost-dev
    apt-get -y install liblapack-dev
    # works with Ubuntu 16.04 (Xenial)
    apt-get -y install libreadline6
    # needs 'universe' repo for modules
    apt-get -y install environment-modules

    cd /tmp
    wget -qO - ${OCAML_URL}/${OCAML_PKG}.tar.gz | tar xzf -
    cd ${OCAML_PKG}
    ./configure
    make world.opt
    umask 022
    make install
    rm -rf /tmp/${OCAML_PKG}

    #curl -k ${BD_URL}/${BD1_PKG} | tar xzf - -C /opt
    wget -qO - ${BD_URL}/${BD1_PKG} | tar xzf - -C /opt
    cd /opt/browndye
    #curl -k -sO ${BD_URL}/browndye/doc/fixes.html
    wget -q ${BD_URL}/browndye/doc/fixes.html
    make all

    wget -qO - ${BD_URL}/${BD2_PKG} | tar xzf - -C /opt
    cd /opt/browndye2
    wget -q ${BD_URL}/browndye2/doc/fixes.html
    make all
    mkdir lib && cd lib
    wget -q ${BD_URL}/coffdrop.xml.gz
    wget -q ${BD_URL}/connectivity.xml
    wget -q ${BD_URL}/map.xml
    wget -q ${BD_URL}/charges.xml

    # needed for Ubuntu 18.04 (Bionic)
    #curl -k ${RL_URL}/${RL_PKG} -o /tmp/${RL_PKG}
    #dpkg -i /tmp/${RL_PKG}

    apt-get -y purge gcc
    apt-get -y purge g++
    #apt-get -y purge ocaml
    apt-get -y purge libexpat-dev
    apt-get -y purge libboost-dev
    apt-get -y purge liblapack-dev
    apt-get -y clean && apt-get -y autoremove
    rm -rf /var/lib/apt/lists/*

    # add apbs
    wget -qO- --no-check-certificate ${APBS_URL}/${APBS_PKG}.tar.gz | tar xzf - -C /opt
    ln -s /opt/${APBS_PKG} /opt/apbs

    # add pdb2pqr
    wget -qO- --no-check-certificate ${PDB2PQR_URL}/${PDB2PQR_PKG}.tar.gz | tar xzf - -C /opt
    ln -s /opt/${PDB2PQR_PKG} /opt/pdb2pqr

    # add modules to /usr/share/modules/modulefiles
    ln -s /usr/share/modules /usr/share/Modules
    MODULE_PATH=/usr/share/modules/modulefiles
    echo "#%Module1.0" > ${MODULE_PATH}/browndye1
    echo "conflict browndye2" >> ${MODULE_PATH}/browndye1
    echo "prepend-path PATH /opt/browndye/bin" >> ${MODULE_PATH}/browndye1

    echo "#%Module1.0" > ${MODULE_PATH}/browndye2
    echo "conflict browndye1" >> ${MODULE_PATH}/browndye2
    echo "prepend-path PATH /opt/browndye2/bin" >> ${MODULE_PATH}/browndye2

    # stupid ubuntu/dash
    rm /bin/sh
    ln -s /bin/bash /bin/sh

    # Make filesystem mount points
    mkdir /cvmfs /oasis /projects /scratch

%environment

    # Set system locale
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8

    . /etc/profile.d/modules.sh
    export -f module

    # Set APBS, PDB2PQR, and BrownDye environment variables
    export APBS_VERSION=1.5
    export APBS_PATH=/opt/apbs

    export PDB2PQR_VERSION=2.1.0
    export PDB2PQR_PATH=/opt/pdb2pqr

    export BD1_VERSION="1.0-13_Feb_2019"
    export BD1_PATH=/opt/browndye

    export BD2_VERSION="2.0-11_Mar_2019"
    export BD2_PATH=/opt/browndye2

    export PATH=${APBS_PATH}/bin:${PDB2PQR_PATH}:${PATH}
    export LD_LIBRARY_PATH=${APBS_PATH}/lib

%apphelp apbs

    apbs version 1.5
    For instructions on use see http://www.poissonboltzmann.org/
    Please register your use of APBS and PDB2PQR at http://eepurl.com/by4eQr

    apbs is installed in /opt/apbs
    
%apprun apbs

    /opt/apbs/bin/apbs "$@"

%apphelp pdb2pqr

    pdb2pqr version 2.1.0
    For instructions on use see http://www.poissonboltzmann.org/

    pdb2pqr is installed in /opt/pdb2pqr

%apprun pdb2pqr

    /opt/pdb2pqr/pdb2pqr "$@"

%apphelp nam_simulation

    BrownDye version 1 and 2
    For instructions on use see https://browndye.ucsd.edu
    All BrowDye programs are installed in /opt/browndye{1:2}/bin

%apprun nam_simulation

    /opt/browndye2/bin/nam_simulation "$@"

%apphelp we_simulation

   BrownDye version 1 and 2
   For instructions on use see https://browndye.ucsd.edu
   All BrowDye programs are installed in /opt/browndye{1:2}/bin

%apprun we_simulation

   /opt/browndye2/bin/we_simulation "$@"

#%apphelp pqr2xml
#
#    BrownDye version 2.0
#    For instructions on use see https://browndye.ucsd.edu
#
#%apprun pqr2xml
#
#    /opt/browndye2/bin/pqr2xml "$@"

#%apphelp make_rxn_pairs
#
#   BrownDye version 2.0
#   For instructions on use see https://browndye.ucsd.edu
#
#%apprun make_rxn_pairs
#
#   /opt/browndye2/bin/make_rxn_pairs "$@"

#%apphelp xyz_trajectory
#
#   BrownDye version 2.0
#   For instructions on use see https://browndye.ucsd.edu
#
#%apprun xyz_trajectory
#
#   /opt/browndye2/bin/xyz_trajectory "$@"
