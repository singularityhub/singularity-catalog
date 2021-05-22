Bootstrap: docker
From: nvidia/cuda:9.2-cudnn7-runtime-ubuntu18.04

%environment

PATH=/opt/conda/bin:$PATH
export PATH

%post
  
# Set up the PATH for other commands
export PATH=/opt/conda/bin:$PATH

# Update list of packages then upgrade them
apt-get update
apt-get install -y apt-utils 
DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
    
# Install dependencies
apt-get install -y --no-install-recommends build-essential cmake git curl vim \
    ca-certificates libjpeg-dev libpng-dev
apt-get install -y screen terminator tmux vim wget 
apt-get install -y aptitude build-essential cmake g++ gfortran git pkg-config software-properties-common
apt-get install -y unrar

# More dependencies/useful software from system package manager
apt-get install -v libopenblas-dev libfreetype7-dev libpng12-dev \
    libglib2.0-0 libsm6 libxext6 libxrender1
    
# Caffe dependencies  
apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev \
    libhdf5-serial-dev protobuf-compiler
apt-get install --no-install-recommends -y libboost-all-dev
apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev

# Theano dependencies not already installed
apt-get install -y python-pygments python-sphinx 

# Dense Flow dependencies
apt-get install -y libzip-dev

# OpenCV build dependencies not already installed  
apt-get install -y checkinstall yasm libjpeg-dev libjpeg8-dev \
    libavcodec-dev libavformat-dev libswscale-dev \
    libdc1394-22-dev \
    libv4l-dev python-dev python-numpy \
    libtbb-dev libqt4-dev libgtk2.0-dev libfaac-dev libmp3lame-dev \
    libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev \
    libxvidcore-dev x264 v4l-utils libgtk-3-dev
    
# Add PPA for ffmpeg
add-apt-repository -y ppa:jonathonf/ffmpeg-4
apt-get update
apt-get install -y ffmpeg

# More utilities
apt-get install -y graphviz libfreetype6 libfreetype6-dev \
    libgraphviz-dev liblapack-dev swig libxft-dev libxml2-dev \
    libxslt-dev zlib1g-dev
 
# Gnuplot
apt-get install -y gnuplot-x11
    
# Clean up
apt-get -y autoremove
rm -rvf /var/lib/apt/lists/*

# Install miniconda
cd /opt
curl -o /opt/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x /opt/miniconda.sh
/opt/miniconda.sh -b -p /opt/conda 
rm /opt/miniconda.sh

# Install some packages
conda install numpy pyyaml scipy ipython mkl mkl-include
conda install -c soumith magma-cuda90
conda clean -ya

# Install the released version of Pytorch.
conda install torchvision cuda90 -c pytorch
conda install -c pytorch pytorch 

# PIL (actually Pillow)
pip install --no-cache-dir Pillow
    
# Jupyter and jupyterlab
pip install --no-cache-dir jupyter
pip install --no-cache-dir jupyterlab

# Various useful Python packages
pip install --no-cache-dir pygraphviz
pip install --no-cache-dir networkx
pip install --no-cache-dir numexpr
# Not working as of 2018-12-01
#pip install --no-cache-dir pymc
pip install --no-cache-dir patsy
pip install --no-cache-dir Cython
pip install --no-cache-dir statsmodels
pip install --no-cache-dir restview
pip install --no-cache-dir tinkerer
pip install --no-cache-dir Pweave
pip install --no-cache-dir numba

# TensorFlow, from conda instead of pip (pip is not working for it right now)
conda install -y -c anaconda tensorflow-gpu=1.9
#pip install --no-cache-dir tensorflow-gpu==1.8
    
# Deep Mind Sonnet
pip install --no-cache-dir dm-sonnet-gpu==1.17

# Theano
pip install --no-cache-dir Theano==1.0.1

# Keras
pip install --no-cache-dir keras==2.2.4
    
# OpenCV from pip, including contrib.  This makes the install MUCH faster.
# See https://pypi.python.org/pypi/opencv-contrib-python for capabilities 
# and limitations.  
pip install --no-cache-dir opencv-contrib-python    

#Keras ml package
pip install --no-cache-dir keras_vggface
    
#For keras generator
pip install --no-cache-dir bcolz
    
#Neuro-Imaging package
pip install --no-cache-dir nibabel
pip install --no-cache-dir niftynet
pip install --no-cache-dir SimpleITK
    
#Parallel Processing
pip install --no-cache-dir joblib
    
#Progess
pip install --no-cache-dir tqdm
    
#Sklearn update
pip install --no-cache-dir scikit-learn==0.19.2

# For integration with JupyterHub
pip install --no-cache-dir ipykernel
    
# Workaround for Tensorflow from Anaconda looking for libcuda.so.1
#ln -s /usr/local/cuda-9.2/targets/x86_64-linux/lib/stubs/libcuda.so /usr/local/cuda-9.2/targets/x86_64-linux/lib/stubs/libcuda.so.1

# Add packages that are also in system python via conda or pip
conda install -y -c anaconda scipy nose h5py scikit-image scikit-learn matplotlib pandas sympy virtualenv pygments sphinx

# Set locale in Singularity environment
echo 'export LC_ALL=C' >>$SINGULARITY_ENVIRONMENT
#Set PATH in Singularity environment  
echo 'export PATH=/opt/conda/bin:$PATH' >>$SINGULARITY_ENVIRONMENT
#echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-9.2/targets/x86_64-linux/lib/stubs/' >>$SINGULARITY_ENVIRONMENT
