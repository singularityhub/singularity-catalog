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

#Set correct locale for Python
apt-get -y update && apt-get install -y locales
locale-gen en_GB.UTF-8

#Install Anaconda Python (Python 3.6)
wget https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh -O anaconda.sh
bash anaconda.sh -b -p /anaconda
rm anaconda.sh

#Set some Conda repositories
#/anaconda/bin/conda config --add channels conda-forge
#/anaconda/bin/conda config --add channels defaults
#/anaconda/bin/conda config --add channels r
/anaconda/bin/conda config --add channels bioconda

#install Python dependencies for DecryptICS
/anaconda/bin/conda install -y -c bioconda openslide
/anaconda/bin/conda install -y opencv keras keras-gpu matplotlib scikit-learn numba joblib pandas numpy scipy libiconv ipython
/anaconda/bin pip install -y -U xlrd
/anaconda/bin pip install -y -U openslide-python

#Create stub directory for /nobackup
mkdir -p /nobackup

#Fix for running jupyter with uid !=1000
XDG_RUNTIME_DIR=""

# install correct version of tensorflow:
/anaconda/bin pip install -y -U tensorflow-gpu==1.6.0

#Get DeCryptICS
git clone https://github.com/MorrisseyLab/DeCryptICS.git
mkdir ./DeCryptICS/DNN/weights
wget "https://www.dropbox.com/s/4vtbzbwwb5n0eck/cryptfuficlone_weights.hdf5?dl=0" -O ./DeCryptICS/DNN/weights/cryptfuficlone_weights.hdf5

%environment
#set environment variables
PATH="/anaconda/bin:$PATH"



