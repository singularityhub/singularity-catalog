Bootstrap: docker
From: centos:centos7.4.1708
IncludeCmd: yes

%setup

mkdir -p ${SINGULARITY_ROOTFS}/tmpdir

%post

yum install -y epel-release
yum -y install wget vim which curl tar gzip 
yum -y groupinstall "Development tools"
yum -y install binutils
yum -y install dapl dapl-utils ibacm infiniband-diags libibverbs libibverbs-devel libibverbs-utils libmlx4 librdmacm librdmacm-utils mstflint opensm-libs perftest qperf rdma

yum -y install scl-utils
yum -y install centos-release-scl
yum -y install devtoolset-7-toolchain 

# LOAD GNU 7.3.1

# General environment variables
export PATH=/opt/rh/devtoolset-7/root/usr/bin${PATH:+:${PATH}}
export MANPATH=/opt/rh/devtoolset-7/root/usr/share/man:${MANPATH}
export INFOPATH=/opt/rh/devtoolset-7/root/usr/share/info${INFOPATH:+:${INFOPATH}}
export PCP_DIR=/opt/rh/devtoolset-7/root
# Some perl Ext::MakeMaker versions install things under /usr/lib/perl5
# even though the system otherwise would go to /usr/lib64/perl5.
export PERL5LIB=/opt/rh/devtoolset-7/root//usr/lib64/perl5/vendor_perl:/opt/rh/devtoolset-7/root/usr/lib/perl5:/opt/rh/devtoolset-7/root//usr/share/perl5/vendor_perl${PERL5LIB:+:${PERL5LIB}}
export LD_LIBRARY_PATH=/opt/rh/devtoolset-7/root$rpmlibdir$rpmlibdir32${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export LD_LIBRARY_PATH=/opt/rh/devtoolset-7/root$rpmlibdir$rpmlibdir32:/opt/rh/devtoolset-7/root$rpmlibdir/dyninst$rpmlibdir32/dyninst${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
# duplicate python site.py logic for sitepackages
export pythonvers=3.6
export PYTHONPATH=/opt/rh/devtoolset-7/root/usr/lib64/python$pythonvers/site-packages:/opt/rh/devtoolset-7/root/usr/lib/python$pythonvers/site-packages${PYTHONPATH:+:${PYTHONPATH}}

gcc --version

cd /tmpdir
wget https://github.com/QEF/q-e/archive/qe-6.5.tar.gz
wget https://download.open-mpi.org/release/open-mpi/v2.1/openmpi-2.1.1.tar.gz
wget https://github.com/yambo-code/yambo/archive/4.5.3.tar.gz

##############################
# OpenMPI 2.1.1 installation
cd /tmpdir
tar -xvf  openmpi-2.1.1.tar.gz
rm openmpi-2.1.1.tar.gz
cd openmpi-2.1.1
./configure --prefix=/usr/local/openmpi --disable-getpwuid --enable-orterun-prefix-by-default

make
make install

export PATH=/usr/local/openmpi/bin:${PATH}
export LD_LIBRARY_PATH=/usr/local/openmpi/lib:${LD_LIBRARY_PATH}

##############################
# QE 6.5 installation
cd /tmpdir
tar -xvf qe-6.5.tar.gz
rm qe-6.5.tar.gz
cd q-e-qe-6.5
export QE_INSTALL_DIR=/usr/local/q-e-qe-6.5/
./configure --enable-openmp --enable-parallel
make all

export PATH=/tmpdir/q-e-qe-6.5/bin:$PATH
export MPICC=mpicc
export MPICXX=mpicxx
export MPIF90=mpif90
export MPIF77=mpif77
export MPIFC=mpifort

##############################
# Yambo 4.5.3 installation
cd /tmpdir
tar -xvf 4.5.3.tar.gz
rm 4.5.3.tar.gz
cd yambo-4.5.3
./configure
make yambo interfaces

##############################

# Test case compilation
#mkdir -p /test
#chmod 777 -R /test
#cd /test
#wget https://gitlab.hpc.cineca.it/container_data_example/data_example/raw/master/mpi/hello.c
#/usr/local/openmpi/bin/mpicc -o hello.x hello.c

##############################

echo "Creation mountpoints"
mkdir -p /marconi /galileo /scratch
chmod 777 -R /scratch

#############################

%environment

export LD_LIBRARY_PATH=/opt/rh/devtoolset-7/root$rpmlibdir$rpmlibdir32${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export LD_LIBRARY_PATH=/opt/rh/devtoolset-7/root$rpmlibdir$rpmlibdir32:/opt/rh/devtoolset-7/root$rpmlibdir/dyninst$rpmlibdir32/dyninst${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
# duplicate python site.py logic for sitepackages
export pythonvers=3.6
export PYTHONPATH=/opt/rh/devtoolset-7/root/usr/lib64/python$pythonvers/site-packages:/opt/rh/devtoolset-7/root/usr/lib/python$pythonvers/site-packages${PYTHONPATH:+:${PYTHONPATH}}
export INFOPATH=/opt/rh/devtoolset-7/root/usr/share/info${INFOPATH:+:${INFOPATH}}
export PCP_DIR=/opt/rh/devtoolset-7/root
# Some perl Ext::MakeMaker versions install things under /usr/lib/perl5
# even though the system otherwise would go to /usr/lib64/perl5.
export PERL5LIB=/opt/rh/devtoolset-7/root//usr/lib64/perl5/vendor_perl:/opt/rh/devtoolset-7/root/usr/lib/perl5:/opt/rh/devtoolset-7/root//usr/share/perl5/vendor_perl${PERL5LIB:+:${PERL5LIB}}
export MANPATH=/opt/rh/devtoolset-7/root/usr/share/man:${MANPATH}
export PATH=/opt/rh/devtoolset-7/root/usr/bin:/tmpdir/yambo-4.5.3/bin:/tmpdir/q-e-qe-6.5/bin:/usr/local/openmpi/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/openmpi/lib:$LD_LIBRARY_PATH
export MPICC=mpicc
export MPICXX=mpicxx
export MPIF90=mpif90
export MPIF77=mpif77
export MPIFC=mpifort
