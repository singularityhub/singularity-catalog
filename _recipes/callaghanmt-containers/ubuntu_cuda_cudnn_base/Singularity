Bootstrap: docker
From: nvidia/cuda:9.1-cudnn7-devel-ubuntu16.04

%post
#Set timezone for tzdata
export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
echo "tzdata tzdata/Areas select Europe" >> preseed.txt
echo "tzdata tzdata/Zones/Europe select London" >> preseed.txt
apt-get -y update && apt-get install -y apt-utils
apt-get install -y build-essential

#Set preseed options for tzdata
debconf-set-selections preseed.txt
apt-get install -y tzdata

#Install and update some useful utilities
apt-get install -y wget
apt-get install -y ed
apt-get install -y nano
apt-get install -y git-all
apt-get install -y software-properties-common #required for apt-add-repository
apt-get -y update
apt-get -y install libcurl4-openssl-dev libxml2-dev


#Create stub directory for /nobackup
mkdir -p /nobackup

%environment
