Bootstrap: docker
From: debian:latest

%environment
    export PATH="/opt/miniconda3/bin:$PATH"
    export PATH="/opt/miniconda3/envs/octree/bin:$PATH"

    export NUM_MKL_THREADS=1
    export OPENBLAS_NUM_THREADS=1
    export OPENMP_NUM_THREADS=1
    export OMP_NUM_THREADS=1

%runscript
    exec "$@"

%post
    apt update &&
    apt install -y build-essential \
    wget \
    bzip2 \
    ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    git \
    cmake \
    pkg-config \
    mesa-utils \
    libglu1-mesa-dev \
    freeglut3-dev \
    mesa-common-dev

    rm -rf /var/lib/apt/lists/*

    apt clean

    echo ". /opt/miniconda3/etc/profile.d/conda.sh" >> $SINGULARITY_ENVIRONMENT
    echo "conda activate /opt/miniconda3/envs/octree" >> $SINGULARITY_ENVIRONMENT

    wget -c https://repo.anaconda.com/miniconda/Miniconda3-py39_4.11.0-Linux-x86_64.sh 
    /bin/bash Miniconda3-py39_4.11.0-Linux-x86_64.sh -bfp /opt/miniconda3
    . /opt/miniconda3/etc/profile.d/conda.sh
    conda update conda

    git clone https://github.com/carshadi/pyktx.git
    git clone https://github.com/carshadi/tiff2octree.git
    cd tiff2octree/
    git checkout slurm
    conda env create -f environment.yml -p /opt/miniconda3/envs/octree
    conda activate /opt/miniconda3/envs/octree

    pip install ../pyktx/

    chmod --recursive a+rw /opt/miniconda3

    rm ../Miniconda3-py39_4.11.0-Linux-x86_64.sh
