BootStrap: docker
From: sbidprod.azurecr.io/quinault

%post
apt update && \
DEBIAN_FRONTEND=noninteractive apt -y upgrade && \
DEBIAN_FRONTEND=noninteractive apt-get -y auto-remove
date +"%Y-%m-%d-%H%M" > /last_update
