BootStrap: yum
OSVersion: 7
MirrorURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/os/$basearch/
Include: yum

%labels
  AUTHOR nicolas.soirat@etu.umontpellier.fr

%post
  echo "Updating CentOS and installing mandatory packages ..."
  yum -y update 
  yum group install -y "development tools"
  yum -y install  wget git zlib-devel which 

