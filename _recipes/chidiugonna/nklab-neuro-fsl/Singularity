Bootstrap: docker
From: ubuntu:xenial

%help
exec /opt/bin/startup.sh "-h"

%setup
cp ./src/resting_pipeline.py $SINGULARITY_ROOTFS
cp ./src/fsl_sub $SINGULARITY_ROOTFS
cp ./src/statusfeat.py $SINGULARITY_ROOTFS
cp ./src/runfeat-1.py $SINGULARITY_ROOTFS
cp ./src/make_fsl_stc.py $SINGULARITY_ROOTFS
cp ./src/startup.sh $SINGULARITY_ROOTFS
cp ./src/readme $SINGULARITY_ROOTFS
cp ./src/version $SINGULARITY_ROOTFS

%environment
LD_LIBRARY_PATH=/usr/local/cuda/lib64:/.singularity.d/libs:/usr/lib:/opt/freesurfer/mni/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
export FSLDIR=/opt/fsl
export PATH=$FSLDIR/bin:$PATH
export PATH=$FSLDIR/bin/FSLeyes:$PATH
export PATH=$FSLDIR/bin/eddypatch:$PATH
export BXHVER=bxh_xcede_tools-1.11.1-lsb30.x86_64
export BXHBIN=/opt/$BXHVER
export RSFMRI=/opt/rsfmri_python
export PATH=$BXHBIN/bin:$PATH
export PATH=$BXHBIN/lib:$PATH
export PATH=$RSFMRI/bin:$PATH
export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=4 
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/.singularity.d/libs:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH
export PATH=/usr/local/cuda/bin:$PATH
%files


%runscript
cd /opt/data
exec /opt/bin/startup.sh "$@"

%test

%post
mkdir -p /uaopt /extra /xdisk /opt/data /opt/bin /opt/input /rsgrps /opt/work /opt/output
export BXHVER=bxh_xcede_tools-1.11.1-lsb30.x86_64
export BXHLOC=7384
export BXHBIN=/opt/$BXHVER
export RSFMRI=/opt/rsfmri_python
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
        gfortran 

pip install numpy
pip install scipy
pip install nibabel
pip install networkx==1.11
pip install pyBIDS

cd /tmp
echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8

cd /tmp
wget "https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run"
mkdir -p nvidia_installers
chmod +x cuda_8.0.61_375.26_linux-run
./cuda_8.0.61_375.26_linux-run -extract=`pwd`/nvidia_installers
rm cuda_8.0.61_375.26_linux-run
cd nvidia_installers
rm cuda-samples*
rm NVIDIA-Linux*
./cuda-linux64-rel-8.0.61-21551265.run -noprompt
cd ..
rm -R nvidia_installers
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/.singularity.d/libs:$LD_LIBRARY_PATH
export PATH=/usr/local/cuda/bin:$PATH

cd /tmp
wget https://cmake.org/files/v3.10/cmake-3.10.0-rc1.tar.gz
tar xz -f cmake-3.10.0-rc1.tar.gz
rm cmake-3.10.0-rc1.tar.gz
cd cmake-3.10.0-rc1
./configure
make
make install
./bootstrap --prefix=/usr
make
make install

cd /tmp
wget http://www.vtk.org/files/release/7.1/VTK-7.1.1.tar.gz
tar xz -f VTK-7.1.1.tar.gz
rm VTK-7.1.1.tar.gz
cd VTK-7.1.1
cmake .
make
make install

cd /opt
export FSLDIR=/opt/fsl
export PATH=${FSLDIR}/bin:${PATH}
wget https://www.dropbox.com/s/chetucmygqyz992/fsl-5.0.11-sources.tar.gz
tar xz -f fsl-5.0.11-sources.tar.gz
rm fsl-5.0.11-sources.tar.gz
chmod -R 777 fsl
sed -i 's/#FSLCONFDIR/FSLCONFDIR/g' ${FSLDIR}/etc/fslconf/fsl.sh
sed -i 's/#FSLMACHTYPE/FSLMACHTYPE/g' ${FSLDIR}/etc/fslconf/fsl.sh
sed -i 's/#export FSLCONFDIR/export FSLCONFDIR /g' ${FSLDIR}/etc/fslconf/fsl.sh
. ${FSLDIR}/etc/fslconf/fsl.sh
cp -r ${FSLDIR}/config/linux_64-gcc4.8 ${FSLDIR}/config/${FSLMACHTYPE}
sed -i "s#scl enable devtoolset-2 -- c++#c++#g" $FSLDIR/config/$FSLMACHTYPE/systemvars.mk
sed -i "s#CUDA_INSTALLATION = /opt/cuda-7.5#CUDA_INSTALLATION = /usr/local/cuda-8.0#g" $FSLDIR/config/$FSLMACHTYPE/systemvars.mk
sed -i "s#VTKDIR_INC = /home/fs0/cowboy/var/caper_linux_64-gcc4.4/VTK7/include/vtk-7.0#VTKDIR_INC = /usr/local/include/vtk-7.1/#g" $FSLDIR/config/$FSLMACHTYPE/externallibs.mk
sed -i "s#VTKDIR_LIB = /home/fs0/cowboy/var/caper_linux_64-gcc4.4/VTK7/lib#VTKDIR_LIB = /usr/local/lib/#g" $FSLDIR/config/$FSLMACHTYPE/externallibs.mk
sed -i "s#VTKSUFFIX = -7.0#VTKSUFFIX = -7.1#g" $FSLDIR/config/$FSLMACHTYPE/externallibs.mk
sed -i "s#{LIBRT}#{LIBRT} -ldl#g" $FSLDIR/src/mist-clean/Makefile
sed -i "s#lpng -lz#lpng -lz -lm#g" $FSLDIR/src/miscvis/Makefile
cd ${FSLDIR}
./build
sed -i "s#dropprivileges=1#dropprivileges=0#g" ${FSLDIR}/etc/fslconf/fslpython_install.sh
${FSLDIR}/etc/fslconf/fslpython_install.sh
mkdir -p $FSLDIR/bin/eddypatch
cd  ${FSLDIR}/bin/eddypatch
wget https://fsl.fmrib.ox.ac.uk/fsldownloads/patches/eddy-patch-fsl-5.0.11/centos6/eddy_cuda8.0
chmod +x eddy_cuda8.0
wget https://fsl.fmrib.ox.ac.uk/fsldownloads/patches/eddy-patch-fsl-5.0.11/centos6/eddy_openmp
chmod +x eddy_openmp
cd  ${FSLDIR}/bin
wget https://fsl.fmrib.ox.ac.uk/fsldownloads/fsleyes/FSLeyes-latest-ubuntu1604.zip
unzip FSLeyes-latest-ubuntu1604.zip
rm FSLeyes-latest-ubuntu1604.zip

cd /tmp
wget http://users.fmrib.ox.ac.uk/~moisesf/Probtrackx_GPU/CUDA_8.0/probtrackx2_gpu.zip
unzip probtrackx2_gpu.zip
rm -f probtrackx2_gpu.zip
mv probtrackx2_gpu $FSLDIR/bin

mkdir /tmp/bedpost
cd /tmp/bedpost
wget http://users.fmrib.ox.ac.uk/~moisesf/Bedpostx_GPU/CUDA_8.0/bedpostx_gpu.zip
unzip bedpostx_gpu.zip
rm -f bedpostx_gpu.zip
cp /tmp/bedpost/bin/* $FSLDIR/bin
cp /tmp/bedpost/lib/* $FSLDIR/lib
rm -r /tmp/bedpost
sed -i 's\#!/bin/sh\#!/bin/bash\g' $FSLDIR/bin/bedpostx_postproc_gpu.sh

cd /tmp
wget "http://www.nitrc.org/frs/download.php/$BXHLOC/$BXHVER.tgz"
wget "https://wiki.biac.duke.edu/_media/biac:analysis:rsfmri_python.tgz"
tar -xzf $BXHVER.tgz -C /opt
mv biac:analysis:rsfmri_python.tgz rsfmri_python.tgz
tar -xzf rsfmri_python.tgz  -C /opt
rm rsfmri_python.tgz
rm $BXHVER.tgz

chmod -R 777 /opt 

mv /resting_pipeline.py /opt/rsfmri_python/bin
mv /fsl_sub $FSLDIR/bin
mv /statusfeat.py /opt/bin
mv /runfeat-1.py /opt/bin
mv /make_fsl_stc.py /opt/bin
mv /startup.sh /opt/bin
mv /readme /opt/bin
mv /version /opt/bin

echo ". $FSLDIR/etc/fslconf/fsl.sh" >> $SINGULARITY_ENVIRONMENT

