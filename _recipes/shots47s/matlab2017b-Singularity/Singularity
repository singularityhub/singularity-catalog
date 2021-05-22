Bootstrap: yum
OSVersion: 7
MirrorURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/os/$basearch/
Include: yum

%labels
Maintainer ShawnTBrown
Version v0.9

%post
   echo "Installing Matlab Runtime 2017b"
   yum update -y
   yum install wget unzip libXext libXt-devel libXmu mesa-libGL -y
   mkdir mcr-install
   wget -P mcr-install -nv http://ssd.mathworks.com/supportfiles/downloads/R2017b/deployment_files/R2017b/installers/glnxa64/MCR_R2017b_glnxa64_installer.zip
   cd mcr-install
   unzip MCR_R2017b_glnxa64_installer.zip
   ./install -mode silent -agreeToLicense yes
   cd ..
   rm -rf mcr-install
   yum clean all

%environment
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/MATLAB/MATLAB_Runtime/v93/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v93/bin/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v93/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v93/sys/java/jre/glnxa64/jre/lib/amd64/native_threads:/usr/local/MATLAB/MATLAB_Runtime/v93/sys/java/jre/glnxa64/jre/lib/amd64/server:/usr/local/MATLAB/MATLAB_Runtime/v93/sys/java/jre/glnxa64/jre/lib/amd64
XAPPLRESDIR=/usr/local/MATLAB/MATLAB_Runtime/v93/X11/app-defaults
MCR_CACHE_VERBOSE=true
MCR_CACHE_ROOT=/tmp
