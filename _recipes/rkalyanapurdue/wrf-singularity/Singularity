Bootstrap: docker
From: ubuntu:latest

%files
    WPSV3.9.1.TAR.gz /tmp
    WRFV3.9.1.TAR.gz /tmp 
    hdf-4.2.14.tar.gz /tmp 
    hdf5-1.10.5.tar.gz /tmp
    jasper-1.900.1.tar.gz /tmp
    v4.5.1.tar.gz  /tmp
    v4.7.1.tar.gz /tmp
    configure.wrf /tmp
    configure.wps /tmp

%environment
    export OMPI_DIR=/opt/openmpi-4.0.1
    export SINGULARITY_OMPI_DIR=$OMPI_DIR
    export SINGULARITYENV_APPEND_PATH=$OMPI_DIR/bin:/opt/netcdf-gfortran/bin/:/opt/hdf-gfortran/bin:/opt/hdf5-gfortran/bin/:/usr/local/bin
    export SINGULAIRTYENV_APPEND_LD_LIBRARY_PATH=$OMPI_DIR/lib:/opt/netcdf-gfortran/lib/:/opt/hdf-gfortran/lib:/opt/hdf5-gfortran/lib/:/usr/local/lib

%post
    echo "Untarring all files..."
    cd /tmp && tar -xf jasper-1.900.1.tar.gz && tar -xf hdf-4.2.14.tar.gz && tar -xf hdf5-1.10.5.tar.gz && tar -xf v4.5.1.tar.gz && tar -xf v4.7.1.tar.gz
    mkdir -p /opt
    mkdir -p /data
    mv /tmp/WPSV3.9.1.TAR.gz /opt
    mv /tmp/WRFV3.9.1.TAR.gz /opt
    cd /opt && tar -xf WPSV3.9.1.TAR.gz && tar -xf WRFV3.9.1.TAR.gz

    echo "Installing required packages..."
    apt-get update && apt-get install -y zlib1g slib libpng-dev libjpeg-dev libz-dev libcurl4-openssl-dev wget git make bash g++ gfortran file bison byacc flex csh tcsh

    # Jasper
    cd /tmp/jasper-1.900.1 && ./configure && make install

    # set environment 
    export CC=gcc
    export CXX=g++
    export FC=gfortran
    export F77=gfortran
    export F90=gfortran
    export CFLAGS='-m64 -g'
    export FFLAGS='-m64 -g'
    export FCFLAGS='-m64 -g'
    export CXXFLAGS='-m64 -g'
    export CPPFLAGS='-DNDEBUG'

    # hdf-4
    cd /tmp/hdf-4.2.14 && ./configure --enable-shared --disable-netcdf --disable-fortran --prefix=/opt/hdf-gfortran && make install

    # hdf-5
    cd /tmp/hdf5-1.10.5 && ./configure --enable-shared --enable-fortran --enable-cxx --prefix=/opt/hdf5-gfortran && make install

    # set environment for NETCDF install
    export CPPFLAGS='-I/opt/hdf5-gfortran/include -I/opt/hdf-gfortran/include'
    export LDFLAGS='-L/opt/hdf5-gfortran/lib -L/opt/hdf-gfortran/lib'

    # netcdf-c
    cd /tmp/netcdf-c-4.7.1 && ./configure  --prefix=/opt/netcdf-gfortran --enable-netcdf-4 --enable-hdf4 --enable-hdf4-file-tests && make install

    # netcdf-fortran
    export CPPFLAGS='-I/opt/hdf5-gfortran/include -I/opt/netcdf-gfortran/include'
    export LDFLAGS='-L/opt/hdf5-gfortran/lib -L/opt/netcdf-gfortran/lib'
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/netcdf-gfortran/lib:/opt/hdf5-gfortran/lib:/opt/hdf-gfortran/lib

    cd /tmp/netcdf-fortran-4.5.1 && ./configure --prefix=/opt/netcdf-gfortran && make install

    # nco
    apt-get -y install nco

    # Open MPI
    export OMPI_DIR=/opt/openmpi-4.0.1
    export OMPI_VERSION=4.0.1
    export OMPI_URL="https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-$OMPI_VERSION.tar.bz2"
    mkdir -p /tmp/ompi
    # Download
    cd /tmp/ompi && wget -O openmpi-$OMPI_VERSION.tar.bz2 $OMPI_URL && tar -xjf openmpi-$OMPI_VERSION.tar.bz2
    # Compile and install
    cd /tmp/ompi/openmpi-$OMPI_VERSION && ./configure --prefix=$OMPI_DIR && make install

    # WRF environment
    export FC="gfortran -ffree-form -ffree-line-length-none -fbounds-check"
    export F77="gfortran -fbounds-check"
    export F90="gfortran -ffree-form -ffree-line-length-none -fbounds-check"
    export FCOPT="-O2"
    export PATH=/opt/netcdf-gfortran/bin/:/opt/hdf-gfortran/bin:/opt/hdf5-gfortran/bin/:$OMPI_DIR/bin:$PATH
    export LD_LIBRARY_PATH=/opt/netcdf-gfortran/lib/:/opt/hdf-gfortran/lib:/opt/hdf5-gfortran/lib/:$OMPI_DIR/lib:$LD_LIBRARY_PATH
    export WRFIO_NCD_LARGE_FILE_SUPPORT=1
    export NETCDF=/opt/netcdf-gfortran

    echo 'setenv FC "gfortran -ffree-form -ffree-line-length-none -fbounds-check"' >> /etc/csh.cshrc
    echo 'setenv F77 "gfortran -fbounds-check"' >> /etc/csh.cshrc
    echo 'setenv F90 "gfortran -ffree-form -ffree-line-length-none -fbounds-check"' >> /etc/csh.cshrc
    echo 'setenv FCOPT -O2' >> /etc/csh.cshrc
    echo 'setenv PATH /opt/netcdf-gfortran/bin/:/opt/hdf-gfortran/bin:/opt/hdf5-gfortran/bin/:/opt/openmpi-4.0.1/bin:/bin:/usr/bin/:/usr/local/bin' >> /etc/csh.cshrc
    echo 'setenv LD_LIBRARY_PATH /opt/netcdf-gfortran/lib/:/opt/hdf-gfortran/lib:/opt/hdf5-gfortran/lib/:/opt/openmpi-4.0.1/lib:/lib:/usr/lib/usr/local/lib' >> /etc/csh.cshrc
    echo 'setenv WRFIO_NCD_LARGE_FILE_SUPPORT 1' >> /etc/csh.cshrc
    echo 'setenv NETCDF /opt/netcdf-gfortran' >> /etc/csh.cshrc

    # WRF install
    cd /opt/WRFV3 && echo '34\r1\r' | ./configure && sed -i -e '/^DM_CC/ s/$/ -DMPI2_SUPPORT/' ./configure.wrf && /bin/csh ./compile em_real

    # WPS install
    cd /opt/WPS && echo '3\r' | ./configure && sed -i -e 's/\(mpicc\) -.*/\1/' ./configure.wps && sed -i -e 's/\(mpif90\) -.*/\1/' ./configure.wps && sed -i -e 's/\(COMPRESSION_INC.*\)\(-I[^-]*\)/\1\-I\/usr\/include\/libpng \-I\/usr\/local\/include\/jasper/' ./configure.wps && sed -i -e 's/\(COMPRESSION_LIBS.*\)\(-L[^-]*\)\(-l.*\)/\1 \-L\/usr\/local\/lib \3/' ./configure.wps && sed -i -e '/^DM_CC/ s/$/ -DMPI2_SUPPORT/' ./configure.wps && /bin/csh ./compile

