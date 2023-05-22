Bootstrap: docker
From: ubuntu:18.10

%post
#Set timezone for tzdata
export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
echo "tzdata tzdata/Areas select Europe" >> preseed.txt
echo "tzdata tzdata/Zones/Europe select London" >> preseed.txt
apt-get -y update && apt-get install -y apt-utils
apt-get install -y build-essential

#Set preseed options
debconf-set-selections preseed.txt
apt-get install -y tzdata

apt-get install -y wget
apt-get install -y ed
apt-get install -y nano
apt-get install -y git-all
apt-get install -y software-properties-common #required for apt-add-repository
apt-get -y update
apt-get -y install libcurl4-openssl-dev libxml2-dev

#Set correct locale for Python
apt-get -y update && apt-get install -y locales
locale-gen en_GB.UTF-8

#Install Anaconda Python
wget https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh -O anaconda.sh
bash anaconda.sh -b -p /anaconda
rm anaconda.sh

#install xdarray
/anaconda/bin/conda install xarray dask netCDF4 bottleneck

#Create stub directory for /nobackup
mkdir -p /nobackup

%environment
#set environment variables
PATH="/anaconda/bin:$PATH"

#Fix for running jupyter with uid !=1000
XDG_RUNTIME_DIR=""
