# LAMMPS Serial with Granular
BootStrap: yum
OSVersion: 7
MirrorURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/os/$basearch/
Include: yum

%setup
  cd $SINGULARITY_ROOTFS/opt
  wget http://lammps.sandia.gov/tars/lammps-stable.tar.gz

%post
  yum -y groupinstall "Development Tools"

  mkdir -p /opt/lammps
  cd /opt/lammps
  tar xf ../lammps-stable.tar.gz --strip-components 1

  cd src
  make yes-granular |& tee log.make_yes_granular
  make -j serial |& tee log.make_serial

%runscript
  /opt/lammps/src/lmp_serial "$@"
