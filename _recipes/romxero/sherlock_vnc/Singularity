Bootstrap: docker
From: centos:centos7


%labels
Author "Randall Cab White - rcwhite@stanford.edu"


#########
#%setup
#########

#Downlaod packages
%post
 yum -y update 
 yum -y upgrade
 yum -y install epel-release
 yum -y groupinstall "X Window system"
 yum -y groupinstall "xfce"
 yum -y install lua-posix tigervnc-server lua lua-bitop lua-devel lua-filesystem firefox geany xemacs vim-X11 tigervnc gnutls gnutls-devel
 
 
 


%environment
  export IMAGE_NAME="Rstudio_server"
  export PATH=/usr/local/bin:$PATH
  export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

%runscript

