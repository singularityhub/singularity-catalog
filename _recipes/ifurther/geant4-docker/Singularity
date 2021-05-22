Bootstrap: library
From: library/default/centos:7.7

%labels
MAINTAINER Further Lin
Version v10.6.3

%environment
export G4WKDIR=/app

%runscript
echo "This gets run when you run the image!" 

%post
export build_G4Version="10.06.p03"
export build_shortG4version="10.6.3"	
export G4Version=$build_G4Version
export shortG4version=$build_shortG4version
export G4WKDIR=/app
export G4SRC=/app/src

if [ ! -d ${G4WKDIR} ];then mkdir ${G4WKDIR};fi
if [ ! -d ${G4SRC} ];then mkdir ${G4SRC};fi
echo "This section happens once after bootstrap to build the image."  
yum install -y epel-release wget
yum install -y xerces-c-devel qt4 qt4-devel \
               freeglut-devel motif-devel tk-devel \
			   cmake3 libXpm-devel libXmu-devel libXi-devel \
			   libXft-devel libXext-devel environment-modules \
			   expat openmpi-devel openmpi gcc gcc-c++ make

mkdir -p ${G4WKDIR}/geant4.${shortG4version}-install/share/data/Geant4-${shortG4version}
if [ ! -e geant4.${G4Version} ] ; then wget https://geant4-data.web.cern.ch/geant4-data/releases/geant4.${G4Version}.tar.gz -P${G4SRC}; \
tar zxvf ${G4SRC}/geant4.${G4Version}.tar.gz -C ${G4WKDIR}; fi
if [ -e geant4.${shortG4version}-install ] ; then mkdir ${G4WKDIR}/geant4.${shortG4version}-build; else mkdir ${G4DIR}/geant4.${shortG4version}-{build,install}; fi			   
if [ -e geant4.${shortG4version}-install ] ; then mkdir ${G4WKDIR}/geant4.${shortG4version}-build; else mkdir ${G4DIR}/geant4.${shortG4version}-{build,install}; fi

cd ${G4WKDIR}/geant4.${shortG4version}-build && \
cmake3 -DCMAKE_INSTALL_PREFIX=${G4DIR}/geant4.${shortG4version}-install \
-DGEANT4_USE_OPENGL_X11=ON -DGEANT4_INSTALL_DATA=ON \
-DGEANT4_USE_QT=ON -DGEANT4_USESYSTEM_ZLIB=ON -DGEANT4_USESYSTEM_EXPAT=ON ${G4WKDIR}/geant4.${G4Version} &&\
make -j`grep -c ^processor /proc/cpuinfo` &&\
make install 

rm -rf ${G4WKDIR}/geant4.${shortG4version}-build
#mv geant4.${G4Version}.tar.gz /src

echo 'source $G4DIR/bin/geant4.sh' >>$SINGULARITY_ENVIRONMENT
#source $G4DIR/share/Geant4-$shortG4version/geant4make/geant4make.sh

%test
ls $G4WKDIR/geant4.${shortG4version}-install
source $G4DIR/bin/geant4.sh

#==========
# PTSIM
#==========
%appinstall PTSIM
PTSIM_VERSION 105-001-002-20190918
source $G4DIR/bin/geant4.sh
if [ -e /src/PTSproject-${PTSIM_VERSION}.tar.gz ];then wget http://wiki.kek.jp/download/attachments/5343876/PTSproject-${PTSIM_VERSION}.tar.gz -P/src;fi
if [ -e $G4DIR/ptsim ]; then mkdir -p $G4DIR/ptsim/${PTSIM_VERSION}/{build/PTStoolkit,build/PTSapps/DynamicPort} $G4DIR/ptsim/${PTSIM_VERSION}/{PTStoolkit,PTSapps/DynamicPort};fi
tar zxf /src/PTSproject-${PTSIM_VERSION}.tar.gz -C $G4DIR/ptsim/${PTSIM_VERSION}/build
#PTStoolkit
cd $G4DIR/ptsim/${PTSIM_VERSION}/build/PTStoolkit && \
cmake -DCMAKE_INSTALL_PREFIX=$G4DIR/ptsim/${PTSIM_VERSION}/PTStoolkit -DUSEIAEAPHSP=ON $G4DIR/ptsim/${PTSIM_VERSION}/build/PTSproject/PTStoolkit && \
make -j`grep -c processor /proc/cpuinfo` && make install
#PTSapps
cd $G4DIR/ptsim/${PTSIM_VERSION}/build/PTSapps/DynamicPort && \
cmake -DUSEROOT=ON -DCMAKE_INSTALL_PREFIX=$G4DIR/ptsim/${PTSIM_VERSION}/PTSapps/DynamicPort -DUSEIAEAPHSP=ON -DIAEAPHSP_WRITE_USE=ON $G4DIR/ptsim/${PTSIM_VERSION}/build/PTSproject/PTSapps/DynamicPort && \
make -j`grep -c processor /proc/cpuinfo` && make install
rm -rf $G4DIR/ptsim/${PTSIM_VERSION}/build

#%appfiles PTSIM
#PTSproject-105-001-002-20190918.tar.gz /src
