Bootstrap: docker
From: utdemir/ghc-musl:v17-ghc884
Stage: base

%post
    set -eu
    export LC_ALL=C.UTF-8
    export CABAL_DIR=/usr/local/.cabal
    BUILD=0

    apk update
    apk add --no-cache \
        build-base linux-headers git pkgconfig \
        hdf5-dev hdf5-static
    # Fix pkg-config files
    ln -s /usr/lib/pkgconfig/hdf5-1.12.0.pc /usr/lib/pkgconfig/hdf5.pc
    ln -s /usr/lib/pkgconfig/hdf5_hl-1.12.0.pc /usr/lib/pkgconfig/hdf5_hl.pc
    cabal v2-update

    mkdir -p /project/hdf5-hs.local

    if [ $BUILD -eq 1 ]; then
        cd /project
        git clone --depth=1 https://github.com/twesterhout/hdf5-hs.git
        cd hdf5-hs/
        cabal v2-build --enable-executable-static
    fi

%environment
    export LC_ALL=C.UTF-8
    export CABAL_DIR=/usr/local/.cabal
    export TERM=xterm-256color
