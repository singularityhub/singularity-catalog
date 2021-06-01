BootStrap: debootstrap
OSVersion: stable
MirrorURL: https://snapshot.debian.org/archive/debian/20180423T161605Z

%labels 
Maintainer Moritz Lell

%environment
LC_ALL="en_US.UTF-8"
PATH="/opt/tapas/scripts:$PATH"
export LC_ALL PATH

%post

apt-get update
apt-get install -y --no-install-recommends locales

# Configure default locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen en_US.utf8
/usr/sbin/update-locale LANG=en_US.UTF-8

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# bsdmainutils: For column command
# curl:         For downloading TAPAS
# pandoc, samtools: For creating the manual  
apt-get install --no-install-recommends -y r-base r-base-dev \
  python3 python3-dev python3-pip python3-wheel python3-setuptools \
  bsdmainutils pandoc samtools curl

update-alternatives --install /usr/bin/python python /usr/bin/python3.5 1
update-alternatives --install /usr/bin/pip    pip /usr/bin/pip3 1

# Remove package cache
rm -rf /var/lib/apt/lists/*

cd /opt
curl -L https://github.com/mlell/tapas/archive/refs/heads/master.zip > tapas.zip
unzip tapas.zip
rm tapas.zip
mv tapas-master tapas

cd tapas/scripts/gen
./install_dependencies



