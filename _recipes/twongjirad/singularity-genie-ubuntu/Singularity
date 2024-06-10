Bootstrap: docker
From: twongjirad/docker-genie-deps-root5-ubuntu14.04

%post
  cd /usr/local/share/
  svn co http://genie.hepforge.org/svn/generator/branches/R-2_12_6 GENIE-2.12.6
  cd /usr/local/share/GENIE-2.12.6
  export ROOTSYS=/usr/local
  export GENIE=/usr/local/share/GENIE-2.12.6
  export LD_LIBRARY_PATH=/usr/local/lib
  ./configure --prefix=/usr/local --with-lhapdf-lib=/usr/local/lib --with-lhapdf-inc=/usr/local/include \
     --with-pythia6-lib=/usr/local/share/pythia/v6_428/lib/libPythia6.so --with-libxml2-lib=/usr/lib/x86_64-linux-gnu \
     --with-libxml2-lib=/usr/include --with-log4cpp-lib=/usr/local/lib --with-log4ccp-inc=/usr/local/include \
     --enable-rwght --enable-test --enable-atmo --enable-fnal --enable-geom-drivers --enable-flux-drivers
  make
  make install

%environment

GENIE=/usr/local/share/GENIE-2.12.6
ROOTSYS=/usr/local
LD_LIBRARY_PATH=:/usr/local/share/pythia/v6_428/lib:/usr/local/lib:/usr/local/lib64
LHAPATH=/usr/local/share/GENIE-2.12.6/data/evgen/pdfs


  