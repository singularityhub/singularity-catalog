BootStrap: docker
From: nvidia/cudagl:11.4.2-base-ubuntu20.04

%post
        DEBIAN_FRONTEND=noninteractive apt-get update -y

        DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        dbus \
        fontconfig \
        gnupg \
        libasound2 \
        libfreetype6 \
        libglib2.0-0 \
        libnss3 \
        libsqlite3-0 \
        libx11-xcb1 \
        libxcb-glx0 \
        libxcb-xkb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxi6 \
        libxml2 \
        libxrandr2 \
        libxrender1 \
        libxtst6 \
        openssh-client \
        wget \
        xcb \
        xkb-data

        wget -qO - https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub | apt-key add -
        echo "deb https://developer.download.nvidia.com/devtools/repos/ubuntu2004/amd64/ /" >> /etc/apt/sources.list.d/nsight.list
        apt-get update -y
        DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends nsight-systems-2021.3.2

        DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends python3-pip python3-setuptools zip

        pip3 install --no-cache-dir jupyter
        pip3 install argparse
        pip3 install numpy scipy matplotlib ipython jupyter pandas sympy nose
        pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113
        rm -rf /var/lib/apt/lists/*

%environment
    export LC_ALL=C
    export __GLX_VENDOR_LIBRARY_NAME=nvidia

%runscript
    cd /stgcn_gan
    "$@"