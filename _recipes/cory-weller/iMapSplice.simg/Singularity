Bootstrap: yum
OSVersion: 7
MirrorURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/os/$basearch/
Include: yum sudo

%post

sudo yum -y update && \
sudo yum -y install make gcc gcc-c++ git && \
git clone https://github.com/xa6xa6/iMapSplice.git && \
cd iMapSplice/code && \
make all
