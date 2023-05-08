BootStrap: yum
OSVersion: 7
MirrorURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/os/$basearch/
Include: yum

%setup
  cd $SINGULARITY_ROOTFS/opt
  wget http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz
  wget http://lammps.sandia.gov/tars/lammps-stable.tar.gz
  
%post
  yum -y groupinstall "Development Tools"

  mkdir -p /opt/mpich
  cd /opt/mpich
  tar xf ../mpich-3.2.tar.gz --strip-components 1

  ./configure --prefix=/usr/local |& tee log.configure
  make -j |& tee log.make
  make install |& tee log.make_install

  mkdir -p /opt/lammps
  cd /opt/lammps
  tar xf ../lammps-stable.tar.gz --strip-components 1

  cd src
  make yes-granular |& tee log.make_yes_granular
  make -j mpi |& tee log.make_mpi

%runscript
  /opt/lammps/src/lmp_mpi "$@"
