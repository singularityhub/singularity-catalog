bootstrap:docker
From:centos:7

%environment

PATH=/opt/Montage/bin:/usr/bin:/bin


%setup

mkdir -p $SINGULARITY_ROOTFS/opt/montage-workflow-v3
cp -a * $SINGULARITY_ROOTFS/opt/montage-workflow-v3/
rm -rf $SINGULARITY_ROOTFS/opt/montage-workflow-v3/data


%post

yum -y upgrade
yum -y install epel-release yum-plugin-priorities

# osg repo
yum -y install http://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm

# pegasus repo
echo -e "# Pegasus\n[Pegasus]\nname=Pegasus\nbaseurl=http://download.pegasus.isi.edu/wms/download/rhel/7/\$basearch/\ngpgcheck=0\nenabled=1\npriority=50" >/etc/yum.repos.d/pegasus.repo

yum -y install \
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
    python36-pika \
    python36-PyYAML \
    python3-devel \
    python3-future \
    python3-pip \
    unzip \
    wget

# want astropy in the python3 install as that is what we use for Pegasus API
pip3 install astropy

# pegasus 5.0
rpm -Uvh https://download.pegasus.isi.edu/pegasus/5.0.0dev/pegasus-5.0.0dev-1.el7.x86_64.rpm

# Cleaning caches to reduce size of image
yum clean all

cd /opt && \
    wget -nv http://montage.ipac.caltech.edu/download/Montage_v6.0.tar.gz && \
    tar xzf Montage_v6.0.tar.gz && \
    rm -f Montage_v6.0.tar.gz && \
    cd Montage && \
    make

