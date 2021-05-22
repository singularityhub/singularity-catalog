Bootstrap: docker
from: nvidia/cuda:11.1-cudnn8-devel-ubuntu18.04

%post
    apt-get update && apt-get install -y --no-install-recommends \
             build-essential \
             cmake \
             git \
             curl \
             ca-certificates \
             libjpeg-dev \
             libpng-dev && \
         rm -rf /var/lib/apt/lists/*

%post
    curl -o ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
         chmod +x ~/miniconda.sh && \
         ~/miniconda.sh -b -p /opt/conda && \
         rm ~/miniconda.sh && \
         /opt/conda/bin/conda install -y python=$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include ninja cython typing && \
         /opt/conda/bin/conda install -y -c pytorch cudatoolkit=11.1 pytorch torchvision torchaudio&& \
         /opt/conda/bin/conda clean -ya

%environment
    PATH /opt/conda/bin:$PATH