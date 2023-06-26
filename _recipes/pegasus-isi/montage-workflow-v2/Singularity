bootstrap:docker
From:centos:7

%environment

PATH=/opt/Montage/bin:/usr/bin:/bin


%setup

mkdir $SINGULARITY_ROOTFS/opt/montage-workflow-v2
cp -a * $SINGULARITY_ROOTFS/opt/montage-workflow-v2/


%post

yum -y upgrade
yum -y install epel-release yum-plugin-priorities

# osg repo
yum -y install http://repo.opensciencegrid.org/osg/3.4/osg-3.4-el7-release-latest.rpm

# pegasus repo
echo -e "# Pegasus\n[Pegasus]\nname=Pegasus\nbaseurl=http://download.pegasus.isi.edu/wms/download/rhel/7/\$basearch/\ngpgcheck=0\nenabled=1\npriority=50" >/etc/yum.repos.d/pegasus.repo

yum -y install \
    astropy-tools \
    file \
    gcc \
    gcc-gfortran \
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-devel \
    libjpeg-turbo-devel \
    openjpeg-devel \
    osg-ca-certs \
    osg-wn-client \
    pegasus \
    python-astropy \
    python-devel \
    python-future \
    python-pip \
    unzip \
    wget

# Cleaning caches to reduce size of image
yum clean all

cd /opt && \
    wget -nv http://montage.ipac.caltech.edu/download/Montage_v6.0.tar.gz && \
    tar -zxvf Montage_v6.0.tar.gz && \
    rm -f Montage_v6.0.tar.gz && \
    cd Montage && \
    make
