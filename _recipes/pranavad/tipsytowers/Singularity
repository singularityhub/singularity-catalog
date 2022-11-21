bootstrap:docker
From: nvidia/cudagl:11.4.2-devel-ubuntu20.04


%environment
export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib
export PATH="/poetry/bin:$PATH"
export DEBIAN_FRONTEND=noninteractive

%runscript
exec bash "$*"


%post
# Set up some required environment defaults
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get -y install build-essential
apt-get -y --force-yes install vim
apt-get -y update
apt-get -y install wget \
                   dpkg \
                   cmake  \
                   git  \
                   curl \
                   gdb \
                   libopencv-dev \
                   libgtk2.0-dev  \
                   pkg-config  \
                   libavcodec-dev  \
                   libavformat-dev  \
                   libswscale-dev  \
                   gnuplot  \
                   liblapack-dev  \
                   libf2c2-dev  \
                   coreutils  \
                   libglew-dev  \
                   libann-dev  \
                   libqhull-dev  \
                   libx11-dev  \
                   libxi-dev  \
                   libxmu-dev  \
                   libgraphviz-dev  \
                   unzip \
                   libgl1-mesa-dri \
                   libstdc++6 \
                   libglu1-mesa \
                   libglu1-mesa-dev \
                   mesa-utils \
                   libgl1-mesa-glx \
                   freeglut3 \
                   freeglut3-dev \
                   python3.8 \
                   python3.8-venv \
                   python3-dev \
                   libpython3.8-dev \
                   glew-utils


apt-get clean

# sort out the libGLEW issue for Ubuntu 20.04
ln -f -s /usr/lib/x86_64-linux-gnu/libGLEW.so.2.1 /usr/lib/libGLEW.so.1.13

update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1


# set up poetry (package manager for python)
export POETRY_HOME=/poetry
curl -sSL https://install.python-poetry.org | python
chmod +x /poetry/bin/*


# Some update and cleanup
apt-get -y upgrade
apt-get clean

