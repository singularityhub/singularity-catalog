BootStrap: yum
OSVersion: 7
MirrorURL: https://www.mirrorservice.org/sites/mirror.centos.org/%{OSVERSION}/os/$basearch/
UpdateURL: https://www.mirrorservice.org/sites/mirror.centos.org/%{OSVERSION}/updates/$basearch/
Include: yum


%post
    yum -y groupinstall "Development Tools"
    yum -y install wget

#variables section

VER="2.7.15"
FTPSRV="https://www.python.org/ftp/python/${VER}"
FTP_FILE="Python-${VER}.tgz"
PYTHON_SHORT_VERSION=${VER%.*}

#get , config and make

/usr/bin/wget ${FTPSRV}/${FTP_FILE}
tar xzf ${FTP_FILE}
cd Python-${VER}
./configure
make
make install

%runscript
    python $@
