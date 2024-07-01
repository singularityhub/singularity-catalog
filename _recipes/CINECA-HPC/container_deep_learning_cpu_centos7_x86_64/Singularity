Bootstrap: docker
From: centos:centos7.8.2003 
IncludeCmd: yes

%post

# Python
export TENSORFLOW_VERSION=1.14.0
export PYTORCH_VERSION=1.4.0
export TORCHVISION_VERSION=0.5.0
export MXNET_VERSION=1.6.0
export HOROVOD_VERSION=0.19.1

# Python 3.6
export python=3.6
export PYTHON_VERSION=${python}

yum -y groupinstall "Development tools"

yum -y install epel-release 
yum -y install                   python36 
yum -y install                   python3-pip 
yum -y install                   python3-devel 
yum -y install                   bzip2  
yum -y install                   gzip 
yum -y install                   tar 
yum -y install                   zip 
yum -y install                   unzip 
yum -y install                   xz 
yum -y install                   curl 
yum -y install                   wget 
yum -y install                   vim 
yum -y install                   patch 
yum -y install                   make 
yum -y install                   cmake 
yum -y install                   file 
yum -y install                   git 
yum -y install                   which 
yum -y install                   gcc-c++ 
yum -y install                   perl-Data-Dumper 
yum -y install                   perl-Thread-Queue 
yum -y install                   boost-devel 
yum -y install                   openssl
yum  -y install                libibverbs-devel 
yum  -y install                rdma-core-devel 
yum  -y install                openssl-devel 
yum  -y install                binutils 
yum  -y install                dapl 
yum  -y install                dapl-utils 
yum  -y install                ibacm 
yum  -y install                infiniband-diags 
yum  -y install                libibverbs 
yum  -y install                libibverbs-utils 
yum  -y install                libmlx4 
yum  -y install                librdmacm 
yum  -y install                librdmacm-utils 
yum  -y install                mstflint 
yum  -y install                opensm-libs 
yum  -y install                perftest 
yum  -y install                qperf 
yum  -y install                rdma 
yum  -y install                libjpeg-turbo-devel 
yum  -y install                libpng-devel 
yum  -y install                openssh-clients 
yum  -y install                openssh-server 
yum  -y install                subversion 
yum  -y install                libffi 
yum  -y install                libffi-devel 
yum  -y install                scl-utils
yum -y install libpsm2 libpsm2-devel pmix pmix-devel
yum -y install centos-release-scl
yum -y install devtoolset-7-toolchain

# LOAD GNU 7.3.1

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

mkdir -p /var/run/sshd

pip3 install --upgrade pip 

# Install Open MPI
mkdir -p /tmp/openmpi 
cd /tmp/openmpi 
    wget https://download.open-mpi.org/release/open-mpi/v2.1/openmpi-2.1.1.tar.gz 
    tar zxf openmpi-2.1.1.tar.gz 
    cd openmpi-2.1.1 
    ./configure --prefix=/opt/openmpi --disable-getpwuid --with-psm2=yes --with-memory-manager=none  --enable-static=yes --with-pmix --enable-shared --with-verbs --enable-mpirun-prefix-by-default --disable-dlopen --enable-wrapper-rpath=no --enable-wrapper-runpath=no 
    make -j $(nproc) all 
    make install 
    cd /tmp 
    rm -rf /tmp/openmpi

export PATH=/opt/openmpi/bin:${PATH}
export LD_LIBRARY_PATH=/opt/openmpi/lib:${LD_LIBRARY_PATH}


# Install TensorFlow, Keras, PyTorch and MXNet

pip3 install future typing

pip3 install numpy \
        tensorflow==${TENSORFLOW_VERSION} \
        keras \
        h5py

pip3 install torch==${PYTORCH_VERSION} torchvision==${TORCHVISION_VERSION}

pip3 install mxnet==${MXNET_VERSION}

# Install Horovod
HOROVOD_WITH_TENSORFLOW=1 HOROVOD_WITH_PYTORCH=1 HOROVOD_WITH_MXNET=1 \
    pip3 install --no-cache-dir horovod==${HOROVOD_VERSION}



%environment

export TERM=xterm 
export HOME=/root 
export MANPATH=/opt/rh/devtoolset-7/root/usr/share/man: 
export PERL5LIB=/opt/rh/devtoolset-7/root//usr/lib64/perl5/vendor_perl:/opt/rh/devtoolset-7/root/usr/lib/perl5:/opt/rh/devtoolset-7/root//usr/share/perl5/vendor_perl 
export PCP_DIR=/opt/rh/devtoolset-7/root 
export PWD=/examples 
export LANG=en_US.UTF-8 
export SHLVL=1 
export PATH=/opt/openmpi/bin:/opt/rh/devtoolset-7/root/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin 
export LD_LIBRARY_PATH=/opt/openmpi/lib:/opt/rh/devtoolset-7/root:/opt/rh/devtoolset-7/root/dyninst/dyninst:/opt/rh/devtoolset-7/root 
export PYTHONPATH=/opt/rh/devtoolset-7/root/usr/lib64/python3.6/site-packages:/opt/rh/devtoolset-7/root/usr/lib/python3.6/site-packages 
export INFOPATH=/opt/rh/devtoolset-7/root/usr/share/info 
export I_MPI_DEBUG="3" 
export I_MPI_DEBUG_OUTPUT=debug.dbg   
export MPICC=mpicc
export MPICXX=mpicxx
export MPIF90=mpif90
export MPIF77=mpif77
export MPIFC=mpifort
