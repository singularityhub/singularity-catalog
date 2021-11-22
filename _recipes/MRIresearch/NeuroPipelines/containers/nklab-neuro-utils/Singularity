Bootstrap: docker
From: ubuntu:xenial

%help
exec /opt/bin/startup.sh "-h"

%setup
cp ./src/startup.sh $SINGULARITY_ROOTFS
cp ./src/changePython2.sh $SINGULARITY_ROOTFS
cp ./src/changePython3.sh $SINGULARITY_ROOTFS
cp ./src/readme $SINGULARITY_ROOTFS
cp ./src/version $SINGULARITY_ROOTFS
cp ./src/nklab-bids-convert.py $SINGULARITY_ROOTFS
cp -R ./src/bidskit-adapted $SINGULARITY_ROOTFS

%environment
export LD_LIBRARY_PATH=/.singularity.d/libs:/usr/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
export PATH=/opt/bin:/opt/bin/dcm2niix/bin:/opt/bin/bidskit:$PATH

%files

%runscript
cd /opt/data
exec /opt/bin/startup.sh "$@"

%test

%post
mkdir -p /extra /xdisk /rsgrps /opt/data /opt/bin /opt/work /opt/input /opt/output

apt-get update && apt-get install -y \
	nano \
	wget \
	curl \
        dc \
	lsb-core \
	python-pip \
        libx11-6 \
        libgl1 \
        libgtk-3-0 \
        libgtk-3-dev \
        libsm6 \
        libxext6 \
        libxt6 \
        mesa-common-dev \
        freeglut3-dev \
        zlib1g-dev \
        libpng-dev \
        expat \
        unzip \
        libeigen3-dev \
        zlib1g-dev \
        libqt4-opengl-dev \
        libgl1-mesa-dev \
        libfftw3-dev \
        libtiff5-dev \
        graphviz \
        libgraphviz-dev \
        software-properties-common
add-apt-repository universe
apt-get update && apt-get install -y \
        tcsh \
        xfonts-base \
        python-qt4 \
        gsl-bin \
        gnome-tweak-tool \
        libjpeg62 \
        xvfb \
        xterm \
        vim \
        libglu1-mesa-dev \
        libglw1-mesa   \
        libxm4 \
        netpbm
apt-get update && apt-get install -y \
        hdf5-tools \
        openmpi-bin \
        openmpi-doc \
        libopenmpi-dev \
        gfortran \
        python-matplotlib \
        git \
        x11-xserver-utils \
        firefox \
        midori \
        python3-pip \
        
pip install numpy
pip install scipy
pip install nibabel
pip install dicom
pip install pydicom
pip install sklearn

pip3 install numpy
pip3 install scipy
pip3 install nibabel
pip3 install dicom
pip3 install pydicom
pip3 install sklearn

cd /tmp
echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8

cd /tmp
wget https://cmake.org/files/v3.12/cmake-3.12.0-rc3.tar.gz
tar xz -f cmake-3.12.0-rc3.tar.gz
rm cmake-3.12.0-rc3.tar.gz
cd cmake-3.12.0-rc3
./configure
make
make install
./bootstrap --prefix=/usr
make
make install

cd /opt/bin
git clone https://github.com/rordenlab/dcm2niix.git
cd dcm2niix
mkdir build && cd build
cmake ..
make install

mv /changePython2.sh /opt/bin/changePython2.sh
mv /changePython3.sh /opt/bin/changePython3.sh
mv /startup.sh /opt/bin
mv /readme /opt/bin
mv /version /opt/bin
mv /bidskit-adapted /opt/bin/bidskit
mv /nklab-bids-convert.py /opt/bin/

chmod -R 777 /opt


