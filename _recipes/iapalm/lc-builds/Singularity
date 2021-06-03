Bootstrap: docker
From: nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

%post
apt-get update && apt-get install -y \
    git \
    python3.5 \
    python3.5-dev \
    python3-pip \
    build-essential \
    cmake \
    wget \
    pkg-config \
    man-db \
    vim \
    eog \
    libopenblas-dev \
    liblapack-dev \
    gfortran \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgtk2.0-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev

python3 -m pip install --upgrade pip

python3 -m pip install ipython
python3 -m pip install jupyter
python3 -m pip install numpy
python3 -m pip install scipy
python3 -m pip install scikit-image
python3 -m pip install scikit-learn
python3 -m pip install dill
python3 -m pip install progressbar2
python3 -m pip install imageio
python3 -m pip install opencv-python
python3 -m pip install tqdm
python3 -m pip install protobuf
python3 -m pip install PyYAML
python3 -m pip install pandas
python3 -m pip install pathlib

wget --no-check-certificate https://download.pytorch.org/whl/cu90/torch-0.4.0-cp35-cp35m-linux_x86_64.whl
python3 -m pip install torch-0.4.0-cp35-cp35m-linux_x86_64.whl
python3 -m pip install torchvision
python3 -m pip install tensorboardX
python3 -m pip install tifffile
python3 -m pip install albumentations

