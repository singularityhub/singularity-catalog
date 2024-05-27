# Copyright (c) 2017, Yaroslav O. Halchenko. All rights reserved. MIT license
#
# The purpose of the Singularity environment is to provide a relatively full
# suite of tools provided primarily by Debian/NeuroDebian for runnin various
# neuroimaging analyses.
#
# Notes:
#  - Due to  https://github.com/singularityware/singularity/issues/471
#    bootstrapping leads to non-usable/non-removable-without-reboot
#    image due to some rogue run away processes.
#    This line could help to kill them but should be used with caution
#    since could kill other unrelated processes
#
#      grep -l loop /proc/*/mountinfo | sed -e 's,/proc/\(.*\)/.*,\1,g' | while read pid; do sudo kill $pid; done
#
# Set size to be 12000 on singularity-hub
#
# Changelog
# ---------
# 2.2
#  - fresh annex with patched git to avoid "Out of memory, getdelim failed" bug
#  - added some tools useful for debugging (gdb)
#  - additional mountpoints (/scratch)
#  - (note) pip is not installed on purpose, use the one within virtualenv(s)
# 2.x
#  - switch to stretch
#  - TODO make reproducible
#  - bids-validator from 0.22
#  - Added ants, convert3d
#
# TODOs
# -----
# - package bids-validator

BootStrap: debootstrap
OSVersion: stretch
MirrorURL: http://http.debian.net/debian/
#MirrorURL: http://smaug.datalad.org:3142/debian/

# so if image is executed we just enter the environment
%runscript
    v=`python -c "import json; f='/.singularity.d/labels.json'; print(json.load(open(f)).get('SINGULARITY_IMAGE_VERSION', '0.0.unknown'))"`; \
      echo "Welcome to the NeuroDebian v $v (Debian stretch) environment"
    echo "Please source /etc/fsl/fsl.sh if you need FSL, /etc/afni/afni.sh if you need AFNI"
    /bin/bash

%setup
    set -eu
    echo "Setting up the environment"
    apt-get update
    apt-get -y install python 

    v=`git describe --tags --match sing-\* | sed -e 's,^sing-,,g'`; \
      python -c "import json, os; f='$SINGULARITY_ROOTFS/.singularity.d/labels.json'; j=json.load(open(f)) if os.path.exists(f) else {}; j['SINGULARITY_IMAGE_VERSION']='$v' or '0.0.unknown'; json.dump(j, open(f,'w'),indent=2)"

%post
    set -eu
    echo "Configuring the environment"
    apt-get update
    apt-get -y install python 

