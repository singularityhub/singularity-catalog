Bootstrap: yum
OSVersion: 7
MirrorURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/os/$basearch/ 
Include: yum

%environment
FREESURFER_HOME=/opt/freesurfer
export FREESURFER_HOME
source /opt/freesurfer/SetUpFreeSurfer.sh
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/freesurfer/lib/vtk/lib/vtk-5.6
export LD_LIBRARY_PATH

%post
yum update -y
yum install -y wget tar bzip2 gzip lz4 lzma mesa-libGL mesa-libGLU libpng qt tk libXft tcsh libgomp libSM libXt libXScrnSaver libICE libjpeg-turbo qt-x11 libpng12 mesa-dri-drivers
curl ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz | tar -xz -C /opt
chmod -R o+rX /opt/freesurfer


%runscript
exec "$@"
