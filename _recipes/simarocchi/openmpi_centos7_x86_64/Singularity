Bootstrap: docker
From: centos:centos7.4.1708
IncludeCmd: yes

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

############# OpenMPI 2.1.1 installation #############
cd /tmpdir
wget https://download.open-mpi.org/release/open-mpi/v2.1/openmpi-2.1.1.tar.gz
tar -xvf  openmpi-2.1.1.tar.gz
rm openmpi-2.1.1.tar.gz
cd openmpi-2.1.1
./configure --prefix=/usr/local/openmpi --disable-getpwuid --enable-orterun-prefix-by-default

make
make install

%environment

# General environment variables
export PATH=/usr/local/openmpi/bin:/opt/rh/devtoolset-7/root/usr/bin${PATH:+:${PATH}}
export MANPATH=/opt/rh/devtoolset-7/root/usr/share/man:${MANPATH}
export INFOPATH=/opt/rh/devtoolset-7/root/usr/share/info${INFOPATH:+:${INFOPATH}}
export PCP_DIR=/opt/rh/devtoolset-7/root
# Some perl Ext::MakeMaker versions install things under /usr/lib/perl5
# even though the system otherwise would go to /usr/lib64/perl5.
export PERL5LIB=/opt/rh/devtoolset-7/root//usr/lib64/perl5/vendor_perl:/opt/rh/devtoolset-7/root/usr/lib/perl5:/opt/rh/devtoolset-7/root//usr/share/perl5/vendor_perl${PERL5LIB:+:${PERL5LIB}}
export LD_LIBRARY_PATH=/opt/rh/devtoolset-7/root$rpmlibdir$rpmlibdir32${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export LD_LIBRARY_PATH=/usr/local/openmpi/lib:/opt/rh/devtoolset-7/root$rpmlibdir$rpmlibdir32:/opt/rh/devtoolset-7/root$rpmlibdir/dyninst$rpmlibdir32/dyninst${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
# duplicate python site.py logic for sitepackages
export pythonvers=3.6
export PYTHONPATH=/opt/rh/devtoolset-7/root/usr/lib64/python$pythonvers/site-packages:/opt/rh/devtoolset-7/root/usr/lib/python$pythonvers/site-packages${PYTHONPATH:+:${PYTHONPATH}}
