Bootstrap: debootstrap
OSVersion: trusty
MirrorURL: http://uk.archive.ubuntu.com/ubuntu

%labels
   Maintainer Adam Huffman
   Version 0.1

%files
. /tmp/gemma/

%post
apt-get -yqq install software-properties-common
add-apt-repository "deb http://archive.ubuntu.com/ubuntu trusty main universe restricted multiverse"

apt-get -yqq update
apt-get -yqq install libgsl0-dev libatlas-base-dev make g++

cd /tmp/gemma && make
install /tmp/gemma/bin/gemma /usr/bin
