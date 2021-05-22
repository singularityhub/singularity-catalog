bootstrap: docker
From:      fedora:latest

%post

yum upgrade -y

yum groupinstall -y \
    "Development Tools" \
    "Development Libraries"

yum install -y \
    curl \
    gcc-gfortran \
    pkg-config \
    python2 \
    python2-astropy \
    python2-devel \
    unzip \
    vim \
    wget

yum clean all

cd /opt && \
    wget -nv https://github.com/Caltech-IPAC/Montage/archive/dev.zip && \
    unzip dev.zip && \
    rm -f dev.zip && \
    mv Montage-dev Montage && \
    cd Montage && \
    make

