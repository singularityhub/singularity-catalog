BootStrap: docker
From: python:3.8

%labels
  Maintainer Savio Chow
  Python_version 3.8
  MACS2_version 2.2.7.1

%help
  This image will run MACS2, downloaded from pip and uses python3.8

%apprun python
  exec python "${@}"

%apprun macs2
  exec macs2 "${@}"

%runscript
  exec macs2 "${@}"

%environment
  export PATH=/usr/lib/python3.8/bin:${PATH}
  export SHELL=/bin/bash
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
  export LANGUAGE=en_US.UTF-8
  
%post
  pip install --no-cache-dir MACS2
  
