Bootstrap: docker
From: ubuntu:21.04

%setup

%files

%environment
  export LC_ALL=C

%post
  export DEBIAN_FRONTEND=noninteractive
  export LC_ALL=C

  mkdir -p /tmp/apt
  echo 'Dir::Cache /tmp/apt;'  > /etc/apt/apt.conf.d/singularity-cache.conf 
 
  apt-get update && apt-get -y dist-upgrade && apt-get install -y git wget gawk emacs


%runscript
  /usr/bin/emacs "$@"
