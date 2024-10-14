Bootstrap: debootstrap
OSVersion: xenial
MirrorURL: http://us.archive.ubuntu.com/ubuntu/

%environment
SHELL=/bin/bash
PATH=/opt/photoscan-pro:$PATH
SINGULARITY_SHELL="/bin/bash --norc"

%post
apt-get update
apt-get install -y software-properties-common libglib2.0 libqt5gui5 libglu1-mesa libgomp1 zlib1g wget vim
apt-get update

wget --directory-prefix=/usr/local http://download.agisoft.com/photoscan-pro_1_4_3_amd64.tar.gz
(cd /usr/local && tar zxvf photoscan-pro_1_4_3_amd64.tar.gz)
chmod -R 755 /usr/local/photoscan-pro/
(cd /usr/local/bin && ln -s ../photoscan-pro/photoscan.sh)
rm -f /usr/local/photoscan-pro_1_4_3_amd64.tar.gz

export SHELL PATH SINGULARITY_SHELL 

mkdir /opt/photoscan-pro
mkdir /scratch/
