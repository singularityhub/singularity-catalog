Bootstrap: docker
From: ubuntu:18.04

# Singularity file used to create  yinglilu/MRtrix3Tissue.img, contains:
# MRtrix3Tissue

#########
%post
#########

# Install dependencies
apt-get update && apt-get install -y \
git \
g++ \
python \
libeigen3-dev \
zlib1g-dev \
libqt4-opengl-dev \
libgl1-mesa-dev \
libfftw3-dev \
libtiff5-dev \
libpng-dev

# Install MRtrix3Tissue
git clone https://github.com/3Tissue/MRtrix3Tissue.git MRtrix3Tissue
cd MRtrix3Tissue
# use release v5.2.8
git checkout 3Tissue_v5.2.8
./configure
./build

#########
%environment
#########

export PATH=/MRtrix3Tissue/bin:$PATH








