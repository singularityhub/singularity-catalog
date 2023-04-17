################################################################################
# Basic bootstrap definition to build Ubuntu container from Docker container
################################################################################

Bootstrap:docker
From:ubuntu:latest

%labels
Maintainer Matthew Andres Moreno
Version 0.1.0

################################################################################
# Copy any necessary files into the container
################################################################################
%files
. /opt/mwe-singularity-checkpoint

%post
################################################################################
# Install additional packages
################################################################################
apt-get update

apt-get install -y git
apt-get install -y build-essential
apt-get install -y make
apt-get install -y figlet
git clone https://github.com/mmore500/dmtcp
cd dmtcp
git checkout b8be8be2874258d2f45324a42d609c0c63da0079 .
./configure && make && make install
cd ..

chmod 777 -R /opt

################################################################################
# Run the user's login shell, or a user specified command
################################################################################
%runscript
/opt/mwe-singularity-checkpoint/demonstrate.sh
