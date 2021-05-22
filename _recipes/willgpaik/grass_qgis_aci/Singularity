BootStrap: shub
From: willgpaik/centos8_roar
%setup

%files

%environment
    # https://stackoverflow.com/a/25022770
    export PATH=$PATH:/opt/sw/grass/bin:/opt/sw/grass/grass78/bin:/opt/sw/grass/grass78/scripts
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/sw/grass/grass78/lib
    export GRASS_LD_LIBRARY_PATH=$GRASS_LD_LIBRARY_PATH
    export CPATH=$CPATH:/opt/sw/grass/grass78/include
    export PYTHONPATH=$PYTHONPATH:/opt/sw/grass/grass78/etc/python
    export GISBASE=/opt/sw/grass/grass78
    #export GISRC=$HOME/.grassrc7

%runscript


%post
    # commands to be executed inside container during bootstrap
    # add python and install some packages
    dnf update -y
    dnf install -y vte291-devel
    dnf install -y vte-profile
    dnf -y groups install "Development Tools"
    dnf -y groups install "Base"
    dnf -y install git cmake gcc-c++ gcc binutils \
	libX11-devel libXpm-devel libXft-devel libXext-devel
    dnf -y install gcc-gfortran openssl-devel pcre-devel \
	mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel mysql-devel \
	fftw-devel cfitsio-devel graphviz-devel \
	avahi-compat-libdns_sd-devel openldap \
	libxml2-devel gsl-devel
    dnf -y install openmpi-devel
    dnf -y install cmake3
    dnf -y install hdf5-devel
    dnf -y install patch
    dnf -y install git zlib-devel libtiff-devel
    # qgis dependencies: https://github.com/qgis/QGIS/blob/master/INSTALL.md#3-building-on-gnulinux
    dnf -y install proj-devel libspatialite-devel qwt-qt5-devel expat-devel qca-qt5-devel libzip-devel libzstd-devel sqlite-devel \
    	wxGTK3-devel libXmu-devel libX11-devel blas-devel netcdf netcdf-devel atlas-devel lapack-devel
    dnf -y install subversion
	
    # Then install GDAL from EPEL
    dnf -y install gdal gdal-libs gdal-python-tools python3-gdal gdal-devel
    
    # To fix issue with "libpq-fe.h not found" and "geos_c.h" not found
    dnf -y install postgresql-devel
    dnf -y install geos-devel
    
    ln -sf /usr/bin/python3.8 /usr/bin/python3
    ln -sf /usr/bin/pip3.8 /usr/bin/pip3
    
    pip3 install setuptools
    pip3 install numpy 
    pip3 install python-dateutil
    pip3 install pillow
    pip3 install matplotlib
    pip3 install six
    pip3 install GDAL==3.0.4
    
    # Required by GRASS 7.8.5
    dnf -y install python3-wxpython4 python38
    pip3 install wxPython svn
    

    # Install GRASS 7.8.5
    # First install these three dependencies:
    # https://copr.fedorainfracloud.org/coprs/neteler/python-matplotlib/
    #dnf -O /etc/yum.repos.d/python-matplotlib.repo https://copr.fedoraproject.org/coprs/neteler/python-matplotlib/repo/epel-7/neteler-python-matplotlib-epel-7.repo
    # install qhull dependency from EPEL7
    #dnf -y install qhull
    # now install this package
    #dnf -y install python-matplotlib
    # https://copr.fedorainfracloud.org/coprs/neteler/liblas/
    #dnf -y install liblas liblas-devel
    # https://copr.fedorainfracloud.org/coprs/neteler/laszip/
    #dnf -y install laszip-devel
    
    # Now install GRASS GIS 7:
    #wget -O /etc/yum.repos.d/grass78.repo https://copr.fedoraproject.org/coprs/neteler/grass78/repo/epel-7/neteler-grass78-epel-7.repo
    #dnf -y updategrass path <unknown> doesn't exist
    #dnf -y install grass grass-libs grass-gui liblas
    # needed for GRASS Addons (via g.extension)
    #dnf -y install grass-devel vblas-devel
    mkdir -p /opt/sw
    cd /opt/sw
    mkdir grass
    wget https://github.com/OSGeo/grass/archive/7.8.5.tar.gz
    tar -xf 7.8.5.tar.gz && rm 7.8.5.tar.gz
    cd grass-7.8.5
    ./configure --prefix=/opt/sw/grass --with-cxx --with-sqlite --with-python --with-geos \
    	--with-gdal=/usr/bin/gdal-config --with-cairo --with-cairo-ldflags=-lfontconfig \
	--with-freetype --with-freetype-includes=/usr/include/freetype2 \
	--with-proj --with-proj-share=/usr/share/proj --with-openmp --with-blas --with-lapack \
	--enable-largefile --with-wxwidgets=/usr/bin/wx-config --with-openmp \
	--with-fftw --with-netcdf --without-ffmpeg --without-mysql --without-postgres \
	--without-odbc --without-fftw
    make -j 2
    make install
    cd /opt/sw
    rm -rf grass-7.8.5
        
    
    
