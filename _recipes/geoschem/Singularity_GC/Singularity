BootStrap: docker
From: ubuntu:16.04

%post
    apt-get update
    apt-get install -y git vim bc gcc gfortran libnetcdf-dev libnetcdff-dev netcdf-bin

%environment
    export NETCDF_HOME=/usr
    export NETCDF_FORTRAN_HOME=/usr

    export FC=gfortran
    export CC=gcc
    export CXX=g++

    # Tell GEOS-Chem where to find netCDF library files
    export GC_BIN=$NETCDF_HOME/bin
    export GC_INCLUDE=$NETCDF_HOME/include
    export GC_LIB=$NETCDF_HOME/lib

    # NOTE: If netCDF-Fortran was loaded as a separate module, then
    # also define these variables.  (Otherwise comment these out.)
    export GC_F_BIN=$NETCDF_FORTRAN_HOME/bin
    export GC_F_INCLUDE=$NETCDF_FORTRAN_HOME/include
    export GC_F_LIB=$NETCDF_FORTRAN_HOME/lib

    # Max out the stack memory for OpenMP
    # http://wiki.seas.harvard.edu/geos-chem/index.php/GNU_Fortran_compiler#Requesting_sufficient_stack_memory_for_GEOS-Chem
    # ulimit -s unlimited # do we need this inside container?
    export OMP_STACKSIZE=500m

    # fix Singularity + Perl error
    # https://groups.google.com/a/lbl.gov/forum/#!msg/singularity/58Xr72oDfBg/m3Y7Nr_PBAAJ
    export LANG=C

    # add color for interactive mode
    alias ls='ls --color=auto'

%runscript
    echo "Container for GEOS-Chem environment"
    echo "Please use 'singularity shell container_name' to run it interactively."
