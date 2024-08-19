BootStrap: docker
From: debian:12

%post
# non interactive debian
apt-get update &&  \
DEBIAN_FRONTEND=noninteractive \
apt-get -y upgrade && \
DEBIAN_FRONTEND=noninteractive \
apt-get -y install \
	bash \
	bsdextrautils \
	curl \
	dbus-bin \
	file \
	libcairo2 \
	libfreetype6 \
	libgl1 \
	libglib2.0 \
	libglu1-mesa \
	libgl1-mesa-dri \
	libice6 \
	libsm6 \
	libxrender1 \
	libxss1 \
	ncurses-bin \
	procps \
	rsync \
	tcsh \
	wget \
\
cmake \
default-jdk \
git \
libfftw3-dev \
libhdf5-dev \
libjpeg-dev \
libopenmpi-dev \
libsqlite3-dev \
libtiff5-dev \
python3-dev \
python3-numpy \
libgsl-dev \
\
libglvnd-dev \
libx11-dev \
libxft-dev \
libxkbcommon-dev \
libxkbcommon-x11-dev \
libzstd-dev \
libhdf5-openmpi-dev \
libopenmpi-dev \
\
libgsl-dev \
libparpack2-dev libarpack2-dev \
\
	automake \
	bison \
	bzip2 \
	build-essential \
	environment-modules \
	file \
	flex \
	ghostscript \
	libpng-dev \
	libtiff-dev \
	make \
	pciutils \
	rsync \
	tar \
	tcsh \
	unzip \
	wget \
	which \
\
xorg \
xorg-dev \
	&& \
dbus-uuidgen > /etc/machine-id


mkdir -p /local/scratch/tmp # for maestro $TMPDIR

# update and requirements for miniconda
curl -qsSLkO  https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb && \
dpkg -i cuda-keyring_1.1-1_all.deb && \
rm cuda-keyring_1.1-1_all.deb && \
apt-get update && \
apt-get -y install \
	cuda-minimal-build-12-3 \
	libcufft-dev-12-3 \
	libcurand-dev-12-3 \
	cuda-nvtx-12-3 \
	libcublas-dev-12-3 \
	cuda-nvml-dev-12-3 \
	&& \
DEBIAN_FRONTEND=noninteractive \
apt-get -y autoremove && \
wget \
http://security.debian.org/debian-security/pool/updates/main/t/tiff/libtiff5_4.1.0+git191117-2~deb10u9_amd64.deb \
http://security.debian.org/debian-security/pool/updates/main/libw/libwebp/libwebp6_0.6.1-2+deb10u3_amd64.deb && \
apt-get install ./libtiff5_4.1.0+git191117-2~deb10u9_amd64.deb ./libwebp6_0.6.1-2+deb10u3_amd64.deb \
&& \
DEBIAN_FRONTEND=noninteractive \
apt-get -y clean all \

# install miniconda
#
cat <<EOF > /00_install_miniconda_scipion-installer.sh
#/bin/bash
curl -qsSLkO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
&& bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3 \
&& rm Miniconda3-latest-Linux-x86_64.sh
/opt/miniconda3/bin/conda update conda --yes && /opt/miniconda3/bin/conda update --all --yes

PATH=/opt/miniconda3/bin:/usr/local/bin:\$PATH
export PATH

unset module || :
. /etc/profile.d/modules.sh

conda update --yes -n base -c defaults conda && \
conda update --yes --all
bash -c 'eval "\$(conda shell.bash hook)" && \
conda activate && \
python3 -m pip install scipion-installer scons'

# cleanup
conda clean --all --yes
EOF
chmod 755 /00_install_miniconda_scipion-installer.sh

%environment
#PATH=/usr/local/cuda/bin:/opt/scipion:/opt/miniconda3/bin:/usr/local/bin:$PATH
PATH=/usr/local/cuda/bin:/opt/miniconda3/bin:/usr/local/bin:$PATH
export PATH

%runscript 
#!/bin/bash
#PATH=/usr/local/cuda/bin:/opt/miniconda3/bin:/usr/local/bin:$PATH
PATH=/usr/local/cuda/bin:/opt/scipion:/opt/miniconda3/bin:/usr/local/bin:$PATH
unset module || :
. /etc/profile.d/modules.sh
[ -f /opt/miniconda3/bin/conda ] && \
	eval "$(/opt/miniconda3/bin/conda shell.bash hook)" && echo "conda initialised" 
[ -d /opt/miniconda3/envs/scipion3/ ]  && [ -d /opt/scipion/software/em/ ] && \
	conda activate scipion3 && echo "scipion3 environment activated" && \
	eval "$@"
