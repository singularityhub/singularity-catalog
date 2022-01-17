Bootstrap: docker
From: rockylinux:latest



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
 yum install -y java-1.8.0-openjdk-devel git-all perl-Git python39 python39-devel platform-python-pip perl \
rsync network-scripts gnutls gnutls-devel curl curl-devel wget

#now we are grabbing the actual stuff:


mkdir -p /opt 

cd /opt 


wget -O apache-druid-0.22.1-bin.tar.gz https://dlcdn.apache.org/druid/0.22.1/apache-druid-0.22.1-bin.tar.gz

tar zxf apache-druid-0.22.1-bin.tar.gz

rm -rf apache-druid-0.22.1-bin.tar.gz


#just create a symbolic link here 
ln -s /opt/apache-druid-0.22.1 /opt/druid

%environment
  export IMAGE_NAME="Apache_Druid_Server"
  export PATH=/usr/local/bin:$PATH
  export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

%runscript
