# Provides OpenBLAS built with OpenMP support
Bootstrap: docker
From: alpine:3.13.0
Stage: build_openblas

%post
    set -eu
    export LC_ALL=C.UTF-8
    export OPENBLAS_VERSION=0.3.13

    apk update
    apk add --no-cache bash perl gfortran build-base linux-headers tar wget

    mkdir -p /project/openblas.local
    mkdir -p /project/openblas
    cd /project/openblas
    wget -q "https://github.com/xianyi/OpenBLAS/archive/v${OPENBLAS_VERSION}.tar.gz"
    tar xf "v${OPENBLAS_VERSION}.tar.gz"
    cd "OpenBLAS-${OPENBLAS_VERSION}"
    make ARCH=amd64 BINARY=64 INTERFACE64=1 \
         USE_THREAD=1 USE_OPENMP=1 NUM_THREADS=128 \
         NO_AFFINITY=1 NO_LAPACKE=1 \
         TARGET=NEHALEM DYNAMIC_ARCH=1 \
         GEMM_MULTITHREADING_THRESHOLD=50

    make PREFIX=/usr install
    cat >/usr/lib/pkgconfig/blas64.pc <<-___HERE
	prefix=/usr
	libdir=\${prefix}/lib
	includedir=\${prefix}/include
	Name: openblas-blas
	Description: Optimized BLAS (linear algebra) library based on GotoBLAS2
	Version: ${OPENBLAS_VERSION}
	URL: https://github.com/xianyi/OpenBLAS
	Libs: -L\${libdir} -lopenblas
	Libs.private: -lgfortran -lgomp -lm -lpthread
	Cflags: -I\${includedir}
	___HERE
    cat >/usr/lib/pkgconfig/lapack64.pc <<-___HERE
	prefix=/usr
	libdir=\${prefix}/lib
	includedir=\${prefix}/include
	Name: openblas-lapack
	Description: Optimized BLAS (linear algebra) library, LAPACK
	Version: ${OPENBLAS_VERSION}
	URL: https://github.com/xianyi/OpenBLAS
	Libs: -L\${libdir} -lopenblas
	Libs.private: -lgfortran -lgomp -lm -lpthread
	Cflags: -I\${includedir}
	___HERE


Bootstrap: docker
From: alpine:3.13.0
Stage: final

%files from build_openblas
    /usr/lib/libopenblas*          /usr/lib/
    /usr/include/cblas.h           /usr/include/
    /usr/include/f77blas.h         /usr/include/
    /usr/include/lapack.h          /usr/include/
    /usr/include/openblas_config.h /usr/include/
    /usr/lib/cmake/openblas        /usr/lib/cmake/
    /usr/lib/pkgconfig/openblas.pc /usr/lib/pkgconfig/openblas.pc
    /usr/lib/pkgconfig/blas.pc     /usr/lib/pkgconfig/blas.pc
    /usr/lib/pkgconfig/lapack.pc   /usr/lib/pkgconfig/lapack.pc

%post
    set -eu
    apk update
    apk add --no-cache libgomp libgfortran
