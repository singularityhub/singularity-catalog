Bootstrap: shub
From: pndni/centos7-base:1.1.1
# OSVersion: 7
# MirrorURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/os/x86_64/
# Include: yum

%post
    tmpdir=$(mktemp -d)
    pushd $tmpdir
    git clone --recursive --branch release-1.9.17 https://github.com/BIC-MNI/minc-toolkit-v2.git minc-toolkit-v2_src
    mkdir minc_build
    pushd minc_build
    /opt/cmake/bin/cmake ../minc-toolkit-v2_src \
    -DCMAKE_BUILD_TYPE:STRING=Release \
    -DCMAKE_INSTALL_PREFIX:PATH=/opt/minc \
    -DMT_BUILD_ABC:BOOL=OFF \
    -DMT_BUILD_ANTS:BOOL=OFF \
    -DMT_BUILD_C3D:BOOL=OFF \
    -DMT_BUILD_ELASTIX:BOOL=OFF \
    -DMT_BUILD_IM:BOOL=OFF \
    -DMT_BUILD_ITK_TOOLS:BOOL=OFF \
    -DMT_BUILD_LITE:BOOL=OFF \
    -DMT_BUILD_OPENBLAS:BOOL=ON \
    -DMT_BUILD_QUIET:BOOL=OFF \
    -DMT_BUILD_SHARED_LIBS:BOOL=OFF \
    -DMT_BUILD_VISUAL_TOOLS:BOOL=OFF \
    -DMT_USE_OPENMP:BOOL=ON \
    -DUSE_SYSTEM_FFTW3D:BOOL=OFF \
    -DUSE_SYSTEM_FFTW3F:BOOL=OFF \
    -DUSE_SYSTEM_GLUT:BOOL=OFF \
    -DUSE_SYSTEM_GSL:BOOL=OFF \
    -DUSE_SYSTEM_HDF5:BOOL=OFF \
    -DUSE_SYSTEM_ITK:BOOL=OFF \
    -DUSE_SYSTEM_NETCDF:BOOL=OFF \
    -DUSE_SYSTEM_NIFTI:BOOL=OFF \
    -DUSE_SYSTEM_PCRE:BOOL=OFF \
    -DUSE_SYSTEM_ZLIB:BOOL=OFF \
    -DBUILD_TESTING=OFF
    make
    make test
    make install
    popd  # minc_build
    rm -rf minc_build
    rm -rf minc-toolkit-v2_src
    popd  # $tmpdir

%appenv minc
    # from minc-toolkit-config.sh
    # dropped LD_LIBRARY_PATH because everything should be
    # statically linked (running "for i in `ls`; do ldd $i | grep -i minc; done" in bin
    # yielded no results, confirming this)
    export MINC_TOOLKIT=/opt/minc
    export MINC_TOOLKIT_VERSION="1.9.17-20190313"
    export PATH=${MINC_TOOLKIT}/bin:${MINC_TOOLKIT}/pipeline:${PATH}
    export PERL5LIB=${MINC_TOOLKIT}/perl:${MINC_TOOLKIT}/pipeline:${PERL5LIB}
    # export LD_LIBRARY_PATH=${MINC_TOOLKIT}/lib:${MINC_TOOLKIT}/lib/InsightToolkit:${LD_LIBRARY_PATH}
    export MNI_DATAPATH=${MINC_TOOLKIT}/../share
    export MINC_FORCE_V2=1
    export MINC_COMPRESS=4
    export VOLUME_CACHE_THRESHOLD=-1

%labels
    Maintainer Steven Tilley
    Version dev

%applabels minc
    URL https://www.mcgill.ca/bic/software/minc

%apphelp minc
    Be sure to check licensing information at 
    https://www.mcgill.ca/bic/software/minc
    By using this software you agree to the minc
    license and the licenses of included packages

