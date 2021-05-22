# Spack container (https://github.com/spack/spack)
#    Set the user argument 'package' to specify the Spack package to
#    install.  Otherwise, it will just build a base Spack container
#    image.
# 
#    Sample workflow:
# $ hpccm.py --recipe recipes/spack.py --userarg package="gromacs@2018.2 +cuda" > Dockerfile.gromacs.spack
# $ docker build -t gromacs.spack -f Dockerfile.gromacs.spack .
# $ nvidia-docker run --rm -ti gromacs.spack bash -l
# container:/> spack load gromacs
# 

BootStrap: docker
From: nvidia/cuda:10.2-devel-centos7
%post
    . /.singularity.d/env/10-docker*.sh
    mkdir -p $SINGULARITY_ROOTFS/local_tmp
    chmod 777 -R $SINGULARITY_ROOTFS/local_tmp
    export TMPDIR=$SINGULARITY_ROOTFS/local_tmp
    export TMP=$SINGULARITY_ROOTFS/local_tmp
# Python
%post
    yum install -y \
        python2 \
        python3
    rm -rf /var/cache/yum/*

# GNU compiler
%post
    yum install -y \
        gcc \
        gcc-c++ \
        gcc-gfortran
    rm -rf /var/cache/yum/*

%post
    yum install -y \
        autoconf \
        build-essential \
        bzip2 \
        ca-certificates \
        coreutils \
        curl \
        environment-modules \
        git \
        gzip \
        libssl-dev \
        make \
        openssh-client \
        patch \
        pkg-config \
        tar \
        tcl \
        unzip \
        zlib1g
    rm -rf /var/cache/yum/*

%post
    cd /
    mkdir -p /opt && cd /opt && git clone --depth=1 --branch v0.16.1 https://github.com/spack/spack spack && cd -
    ln -s /opt/spack/share/spack/setup-env.sh /etc/profile.d/spack.sh
    ln -s /opt/spack/share/spack/spack-completion.bash /etc/profile.d

%environment
    export FORCE_UNSAFE_CONFIGURE=1
    export PATH=/opt/spack/bin:$PATH
%post
    export FORCE_UNSAFE_CONFIGURE=1
    export PATH=/opt/spack/bin:$PATH

%post
    cd /
    spack install gcc@8.3.0  
    spack compiler find 
    spack install cuda@10.2.89 %gcc8.3.0 
    spack install openmpi@4.0.2%gcc@8.3.0+cuda ^cuda@10.2.89
    spack clean --all


