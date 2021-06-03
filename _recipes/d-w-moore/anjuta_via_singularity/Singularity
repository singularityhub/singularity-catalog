Bootstrap: docker
From: ubuntu:20.04

%post
  apt update 
  apt install -y libglib2.0-dev-bin
  apt install -y anjuta libglib2.0-dev libtool-bin dbus-x11 libxpm-dev libxpm4
  apt install -y libglib2.0-dev-bin
  apt install -y libgtk2.0-0 libglade2-dev
  env "DEBIAN_FRONTEND=noninteractive" apt install -y libboost-all-dev
  apt install -y vim nano

%runscript
  anjuta "$@"

