Bootstrap: yum
OSVersion: 7
MirrorURL: http://mirror.iau.edu.sa/centos7/
Include: yum

%help
    This container hosts QuantumEspresso version 5.4 on CentOS 7, compiled using Intel Compilers (static-linking) and Intel MPI (Version 5.1.3.223).

%setup
    wget http://qe-forge.org/gf/download/frsrelease/211/972/QE-GPU-5.4.0.tar.gz
    wget http://qe-forge.org/gf/download/frsrelease/211/969/EPW-5.4.0.tar.gz
    wget http://qe-forge.org/gf/download/frsrelease/211/954/atomic-5.4.0.tar.gz
    wget http://qe-forge.org/gf/download/frsrelease/211/957/GWW-5.4.0.tar.gz
    wget http://qe-forge.org/gf/download/frsrelease/211/958/xspectra-5.4.0.tar.gz
    wget http://qe-forge.org/gf/download/frsrelease/211/961/PWgui-5.4.0.tar.gz
    wget http://qe-forge.org/gf/download/frsrelease/211/962/PHonon-5.4.0.tar.gz
    wget http://qe-forge.org/gf/download/frsrelease/211/956/tddfpt-5.4.0.tar.gz
    wget http://qe-forge.org/gf/download/frsrelease/211/959/neb-5.4.0.tar.gz
    wget http://qe-forge.org/gf/download/frsrelease/211/960/pwcond-5.4.0.tar.gz
    wget http://qe-forge.org/gf/download/frsrelease/211/963/test-suite-5.4.0.tar.gz
    mkdir -p ${SINGULARITY_ROOTFS}/sources/qe/archive
    mkdir -p ${SINGULARITY_ROOTFS}/sources/mpi
    mv *.tar.gz ${SINGULARITY_ROOTFS}/sources/qe/archive
    
    wget http://qe-forge.org/gf/download/frsrelease/211/968/espresso-5.4.0.tar.gz
    mv ./espresso-5.4.0.tar.gz ${SINGULARITY_ROOTFS}/sources/qe
    
    wget http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/9279/l_mpi-rt_p_5.1.3.223.tgz
    mv ./l_mpi-rt_p_5.1.3.223.tgz ${SINGULARITY_ROOTFS}/sources/mpi

%post
    mkdir /vault || true
    rm -rf /etc/yum.repos.d/* || true

    echo "[mirror]
name=CentOS main repositry
baseurl=http://mirror.shpc.iau.edu.sa/centos7/
enabled=1
gpgcheck=0

[epel]
name=epel repositry
baseurl=http://mirror.shpc.iau.edu.sa/epel/
enabled=1
gpgcheck=0
" >> /etc/yum.repos.d/mirror.repo
    
    echo "Installing some dependecies"
    yum install util-linux nfs-utils man-db which -y
    
    echo "Mounting /vault"
    mount -t nfs vault.shpc.iau.edu.sa:/vault/nas1 /vault

    echo "Installing gcc and friends"
    yum -y install gcc gcc-c++ gcc-gfortran make dapl libibverbs

    echo "Installing IntelMPI"
    cd /sources/mpi
    tar xzvf l_mpi-rt_p_5.1.3.223.tgz
    cd l_mpi-rt_p_5.1.3.223/
    sed -i 's/decline/accept/' silent.cfg
    ./install.sh -s silent.cfg || true

    echo "Sourcing Intel Compilers"
    source /vault/shpc/apps/compiler/intel/2016u4/parallel_studio_xe_2016.4.072/psxevars.sh
    
    echo "Building QuantumEspresso"
    cd /sources/qe
    tar xzvf ./espresso-5.4.0.tar.gz
    cp archive/* espresso-5.4.0/archive/
    cd espresso-5.4.0/
    
    FFLAGS="-xHost -O2 -assume byterecl -g -traceback -static-intel" CFLAGS="-xHost -O3 -static-intel" \
    FFT_LIBS="${MKLROOT}/lib/intel64/libmkl_scalapack_lp64.a -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_lp64.a ${MKLROOT}/lib/intel64/libmkl_sequential.a ${MKLROOT}/lib/intel64/libmkl_core.a ${MKLROOT}/lib/intel64/libmkl_blacs_intelmpi_lp64.a -Wl,--end-group -lpthread -lm -ldl" \
    BLAS_LIBS="${MKLROOT}/lib/intel64/libmkl_scalapack_lp64.a -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_lp64.a ${MKLROOT}/lib/intel64/libmkl_sequential.a ${MKLROOT}/lib/intel64/libmkl_core.a ${MKLROOT}/lib/intel64/libmkl_blacs_intelmpi_lp64.a -Wl,--end-group -lpthread -lm -ldl" \
    SCALAPACK_LIBS=" ${MKLROOT}/lib/intel64/libmkl_scalapack_lp64.a -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_lp64.a ${MKLROOT}/lib/intel64/libmkl_sequential.a ${MKLROOT}/lib/intel64/libmkl_core.a ${MKLROOT}/lib/intel64/libmkl_blacs_intelmpi_lp64.a -Wl,--end-group -lpthread -lm -ldl" \
    FC=mpiifort CC=mpiicc F77=mpiifort MPIF90=mpiifort ./configure --with-scalapack=intel --prefix=/usr/local/bin

    make all && make install

    echo "Cleaning up..."
    cd /
    rm -rf /sources

%runscript
    source /opt/intel/impi/5.1.3.223/bin64/mpivars.sh
    $@

%labels
    Maintainer IAU HPC Center <shpc@iau.edu.sa>
    Version v1.0

