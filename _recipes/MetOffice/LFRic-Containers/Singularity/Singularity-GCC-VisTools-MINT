Bootstrap: docker
From: ubuntu:18.04

%labels
    Author wolfgang.hayek@niwa.co.nz

%help
    This container provides a complete LFRic build environment along with a "headless"
    version of ParaView (only ParaView Server and ParaView Python), as well as additional
    tools such as Iris (scitools.org.uk/iris) and essential Python packages.

%environment

    # PSyclone settings
    export PSYCLONE_CONFIG=/usr/local/share/psyclone/psyclone.cfg

    # Required for auto-loading the netCDFLFRicReader plugin
    export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib/netCDFLFRicReader
    export PV_PLUGIN_PATH=/usr/local/lib/netCDFLFRicReader

    # LFRic build configs
    export FC=gfortran
    export FPP="cpp -traditional-cpp"
    export FFLAGS="-I/usr/local/include -I/usr/include/mpich -I/usr/include -I/usr/local/mod"
    export LDMPI=mpif90
    export LDFLAGS="-L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/hdf5/mpich"
    export PFUNIT=/usr/local

    # FCM and ROSE
    export PATH=/fcm/bin:/rose/usr/bin:$PATH
    export ROSE_HOME=/rose

%post

    apt-get update && apt-get upgrade -y

    # Set timezone to UTC non-interactively
    ln -fs /usr/share/zoneinfo/UTC /etc/localtime
    apt-get install -y tzdata
    dpkg-reconfigure --frontend noninteractive tzdata

    # LFRic build system requires Bash to be the default shell
    echo "dash dash/sh boolean false" | debconf-set-selections
    dpkg-reconfigure --frontend noninteractive dash

    apt-get install -y unzip xz-utils pkg-config git wget make cmake libmpich-dev libosmesa6-dev \
                       libtbb-dev libgeos-dev libproj-dev libhdf5-mpich-dev libudunits2-dev \
                       python3-dev python3-pip python3-setuptools python2.7 python-requests \
                       g++ subversion liburi-perl m4 libcurl4-gnutls-dev libxml-parser-perl \
                       rsync gpg-agent psmisc

    # Make Python3 the default Python, required by pFUnit and LFRic build systems
    # Note that this may break Python3-incompatible scripts
    update-alternatives --install /usr/local/bin/python python /usr/bin/python3 10
    update-alternatives --config python

    # Rose requires Python 2
    update-alternatives --install /usr/local/bin/python2 python2 /usr/bin/python2.7 10
    update-alternatives --config python2

    #
    # yaxt
    #

    yaxt_version=0.9.0
    yaxt_sha256=d3673e88c1cba3b77e0821393b94b5952d8ed7dc494305c8cf93e7ebec19483c

    # The configure script needs to run an MPI test executable which can fail if hostname is not recognised
    cp /etc/hosts /etc/hosts.bak
    hostname_current=$(hostname)
    echo "127.0.0.1 ${hostname_current}" > /etc/hosts
    echo "::1       ${hostname_current}" >> /etc/hosts

    wget https://www.dkrz.de/redmine/attachments/download/498/yaxt-${yaxt_version}.tar.gz
    echo "${yaxt_sha256} yaxt-${yaxt_version}.tar.gz" | sha256sum --check
    tar -xf yaxt-${yaxt_version}.tar.gz
    mkdir yaxt-${yaxt_version}_build
    cd yaxt-${yaxt_version}_build
    ../yaxt-${yaxt_version}/configure --with-idxtype=long CC=mpicc FC=mpif90 FPP="mpif90 -E -cpp"
    make -j 4
    make install
    cd ..
    rm -r yaxt-${yaxt_version}.tar.gz yaxt-${yaxt_version} yaxt-${yaxt_version}_build

    # Reset hosts file
    cat /etc/hosts.bak > /etc/hosts
    rm /etc/hosts.bak

    #
    # netCDF-C with parallel HDF5
    #

    ncc_version=4.7.4
    ncc_sha256=99930ad7b3c4c1a8e8831fb061cb02b2170fc8e5ccaeda733bd99c3b9d31666b

    wget https://github.com/Unidata/netcdf-c/archive/v${ncc_version}.tar.gz
    echo "${ncc_sha256} v${ncc_version}.tar.gz" | sha256sum --check
    tar -xf v${ncc_version}.tar.gz
    mkdir netcdf-c-${ncc_version}_build
    cd netcdf-c-${ncc_version}_build
    ../netcdf-c-${ncc_version}/configure CC=mpicc CXX=mpicxx FF=mpif90 FC=mpif90 CFLAGS="-I/usr/include/hdf5/mpich" \
      LDFLAGS="-L/usr/lib/x86_64-linux-gnu/hdf5/mpich -Wl,-rpath=/usr/lib/x86_64-linux-gnu/hdf5/mpich"
    make -j 4
    make install
    cd ..
    rm -r v${ncc_version}.tar.gz netcdf-c-${ncc_version} netcdf-c-${ncc_version}_build

    #
    # netCDF-Fortran with parallel HDF5
    #

    ncf_version=4.5.3
    ncf_sha256=c6da30c2fe7e4e614c1dff4124e857afbd45355c6798353eccfa60c0702b495a

    wget https://github.com/Unidata/netcdf-fortran/archive/v${ncf_version}.tar.gz
    echo "${ncf_sha256} v${ncf_version}.tar.gz" | sha256sum --check
    tar -xf v${ncf_version}.tar.gz
    mkdir netcdf-fortran-${ncf_version}_build
    cd netcdf-fortran-${ncf_version}_build
    ../netcdf-fortran-${ncf_version}/configure CC=mpicc CXX=mpicxx FF=mpif90 FC=mpif90
    make -j 4
    make install
    cd ..
    rm -r v${ncf_version}.tar.gz netcdf-fortran-${ncf_version} netcdf-fortran-${ncf_version}_build

    #
    # netCDF-C++ with parallel HDF5
    #

    nccxx_version=4.3.1
    nccxx_sha256=e3fe3d2ec06c1c2772555bf1208d220aab5fee186d04bd265219b0bc7a978edc

    wget https://github.com/Unidata/netcdf-cxx4/archive/v${nccxx_version}.tar.gz
    echo "${nccxx_sha256} v${nccxx_version}.tar.gz" | sha256sum --check
    tar -xf v${nccxx_version}.tar.gz
    mkdir netcdf-cxx4-${nccxx_version}_build
    cd netcdf-cxx4-${nccxx_version}_build
    ../netcdf-cxx4-${nccxx_version}/configure CC=mpicc CXX=mpicxx FF=mpif90 FC=mpif90 CFLAGS="-I/usr/include/hdf5/mpich" \
      LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib"
    make -j 4
    make install
    cd ..
    rm -r v${nccxx_version}.tar.gz netcdf-cxx4-${nccxx_version} netcdf-cxx4-${nccxx_version}_build

    #
    # XIOS
    #

    xios_revision=1866

    ln -s /usr/bin/make /usr/bin/gmake
    svn co http://forge.ipsl.jussieu.fr/ioserver/svn/XIOS/trunk@${xios_revision} XIOS
    cd XIOS
    echo "export HDF5_INC_DIR=/usr/include/hdf5/mpich" > arch/arch-GCC_LINUX.env
    echo "export HDF5_LIB_DIR=/usr/lib/x86_64-linux-gnu/hdf5/mpich" >> arch/arch-GCC_LINUX.env
    echo "export NETCDF_INC_DIR=/usr/local/include" >> arch/arch-GCC_LINUX.env
    echo "export NETCDF_LIB_DIR=/usr/local/lib" >> arch/arch-GCC_LINUX.env
    ./make_xios --full --arch GCC_LINUX --job 4
    cp lib/libxios.a /usr/lib
    cp inc/* /usr/include
    cd ..
    rm -r XIOS

    #
    # pFUnit
    #

    pfunit_version=3.2.9
    pfunit_sha256=21c55f438b2ec7247645261e341fc03b2a07460becc6ec1c99c5ddb4aa971f70

    wget https://sourceforge.net/projects/pfunit/files/latest/download/pFUnit-${pfunit_version}.tgz
    echo "${pfunit_sha256} pFUnit-${pfunit_version}.tgz" | sha256sum --check
    tar -xf pFUnit-${pfunit_version}.tgz
    cd pFUnit-${pfunit_version}
    export F90_VENDOR=GNU
    export F90=gfortran
    export MPIF90=mpif90
    export MPI=YES
    export INSTALL_DIR=/usr/local
    make
    make install
    cd ..
    rm -r pFUnit-${pfunit_version}.tgz pFUnit-${pfunit_version}

    #
    # FCM
    #

    fcm_version=2019.09.0
    fcm_sha256=0c291c652d6d2827a789cc326d9f2e3b2daa2a10aae7faa72d2fad3fd8a650c2

    wget https://github.com/metomi/fcm/archive/${fcm_version}.tar.gz
    echo "${fcm_sha256} ${fcm_version}.tar.gz" | sha256sum --check
    tar -xf ${fcm_version}.tar.gz
    ln -s fcm-${fcm_version} fcm
    rm ${fcm_version}.tar.gz

    #
    # Rose
    #

    rose_version=2019.01.3
    rose_sha256=ea1d75f9e1b4787af7402c990726112a760538fada9ab8198cd391ca61a11834

    wget https://github.com/metomi/rose/archive/${rose_version}.tar.gz
    echo "${rose_sha256} ${rose_version}.tar.gz" | sha256sum --check
    tar -xf ${rose_version}.tar.gz
    ln -s rose-${rose_version} rose
    ln -rs rose-${rose_version}/usr/bin/rose rose-${rose_version}/usr/bin/rosie
    rm ${rose_version}.tar.gz

    #
    # Python packages
    #

    # Provides more recent versions than apt-get
    pip3 install cython matplotlib numpy pandas scipy Jinja2 PSyclone

    # Set PSyclone permissions to default for usr directory
    chmod 0755 /usr/local/bin/psyclone

    # Build these from source to make sure that netCDF/HDF5/GEOS system libraries are used
    pip3 install --no-binary :all: netCDF4 shapely cartopy

    # Pyke is required by Iris but not available through package managers
    wget https://sourceforge.net/projects/pyke/files/pyke/1.1.1/pyke3-1.1.1.zip
    echo "b877b390e70a2eacc01d97c3a992fde947276afc2798ca3ac6c6f74c796cb6dc pyke3-1.1.1.zip" | sha256sum --check
    unzip -q pyke3-1.1.1.zip
    cd pyke-1.1.1
    python3 setup.py install
    cd ..
    rm -r pyke-1.1.1 pyke3-1.1.1.zip

    # Install Iris with UGRID support
    pip3 install pyugrid scitools-iris

    #
    # ParaView
    #

    # Select ParaView major.minor version and patch to form "major.minor.patch"
    pv_version=5.8
    pv_patch=1
    pv_sha256=7653950392a0d7c0287c26f1d3a25cdbaa11baa7524b0af0e6a1a0d7d487d034

    # Download and verity ParaView sources
    pv_url="https://www.paraview.org/paraview-downloads/download.php"
    pv_url_params="submit=Download&version=v${pv_version}&type=source&os=Sources&downloadFile="
    pv_filename=ParaView-v${pv_version}.${pv_patch}.tar.xz
    wget "${pv_url}?${pv_url_params}${pv_filename}" -O ${pv_filename}
    echo "${pv_sha256} ${pv_filename}" | sha256sum --check

    # Build ParaView without GUI and X ("headless") - this will provide ParaView Server
    # and ParaView Python. Use same netCDF/HDF5 libraries as Python-netCDF4 to avoid
    # runtime issues. Parallel NetCDF/HDF5 require using MPI C compiler.
    tar -xf ${pv_filename}
    mkdir -p ParaView-v${pv_version}.${pv_patch}/build
    cd ParaView-v${pv_version}.${pv_patch}/build
    cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DCMAKE_C_COMPILER=mpicc \
    -DCMAKE_CXX_COMPILER=mpiCC \
    -DCMAKE_Fortran_COMPILER=mpif90 \
    -DPARAVIEW_BUILD_EDITION=CANONICAL \
    -DPARAVIEW_BUILD_SHARED_LIBS=ON \
    -DPARAVIEW_INSTALL_DEVELOPMENT_FILES=ON \
    -DPARAVIEW_USE_QT=OFF \
    -DPARAVIEW_USE_PYTHON=ON \
    -DPARAVIEW_USE_MPI=ON \
    -DPARAVIEW_USE_VTKM=OFF \
    -DPARAVIEW_ENABLE_RAYTRACING=OFF \
    -DPARAVIEW_ENABLE_VISITBRIDGE=OFF \
    -DPARAVIEW_PLUGIN_ENABLE_NetCDFTimeAnnotationPlugin=ON \
    -DPARAVIEW_PLUGIN_ENABLE_StreamLinesRepresentation=ON \
    -DPARAVIEW_PLUGIN_ENABLE_StreamingParticles=ON \
    -DPARAVIEW_PLUGIN_ENABLE_SurfaceLIC=ON \
    -DVTK_USE_X=OFF \
    -DVTK_OPENGL_HAS_OSMESA=ON \
    -DVTK_SMP_IMPLEMENTATION_TYPE=tbb \
    -DVTK_MODULE_ENABLE_VTK_GeovisCore=YES \
    -DVTK_MODULE_ENABLE_VTK_IONetCDF=YES \
    -DVTK_MODULE_USE_EXTERNAL_VTK_netcdf=ON \
    -DVTK_MODULE_USE_EXTERNAL_VTK_hdf5=ON
    make -j 4
    make install
    cd ../..
    rm -r ParaView-v${pv_version}.${pv_patch} ${pv_filename}

    #
    # LFRic Reader plugin
    #

    git clone https://github.com/niwa/lfric_reader.git
    mkdir -p lfric_reader/src/cxx/build
    cd lfric_reader/src/cxx/build
    cmake .. -DBUILD_TESTING=OFF -DCMAKE_INSTALL_PREFIX=/usr/local \
             -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpiCC
    make -j 4
    make install
    cd ../../../..
    rm -rf lfric_reader

    #
    # Catalyst adaptor
    #

    git clone https://github.com/niwa/lfric_catalyst_adaptor.git
    mkdir -p lfric_catalyst_adaptor/src/cxx/build
    cd lfric_catalyst_adaptor/src/cxx/build
    cmake .. -DBUILD_TESTING=OFF -DCMAKE_INSTALL_PREFIX=/usr/local \
             -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpiCC
    make -j 4
    make install
    cd ../../../..
    rm -rf lfric_catalyst_adaptor

    #
    # MINT regridding library
    #

    git clone https://github.com/pletzer/mint.git
    mkdir -p mint/build
    cd mint/build
    cmake .. \
    -DVTK_INCLUDE_DIR=/usr/local/include/paraview-${pv_version} \
    -DVTK_LIBRARY_DIR=/usr/local/lib \
    -DVTK_VERSION=pv${pv_version} \
    -DCMAKE_INSTALL_PREFIX=/usr/local
    make -j 4
    make install
    cd ../..
    rm -rf mint
