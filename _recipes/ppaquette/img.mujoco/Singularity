Bootstrap: docker
From: ubuntu:16.04

%runscript
export REPO="$1"
export BRANCH="$2"
shift 2

echo "----------------------------"
echo "REPO: $REPO"
echo "BRANCH: $BRANCH"
echo "COMMAND: $@"
echo "----------------------------"

# Making sure we have a Mujoco license key
mkdir -p $HOME/.mujoco
if [ -f "$HOME/.mujoco/mjkey.txt" ]; then
    echo "OK... Mujuco key detected at $HOME/.mujoco/mjkey.txt"
else
	echo "ERROR... Mujoco key missing. Should be here: $HOME/.mujoco/mjkey.txt"
	exit 1
fi

# Creating links to container Mujoco installation
if [ -d "$HOME/.mujoco/mjpro150" ]; then 
	if [ -L "$HOME/.mujoco/mjpro150" ]; then
		# Symlink, we can remove
		rm "$HOME/.mujoco/mjpro150"
	else
		echo "ERROR... Conflicting Mujoco installation detected at $HOME/.mujoco/mjpro150"
		echo "Please rename or remove that directory and retry."
		exit 1
	fi
fi
rm -f "$HOME/.mujoco/mjpro150"
ln -s /work_dir/deps/mujoco/mjpro150 $HOME/.mujoco/mjpro150

# 1. Cloning repo
cd /work_dir
rm -Rf repo/
git clone --recurse-submodules $REPO repo
cd repo

# 2. Checking out branch
git checkout $BRANCH

# 3. Installing requirements.
if [ -f "requirements.txt" ]; then
	pip install -r requirements.txt
fi
if [ -f "setup.py" ]; then
	pip install -e .
fi

# 3. Running command (through entry point)
/work_dir/entry.sh "$@"

%environment
export HOME="${HOME:-/work_dir}"
export CUDA_HOME=/usr/local/cuda
export CUDA_ROOT=$CUDA_HOME
export LD_LIBRARY_PATH=/work_dir/deps/mujoco/mjpro150/bin:/usr/local/nvidia/lib64:$CUDA_HOME/lib64:$CUDA_HOME/extras/CUPTI/lib64:/usr/local/lib:/usr/lib64:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.mujoco/mjpro150/bin
export PATH=/work_dir/env/bin:$PATH
export PYTHONIOENCODING=utf-8
export LANG=en_CA.UTF-8
export PYTHONUNBUFFERED=1
export PYTHONPATH=/work_dir/repo:$PYTHONPATH

%labels
AUTHOR pcpaquette@gmail.com

%post
export DEBIAN_FRONTEND=noninteractive
export LANG=C.UTF-8
export LD_LIBRARY_PATH=/work_dir/deps/mujoco/mjpro150/bin:/usr/local/nvidia/lib64:$CUDA_HOME/lib64:$CUDA_HOME/extras/CUPTI/lib64:/usr/local/lib:/usr/lib64:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.mujoco/mjpro150/bin

# --- Creating empty mount points ---
mkdir -p /scratch /home /u /data /Tmp /project /work_dir /cvmfs /localscratch

# --- Installing utilities ---
apt-get -y update
apt-get -y install git wget curl nano vim emacs locales pkg-config software-properties-common zip net-tools unzip virtualenv
mkdir -p /etc/pki/tls
ln -s /etc/ssl/certs /etc/pki/tls/certs

# --- Install CUDA 9.0.176 ---
wget -nv http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
dpkg -i cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
apt-get -y update
apt-get install -y cuda-toolkit-9-0
rm cuda-repo-ubuntu1604_9.0.176-1_amd64.deb

# --- Installing cuDNN 7.0.5 ---
wget -nv https://storage.googleapis.com/ppaquette-diplomacy/files/cudnn/cudnn-9.0-linux-x64-v7.tgz
tar -xzf cudnn-9.0-linux-x64-v7.tgz
cp cuda/include/cudnn.h /usr/local/cuda/include
cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
rm -Rf cuda/
rm cudnn-9.0-linux-x64-v7.tgz

# --- Installing Python 3.6 ---
wget -nv https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash ./miniconda.sh -b -p /work_dir/env
export PATH="/work_dir/env/bin:$PATH"
rm miniconda.sh

# --- Installing mujoco 1.50 ---
apt-get -y install libgl1-mesa-dev libgl1-mesa-glx libosmesa6-dev xpra xserver-xorg-dev
mkdir -p /work_dir/deps/mujoco
cd /work_dir/deps
wget https://www.roboti.us/download/mjpro150_linux.zip -O mujoco.zip
unzip mujoco.zip -d /work_dir/deps/mujoco
rm mujoco.zip
wget -nv https://raw.githubusercontent.com/openai/mujoco-py/c5f60322467ec8ecc0db64c3e18a4da762c27e45/vendor/Xdummy -O /usr/local/bin/Xdummy
chmod +x /usr/local/bin/Xdummy
mkdir -p /usr/share/glvnd/egl_vendor.d/
wget -nv https://raw.githubusercontent.com/openai/mujoco-py/c5f60322467ec8ecc0db64c3e18a4da762c27e45/vendor/10_nvidia.json -O /usr/share/glvnd/egl_vendor.d/10_nvidia.json
cd /work_dir/deps/mujoco/mjpro150/bin
cp *.so /usr/local/lib/
cd /work_dir

# --- Installing PatchELF ---
wget -nv https://nixos.org/releases/patchelf/patchelf-0.9/patchelf-0.9.tar.gz
tar -xzf patchelf-0.9.tar.gz
cd patchelf-0.9/
./configure
make
make install
cd ..
rm -Rf patchelf-0.9/
rm patchelf-0.9.tar.gz

# --- Installing GLFW ---
apt-get install -y cmake xorg-dev libglu1-mesa-dev xvfb
cd /work_dir/deps
git clone https://github.com/glfw/glfw.git
cd glfw
git checkout 8d3595fb4d4d919e27e1a755095ae1ffae5f50be
cmake -DBUILD_SHARED_LIBS=ON .
make
make install

# --- Installing mujoco-py ---
cd /work_dir/deps
git clone https://github.com/openai/mujoco-py.git
cd mujoco-py
pip install -r requirements.txt
python setup.py build install
cd ..

# --- Installing control-suite ---
cd /work_dir/deps
git clone https://github.com/deepmind/dm_control.git
cd dm_control
pip install -r requirements.txt
python setup.py install --headers-dir=/work_dir/deps/mujoco/mjpro150/include/
cd ..

# --- Installing entry point ---
cd /work_dir
cat <<EOT > /work_dir/entry.sh
#!/usr/bin/python
import argparse
import os
import sys
import subprocess

parser = argparse.ArgumentParser()
args, extra_args = parser.parse_known_args()
subprocess.Popen(["nohup", "Xdummy", ":15"], stdout=open('/dev/null', 'w'), stderr=open('/dev/null', 'w'))
os.environ['DISPLAY'] = ':15'
if not extra_args:
    sys.argv = ['/bin/bash']
else:
    sys.argv = extra_args
# Explicitly flush right before the exec since otherwise things might get
# lost in Python's buffers around stdout/stderr (!).
sys.stdout.flush()
sys.stderr.flush()
os.execvpe(sys.argv[0], sys.argv, os.environ)
EOT
chmod +x /work_dir/entry.sh

# --- Cleaning up ---
chmod -R 777 /work_dir
apt-get -y clean
rm -rf /var/lib/apt/lists/*
