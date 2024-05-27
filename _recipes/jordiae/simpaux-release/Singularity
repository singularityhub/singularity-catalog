BootStrap: docker
From: pytorch/pytorch:1.2-cuda10.0-cudnn7-runtime

%post
    apt -y update
    apt -y upgrade
    apt -y install software-properties-common
    apt -y install vim unzip wget sudo
    apt -y install build-essential libssl-dev libffi-dev
    apt -y install libsm6
    apt -y install git

    # clean apt cache
    apt clean
    rm -rf /var/lib/apt/lists/*

    # set conda path
    export PATH="/opt/conda/bin:$PATH"

    conda install numpy scipy opencv matplotlib scikit-learn scikit-image \
    pandas tqdm imageio pytables h5py gitpython tensorboard
    conda install -c conda-forge ipdb
    pip install --no-cache-dir torchmeta future
    pip install --no-cache-dir git+https://github.com/epistimio/orion.git@develop

    # clean conda cache
    conda clean --all -y

%environment
    export PATH=/opt/conda/bin:$PATH

    # This works around a problem in ipdb
    export LC_ALL=C.UTF-8

%runscript
