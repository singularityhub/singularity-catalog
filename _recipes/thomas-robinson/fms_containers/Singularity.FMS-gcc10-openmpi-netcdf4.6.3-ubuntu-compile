Bootstrap: library
From: ubuntu:18.04
Stage: build

%files

%environment

%post
    echo "Installing required packages..."
    apt-get update && apt install -y software-properties-common
    add-apt-repository ppa:ubuntu-toolchain-r/test
    apt-get update && apt-get install -y wget git bash make autoconf gcc-10 gfortran-10 g++-10 libtool vim curl zip gzip
#Set up gcc in bin folder 
    ln -s `which gcc-10` /usr/bin/gcc
    ln -s `which gfortran-10` /usr/bin/gfortran
    ln -s `which g++-10` /usr/bin/g++

    mkdir -p /opt
# Use spack to install openmp netcdf and netcdff
    cd /opt
    git clone https://github.com/spack/spack.git
    cd spack/bin
    cp * /usr/sbin
    export SPACK_ROOT=/opt/spack
    . $SPACK_ROOT/share/spack/setup-env.sh 
    echo "Installing NETCDF"
    spack install netcdf-fortran@4.4.4 ^netcdf-c @4.6.3 %gcc@10.1.0

%runscript
## SET UP
# Set up the environment using spack
 export SPACK_ROOT=/opt/spack
 . $SPACK_ROOT/share/spack/setup-env.sh
  # Environment variables for the netCDF C-language interface
  export NETCDF_HOME=$(spack location -i netcdf-c)
  export GC_BIN=$NETCDF_HOME/bin
  export GC_INCLUDE=$NETCDF_HOME/include
  export GC_LIB=$NETCDF_HOME/lib
  # Environment variables for the netCDF Fortran-languge interface
  export NETCDF_FORTRAN_HOME=$(spack location -i netcdf-fortran)
  export GC_F_BIN=$NETCDF_FORTRAN_HOME/bin
  export GC_F_INCLUDE=$NETCDF_FORTRAN_HOME/include
  export GC_F_LIB=$NETCDF_FORTRAN_HOME/lib
# Set up the path and libraries
 export PATH=$(spack location -i openmpi)/bin:${NETCDF_FORTRAN_HOME}/bin:${NETCDF_HOME}/bin:${PATH}
 export LD_LIBRARY_PATH="$NETCDF_HOME/lib:$NETCDF_FORTRAN_HOME/lib:$LD_LIBRARY_PATH"
 export LIBRARY_PATH=$LD_LIBRARY_PATH

## FMS SCRIPT
# Create directories
 mkdir fms && cd fms
 git clone https://github.com/NOAA-GFDL/FMS.git
 mkdir build && cd build
# Set up variables for use with 'configure'
 export FC=$(spack location -i openmpi)/bin/mpif90
 export CC=$(spack location -i openmpi)/bin/mpicc
 export CFLAGS="`nc-config --cflags` "
 export FCFLAGS="`nf-config --fflags` "
 export LDFLAGS="-L`nc-config --libdir` `nf-config --flibs`  "
# Compile FMS and run make distcheck
 autoreconf -i ../FMS/configure.ac
 ../FMS/configure 
 make distcheck
