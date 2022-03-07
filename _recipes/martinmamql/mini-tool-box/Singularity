# https://gist.github.com/vsoch/49709c8ed549155d0a15bde48e893588
# To build, run sudo singularity bootstrap pyg.img Singularity
Bootstrap: docker
From: ubuntu:18.04

%runscript
    . /torch/install/bin/torch-activate
    exec /bin/bash


%post

    # Directories for ATLAS
    mkdir -p /work

    apt-get update && apt-get install -y \
            python-pip python3-pip curl wget git tmux vim build-essential libssl-dev uuid-dev libgpgme11-dev squashfs-tools libseccomp-dev pkg-config python3-dev zip tar pciutils

    update-alternatives --install /usr/bin/python python /usr/bin/python3 1

    python -m pip install -U --force-reinstall pip
    python -m pip install --upgrade setuptools pip wheel


    pip install torch==1.8.1+cu102 torchvision==0.9.1+cu102 torchaudio==0.8.1 -f https://download.pytorch.org/whl/torch_stable.html

    pip install torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric -f https://data.pyg.org/whl/torch-1.8.1+cu102.html

    git clone https://github.com/abwilf/Factorized.git
    cd Factorized/
    pip install -r requirements.txt

    pip install jupyterlab numpy tqdm sklearn
