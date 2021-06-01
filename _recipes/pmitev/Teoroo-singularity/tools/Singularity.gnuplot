Bootstrap:  docker
From: ubuntu:16.04

%runscript
  /usr/bin/gnuplot "$@"
%setup
%files
%environment
%labels
%post
  export DEBIAN_FRONTEND=noninteractive

  apt-get update && apt-get -y dist-upgrade && apt-get install -y gnuplot gv gawk python3-numpy python3-scipy
  apt-get clean
