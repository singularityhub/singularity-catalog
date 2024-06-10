BootStrap: docker
From: nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04


%runscript
  exec bash "$@"


%post
# Set up some required environment defaults
apt-get -y update && apt-get -y install software-properties-common && yes '' | add-apt-repository ppa:deadsnakes/ppa
apt-get -y update && apt-get -y install locales
locale-gen en_US.UTF-8
DEBIAN_FRONTEND=noninteractive apt-get -y install keyboard-configuration
apt-get -y update && apt-get -y install make \
					dpkg \
					wget \
					bzip2 \
					libglib2.0-0 \
					libxext6 \
					libsm6 \
					libxrender1 \
					g++ \
					gcc \
					xvfb \
					libyaml-cpp-dev \
					git \
					cmake \
					vim \
					curl \
					ca-certificates \
					python3.6 \
					python3.6-dev \
					gdb \
					libopenexr-dev \
					zlib1g-dev \
					xserver-xorg \
					freeglut3-dev \
					mesa-utils \
					libreadline-dev \
					gnuplot \
					gnuplot-qt \
					unzip \
					libboost-all-dev \
					libsdl2-dev \
					libssl-dev \
					libpng-dev \
                    build-essential


# Setup conda
cd /
wget "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" -O conda.sh
bash conda.sh -b -p /miniconda
rm conda.sh

# Setup FleX
cd /
wget http://mirrors.kernel.org/ubuntu/pool/main/g/glew/libglew1.10_1.10.0-3_amd64.deb
dpkg -i libglew1.10_1.10.0-3_amd64.deb
rm libglew1.10_1.10.0-3_amd64.deb

wget http://mirrors.kernel.org/ubuntu/pool/main/g/glew/libglew-dev_1.10.0-3_amd64.deb
dpkg -i libglew-dev_1.10.0-3_amd64.deb
rm libglew-dev_1.10.0-3_amd64.deb

if [ -d "/yaml-cpp"]; then
	echo "Found yaml-cpp"
else
	echo "installing yaml-cpp"
	cd /
	git clone https://github.com/jbeder/yaml-cpp.git
	cd yaml-cpp && mkdir build && cd build
	cmake ..
	make -j 8
	make install
	make clean
fi


# Setup Julia
wget https://julialang-s3.julialang.org/bin/linux/x64/1.5/julia-1.5.3-linux-x86_64.tar.gz
tar zxvf julia-1.5.3-linux-x86_64.tar.gz
rm julia-1.5.3-linux-x86_64.tar.gz
mv julia-1.5.3 /opt/julia-1.5.3
chown -R root:root /opt
ln -s /opt/julia-1.5.3/bin/julia /usr/bin/julia
chmod +x /usr/bin/julia


# Some update and cleanup
apt-get -y upgrade
apt-get clean


%environment
	export MKL_NUM_THREADS=12
	export NUMEXPR_NUM_THREADS=12
	export OMP_NUM_THREADS=12
	export OPENBLAS_NUM_THREADS=12
	export VECLIB_MAXIMUM_THREADS=12
	
	export PATH="/miniconda/bin:$PATH"
	export PATH="/usr/julia/bin:$PATH"
        export JULIA_VERSION="1.5.3"

