Bootstrap: docker
From: ubuntu:20.04
Stage: build

%post -c /bin/bash
    set -e
    export LC_ALL=C
    export PRIMME_VERSION=3.1.1

    apt-get update
    apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
        gcc \
        gfortran \
        g++ \
        make \
        pkg-config \
        libopenblas64-openmp-dev \
        python3-minimal

    mkdir /workdir && cd /workdir
    wget "https://github.com/primme/primme/archive/v${PRIMME_VERSION}.tar.gz"
    tar xf "v${PRIMME_VERSION}.tar.gz"
    cd "primme-${PRIMME_VERSION}"

    export CC=gcc CFLAGS="-O3 -march=nocona -mtune=ivybridge -fPIC -DNDEBUG -DPRIMME_BLASINT_SIZE=64 -DPRIMME_INT_SIZE=64"
    export FFLAGS="-fno-second-underscore -O3 -march=nocona -mtune=ivybridge"
    export LDFLAGS="-Wl,-z,defs -llapack64 -lblas64 -lm"
    export PRIMME_WITH_HALF=no PRIMME_WITH_FLOAT=yes
    export PREFIX="/opt/primme"
    make lib solib -j8
    LIBS="$LDFLAGS" make test
    make install
    cp "lib/libprimme.a" "${PREFIX}/lib"

    mkdir -p "${PREFIX}/lib/pkgconfig"
    cat >"${PREFIX}/lib/pkgconfig/primme.pc" <<-EOF
        prefix=${PREFIX}
EOF
    cat >>"${PREFIX}/lib/pkgconfig/primme.pc" <<-'EOF'
        includedir=${prefix}/include
        libdir=${prefix}/lib

        Name: primme
        Description: PRIMME: PReconditioned Iterative MultiMethod Eigensolver
        URL: https://github.com/primme/primme
EOF
    cat >>"${PREFIX}/lib/pkgconfig/primme.pc" <<-EOF
        Version: ${PRIMME_VERSION}
EOF
    cat >>"${PREFIX}/lib/pkgconfig/primme.pc" <<-'EOF'
        Cflags: -I${includedir} -DPRIMME_INT_SIZE=64
        Libs: -L${libdir} -lprimme -Wl,-rpath=${libdir}
EOF


Bootstrap: docker
From: ubuntu:20.04
Stage: run

%files from build
    /opt/primme/include/* /usr/local/include/
    /opt/primme/lib/libprimme.a /usr/local/lib/
    /opt/primme/lib/libprimme.so.3.1 /usr/local/lib/

%post -c /bin/bash
    set -e

    cd /usr/local/lib
    ln --symbolic libprimme.so.3.1 libprimme.so.3
    ln --symbolic libprimme.so.3.1 libprimme.so

    apt-get update
    apt-get install -y --no-install-recommends libopenblas64-0-openmp
    apt-get clean && apt-get autoclean
    rm -rf /var/lib/apt/lists/*
