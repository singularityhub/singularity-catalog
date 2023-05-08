Bootstrap: yum
OSVersion: 7
MirrorURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/os/$basearch/
Include: yum

%help
  This is a test image we're building just to make sure we know how

%setup
  touch ${SINGULARITY_ROOTFS}/i_made_a_file.txt
  
%post
  yum -y install wget
  yum -y install epel-release
  yum -y update
  yum -y install R
  yum -y install xkeyboard-config
  wget https://download1.rstudio.org/rstudio-1.1.456-x86_64.rpm
  yum -y localinstall rstudio-1.1.456-x86_64.rpm
  
%runscript
  
  

