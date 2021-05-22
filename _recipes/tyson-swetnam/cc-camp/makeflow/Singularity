BootStrap: debootstrap
OSVersion: xenial
MirrorURL: http://us.archive.ubuntu.com/ubuntu/

%setup
    # copy demo example script. source: http://ccl.cse.nd.edu/software/manuals/makeflow.html  
    cp makeflow.example $SINGULARITY_ROOTFS/tmp/
    
%post
    echo "deb http://us.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse" >/etc/apt/sources.list
    export PATH=/opt/cctools/bin:$PATH
    
apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        ccache \
        checkinstall \
        cmake \
        curl \
        ffmpeg2theora \
        flex \
        g++ \
        gcc \
        imagemagick \
        libffmpegthumbnailer-dev \
        libgcc1 \
        python3 \
        unzip \
        vim \
        wget \
        zlib1g-dev

    # Build CCTools
    cd /tmp && \
       wget -nv http://ccl.cse.nd.edu/software/files/cctools-6.2.4-source.tar.gz && \
       tar xzf cctools-6.2.4-source.tar.gz && \
       cd cctools-6.2.4-source && \
       ./configure --prefix=/opt/cctools && \
       make && \
       make install

    rm -rf /tmp/build-dir /tmp/cctools*
    
# build info
    echo "Timestamp:" `date --utc` | tee /image-build-info.txt

%labels
Maintainer Tyson L Swetnam
Version v0.1
