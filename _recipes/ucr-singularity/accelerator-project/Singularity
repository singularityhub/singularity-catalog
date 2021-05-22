Bootstrap: docker
From: ubuntu:18.04

%post

# Make sure packages are up to date
apt-get update

# These are NOT interactive upgrades or installs - no questions
export DEBIAN_FRONTEND=noninteractive 
apt-get -y upgrade

# Utility and support packages
apt-get install -y screen terminator tmux vim wget 
apt-get install -y aptitude build-essential cmake g++ gfortran git \
    pkg-config python-pip python-dev software-properties-common

apt-get -y install curl libcurl4-gnutls-dev
apt-get -y install libcurl3-gnutls-dev
apt-get -y install liboauth0 liboauth-dev
apt-get -y install libjsoncpp-dev

# A test
apt-get -y install vim-gnome

# Another test
