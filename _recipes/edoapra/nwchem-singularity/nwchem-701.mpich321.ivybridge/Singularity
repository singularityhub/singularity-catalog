Bootstrap: docker
From: ubuntu:20.04
%labels
MAINTAINER  Edoardo Apra <edoardo.apra@pnnl.gov>
%post
#based on earlier work by Vladimir Konjkov <Konjkov.VV@gmail.com>
#
# Create the image with the command
# docker build -t nwchem-701.mpipr.nersc .
# 
#after successful build one you can execute the QA tests using the command
#docker run nwchem-701.mpipr.nersc dft_he2+ h2o_dk h2o_opt
#
#https://sylabs.io/guides/3.6/user-guide/mpi.html
export DEBIAN_FRONTEND=noninteractive
export nwchem_hash=a47c6fdba472b95c5929fffc62af2200207c3fb7
export SINGULARITY_nwchem_hash=75f3db2a2074e9158d605516009964d1a363e71f
export SINGULARITY_mpich=3.2.1
export SINGULARITY_mpich_prefix=mpich-$mpich
export mpich=3.2.1
export mpich_prefix=mpich-$mpich
export MPICH_DIR=/opt/mpich
apt-get update 
apt install -y tzdata

apt-get update \
&& apt-get -y upgrade \
&& apt-get install -y  g++ gfortran   make ssh patch curl subversion wget unzip perl git file python3 python3-dev cmake  unzip zip\
&& apt-get clean
\
wget https://www.mpich.org/static/downloads/$mpich/$mpich_prefix.tar.gz && \
tar xvzf $mpich_prefix.tar.gz                                           && \
cd $mpich_prefix                                                        && \
./configure  --prefix=$MPICH_DIR                                                            && \
make -j 4                                                               && \
make install                                                            && \
make clean                                                              && \
cd ..                                                                   && \
rm -rf $mpich_prefix
export PATH=$MPICH_DIR/bin:$PATH
export LD_LIBRARY_PATH=$MPICH_DIR/lib:$LD_LIBRARY_PATH
#apt install -y mpich libmpich-dev 
#apt install -y libopenmpi-dev openmpi-bin
#get OpenBLAS and compile with 64-bit integers
cd /opt
export ARMCI_NETWORK=MPI-PR
export NWCHEM_TOP=/opt/nwchem-$nwchem_hash
export NWCHEM_TARGET=LINUX64
export NWCHEM_MODULES="all python"
export BUILD_OPENBLAS=1
export BUILD_SCALAPACK=1
export BLAS_SIZE=8
export SCALAPACK_SIZE=8
export USE_64TO32=y
export USE_MPI=y
export USE_MPIF=y
export USE_MPIF4=y
#ENV         MRCC_METHODS=y
#ENV         CCSDTQ=y
#ENV         CCSDTLR=y
cd /opt;curl -SL     https://github.com/nwchemgit/nwchem/archive/$nwchem_hash.tar.gz | tar xzf - 
cd nwchem-$nwchem_hash/src \
&& sed -i 's|-march=native||' config/makefile.h \
&& sed -i 's|-mtune=native|-mtune=generic|' config/makefile.h \
&& sed -i 's|-mfpmath=sse||' config/makefile.h \
&& sed -i 's|-msse3||' config/makefile.h  \
&& make nwchem_config && make -j3  \
            && rm -rf tce tools nwdft NWints geom symmetry util nwxc ddscf lapack blas rism argos peigs rmdft gradients symmetry property smd lucia dplot propery hessian ccsd mp2_grad moints cafe analyz dimqm /opt/nwchem/lib

#ENV         NWCHEM_EXECUTABLE=${NWCHEM_TOP}/bin/LINUX64/nwchem
#ENV         NWCHEM_BASIS_LIBRARY=${NWCHEM_TOP}/src/basis/libraries/
#ENV         NWCHEM_NWPW_LIBRARY=${NWCHEM_TOP}/src/nwpw/libraryps/

#clean unnecessary packages
#apt-get -y remove  make curl subversion  unzip cmake perl tcsh  &&  apt-get -y autoremove && apt-get clean

#cd /data
%environment
export mpich=3.2.1
export SINGULARITY_mpich=3.2.1
export SINGULARITY_mpich_prefix=mpich-$mpich
export MPICH_DIR=/opt/mpich
export SINGULARITY_MPICH_DIR=$MPICH_DIR
export SINGULARITYENV_APPEND_PATH=$MPICH_DIR/bin
export SINGULARITYENV_APPEND_LD_LIBRARY_PATH=$MPICH_DIR/lib

export nwchem_hash=a47c6fdba472b95c5929fffc62af2200207c3fb7
export NWCHEM_TOP=/opt/nwchem-$nwchem_hash
export FFIELD=amber
export AMBER_1=$NWCHEM_TOP/src/data/amber_s/
export AMBER_2=$NWCHEM_TOP/src/data/amber_q/
export AMBER_3=$NWCHEM_TOP/src/data/amber_x/
export AMBER_4=$NWCHEM_TOP/src/data/amber_u/
export SPCE=${NWCHEM_TOP}/src/data/solvents/spce.rst
export CHARMM_S=$NWCHEM_TOP/src/data/charmm_s/
export CHARMM_X=$NWCHEM_TOP/src/data/charmm_x/
export PATH=$PATH:$NWCHEM_TOP/bin/LINUX64
export PATH=$MPICH_DIR/bin:$PATH
export LD_LIBRARY_PATH=$MPICH_DIR/lib:$LD_LIBRARY_PATH
#%runscript
#exec /bin/bash "$@"
