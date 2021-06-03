bootstrap:docker
From:debian:9

%environment

PATH=/opt/Montage/bin:/usr/bin:/bin


%setup

mkdir $SINGULARITY_ROOTFS/opt/montage-workflow-v2
cp -a * $SINGULARITY_ROOTFS/opt/montage-workflow-v2/


%post

apt-get update && apt-get install -y \
        build-essential \
        curl \
        gfortran \
        gnupg \
        libmariadbclient18 \
        libpq5 \
        locales \
        locales-all \
        openjdk-8-jre \
        pkg-config \
        python \
        python-astropy \
        python-future \
        python-dev \
        python-pip \
        unzip \
        vim \
        wget

# pegasus
wget -O - http://download.pegasus.isi.edu/pegasus/gpg.txt | apt-key add -
echo 'deb http://download.pegasus.isi.edu/wms/download/debian stretch main' >/etc/apt/sources.list.d/pegasus.list
apt-get update && apt-get install -y \
    pegasus

apt-get clean
rm -rf /var/lib/apt/lists/*

# wget -nv http://montage.ipac.caltech.edu/download/Montage_v5.0.tar.gz 
cd /opt && \
    wget -nv https://github.com/Caltech-IPAC/Montage/archive/dev.zip && \
    unzip dev.zip && \
    rm -f dev.zip && \
    mv Montage-dev Montage && \
    cd Montage && \
    make

